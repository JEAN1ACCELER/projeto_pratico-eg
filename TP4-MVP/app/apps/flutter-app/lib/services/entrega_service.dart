import 'dart:convert';
import 'api_client.dart';
import '../models/entrega.dart';

class EntregaService {
  final ApiClient _api = ApiClient();

  Future<Entrega?> buscarPorTarefa(String tarefaId) async {
    final response = await _api.get('/entregas/tarefa/$tarefaId');
    if (response.statusCode == 404) return null;
    if (response.statusCode != 200) throw Exception('Erro ao buscar entrega');
    return Entrega.fromJson(jsonDecode(response.body));
  }

  Future<Entrega> submeter(String tarefaId, {String? comentarioAluno}) async {
    final response = await _api.post('/entregas/tarefa/$tarefaId', body: {
      if (comentarioAluno != null) 'comentarioAluno': comentarioAluno,
    });
    if (response.statusCode != 201) {
      final body = jsonDecode(response.body);
      throw Exception(body['error'] ?? 'Erro ao submeter entrega');
    }
    return Entrega.fromJson(jsonDecode(response.body));
  }

  Future<Entrega> avaliar(String entregaId, String feedbackOrientador, String statusAvaliacao) async {
    final response = await _api.patch('/entregas/$entregaId/avaliar', body: {
      'feedbackOrientador': feedbackOrientador,
      'statusAvaliacao': statusAvaliacao,
    });
    if (response.statusCode != 200) throw Exception('Erro ao avaliar entrega');
    return Entrega.fromJson(jsonDecode(response.body));
  }
}
