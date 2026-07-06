import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';
import '../config/constants.dart';
import 'io/file_saver.dart';

/// Serviço responsável por baixar e salvar/compartilhar PDFs gerados pela API.
class DocumentoService {
  static final DocumentoService _instance = DocumentoService._();
  factory DocumentoService() => _instance;
  DocumentoService._();

  /// Baixa o PDF de um projeto específico.
  Future<bool> baixarRelatorioProjeto(BuildContext context, String projetoId, String tituloProjeto) async {
    final url = '${ApiConfig.baseUrl}/documentos/relatorio/$projetoId';
    return _baixarESalvar(context, url, _sanitize(tituloProjeto, 'relatorio-projeto'));
  }

  /// Baixa o PDF consolidado de todos os projetos do usuário.
  Future<bool> baixarRelatorioGeral(BuildContext context) async {
    final url = '${ApiConfig.baseUrl}/documentos/relatorio-geral';
    return _baixarESalvar(context, url, 'relatorio-geral');
  }

  Future<bool> _baixarESalvar(BuildContext context, String url, String nomeArquivo) async {
    final messenger = ScaffoldMessenger.maybeOf(context);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(AppConstants.tokenKey);

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200 || response.bodyBytes.isEmpty) {
        messenger?.showSnackBar(const SnackBar(content: Text('Erro ao gerar relatório')));
        return false;
      }

      final bytes = response.bodyBytes;
      final ok = await fileSaver.salvar(bytes, '$nomeArquivo.pdf');

      if (ok) {
        messenger?.showSnackBar(SnackBar(
          content: Text('Relatório baixado (${_formatBytes(bytes.length)}) ✓'),
          backgroundColor: const Color(0xFF00663C),
        ));
      } else {
        messenger?.showSnackBar(const SnackBar(content: Text('Não foi possível salvar o arquivo')));
      }
      return ok;
    } catch (e) {
      messenger?.showSnackBar(SnackBar(content: Text('Erro: $e')));
      return false;
    }
  }

  String _sanitize(String s, String fallback) {
    final clean = s.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-').replaceAll(RegExp(r'^-|-$'), '');
    return clean.isEmpty ? fallback : clean;
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '${bytes}B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
  }
}
