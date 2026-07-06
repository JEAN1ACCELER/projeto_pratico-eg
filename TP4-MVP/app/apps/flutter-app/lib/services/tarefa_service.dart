import 'dart:convert';
import 'api_client.dart';
import '../models/tarefa.dart';

class TarefaService {
  final ApiClient _api = ApiClient();

  Future<List<Tarefa>> listarPorProjeto(String projetoId) async {
    final response = await _api.get('/tarefas/projeto/$projetoId');
    if (response.statusCode != 200) throw Exception('Erro ao listar tarefas');
    final list = jsonDecode(response.body) as List<dynamic>;
    return list.map((e) => Tarefa.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Tarefa> criar(String projetoId, Map<String, dynamic> data) async {
    final response = await _api.post('/tarefas/projeto/$projetoId', body: data);
    if (response.statusCode != 201) throw Exception('Erro ao criar tarefa');
    return Tarefa.fromJson(jsonDecode(response.body));
  }

  Future<Tarefa> atualizar(String id, Map<String, dynamic> data) async {
    final response = await _api.put('/tarefas/$id', body: data);
    if (response.statusCode != 200) throw Exception('Erro ao atualizar tarefa');
    return Tarefa.fromJson(jsonDecode(response.body));
  }

  Future<void> atualizarStatus(String id, String status) async {
    final response = await _api.patch('/tarefas/$id/status', body: {'status': status});
    if (response.statusCode != 200) throw Exception('Erro ao atualizar tarefa');
  }

  Future<void> excluir(String id) async {
    final response = await _api.delete('/tarefas/$id');
    if (response.statusCode != 200) throw Exception('Erro ao excluir tarefa');
  }

  Future<Tarefa> buscarPorId(String id) async {
    final response = await _api.get('/tarefas/$id');
    if (response.statusCode != 200) throw Exception('Erro ao buscar tarefa');
    return Tarefa.fromJson(jsonDecode(response.body));
  }
}
