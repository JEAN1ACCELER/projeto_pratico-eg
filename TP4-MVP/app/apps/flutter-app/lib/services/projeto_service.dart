import 'dart:convert';
import 'api_client.dart';
import '../models/projeto.dart';

class ProjetoService {
  final ApiClient _api = ApiClient();

  Future<List<Projeto>> listar() async {
    final response = await _api.get('/projetos');
    if (response.statusCode != 200) {
      throw Exception('Erro ao listar projetos');
    }
    final list = jsonDecode(response.body) as List<dynamic>;
    return list.map((e) => Projeto.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Projeto> buscarPorId(String id) async {
    final response = await _api.get('/projetos/$id');
    if (response.statusCode != 200) throw Exception('Erro ao buscar projeto');
    return Projeto.fromJson(jsonDecode(response.body));
  }

  Future<Projeto> criar(Map<String, dynamic> data) async {
    final response = await _api.post('/projetos', body: data);
    if (response.statusCode != 201) {
      final body = jsonDecode(response.body);
      throw Exception(body['error'] ?? 'Erro ao criar projeto');
    }
    return Projeto.fromJson(jsonDecode(response.body));
  }

  Future<Projeto> atualizar(String id, Map<String, dynamic> data) async {
    final response = await _api.put('/projetos/$id', body: data);
    if (response.statusCode != 200) throw Exception('Erro ao atualizar projeto');
    return Projeto.fromJson(jsonDecode(response.body));
  }

  Future<void> atualizarStatus(String id, String status) async {
    final response = await _api.patch('/projetos/$id/status', body: {'status': status});
    if (response.statusCode != 200) throw Exception('Erro ao atualizar status');
  }

  Future<List<Projeto>> historico() async {
    final response = await _api.get('/projetos/historico');
    if (response.statusCode != 200) throw Exception('Erro ao buscar histórico');
    final list = jsonDecode(response.body) as List<dynamic>;
    return list.map((e) => Projeto.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<Map<String, dynamic>>> listarTodos() async {
    final response = await _api.get('/projetos');
    if (response.statusCode != 200) throw Exception('Erro ao listar projetos');
    return (jsonDecode(response.body) as List<dynamic>).cast<Map<String, dynamic>>();
  }
}
