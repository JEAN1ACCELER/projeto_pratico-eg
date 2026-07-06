import 'package:flutter/material.dart';
import '../models/projeto.dart';
import '../services/projeto_service.dart';

class ProjetoProvider with ChangeNotifier {
  final ProjetoService _service = ProjetoService();
  ProjetoService get service => _service;

  List<Projeto> _projetos = [];
  Projeto? _projetoSelecionado;
  List<Projeto> _historico = [];
  bool _isLoading = false;

  List<Projeto> get projetos => _projetos;
  Projeto? get projetoSelecionado => _projetoSelecionado;
  List<Projeto> get historico => _historico;
  bool get isLoading => _isLoading;

  Future<void> carregarProjetos() async {
    _isLoading = true;
    notifyListeners();
    try {
      _projetos = await _service.listar();
    } catch (e) {
      debugPrint('Erro ao carregar projetos: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> carregarHistorico() async {
    try {
      _historico = await _service.historico();
      notifyListeners();
    } catch (e) {
      debugPrint('Erro ao carregar histórico: $e');
    }
  }

  Future<void> carregarDetalhe(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      _projetoSelecionado = await _service.buscarPorId(id);
    } catch (e) {
      debugPrint('Erro ao carregar detalhe: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> criar(Map<String, dynamic> data) async {
    try {
      final novo = await _service.criar(data);
      _projetos.insert(0, novo);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Erro ao criar projeto: $e');
      return false;
    }
  }

  Future<void> atualizarStatus(String id, String status) async {
    try {
      await _service.atualizarStatus(id, status);
      final idx = _projetos.indexWhere((p) => p.id == id);
      if (idx != -1) {
        _projetos[idx] = Projeto.fromJson({..._projetos[idx].toJson(), 'status': status, 'id': id});
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Erro ao atualizar status: $e');
    }
  }
}
