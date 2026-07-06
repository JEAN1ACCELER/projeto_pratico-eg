import 'package:flutter/material.dart';
import '../models/notificacao.dart';
import '../services/notificacao_service.dart';

class NotificacaoProvider with ChangeNotifier {
  final NotificacaoService _service = NotificacaoService();

  List<Notificacao> _notificacoes = [];
  int _naoLidas = 0;
  bool _isLoading = false;

  List<Notificacao> get notificacoes => _notificacoes;
  int get naoLidas => _naoLidas;
  bool get isLoading => _isLoading;

  Future<void> carregar() async {
    _isLoading = true;
    notifyListeners();
    try {
      _notificacoes = await _service.listar();
      _naoLidas = await _service.contarNaoLidas();
    } catch (e) {
      debugPrint('Erro ao carregar notificações: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> marcarComoLida(String id) async {
    try {
      await _service.marcarComoLida(id);
      final idx = _notificacoes.indexWhere((n) => n.id == id);
      if (idx != -1) {
        _notificacoes[idx] = Notificacao(
          id: _notificacoes[idx].id,
          usuarioId: _notificacoes[idx].usuarioId,
          tipo: _notificacoes[idx].tipo,
          conteudo: _notificacoes[idx].conteudo,
          lida: true,
          dataEnvio: _notificacoes[idx].dataEnvio,
        );
        _naoLidas = _naoLidas > 0 ? _naoLidas - 1 : 0;
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Erro ao marcar como lida: $e');
    }
  }

  Future<void> marcarTodas() async {
    try {
      await _service.marcarTodasComoLidas();
      _notificacoes = _notificacoes.map((n) => Notificacao(
        id: n.id, usuarioId: n.usuarioId, tipo: n.tipo,
        conteudo: n.conteudo, lida: true, dataEnvio: n.dataEnvio,
      )).toList();
      _naoLidas = 0;
      notifyListeners();
    } catch (e) {
      debugPrint('Erro ao marcar todas: $e');
    }
  }
}
