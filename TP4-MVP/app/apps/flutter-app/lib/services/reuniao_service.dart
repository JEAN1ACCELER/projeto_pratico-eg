import 'dart:convert';
import 'api_client.dart';
import '../models/reuniao.dart';

class ReuniaoService {
  final ApiClient _api = ApiClient();

  Future<List<Reuniao>> listarPorProjeto(String projetoId) async {
    final response = await _api.get('/reunioes/projeto/$projetoId');
    if (response.statusCode != 200) throw Exception('Erro ao listar reuniões');
    final list = jsonDecode(response.body) as List<dynamic>;
    return list.map((e) => Reuniao.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Reuniao> criar(String projetoId, Map<String, dynamic> data) async {
    final response = await _api.post('/reunioes/projeto/$projetoId', body: data);
    if (response.statusCode != 201) throw Exception('Erro ao criar reunião');
    return Reuniao.fromJson(jsonDecode(response.body));
  }

  Future<void> checkIn(String reuniaoId, String pin) async {
    final response = await _api.post('/reunioes/$reuniaoId/checkin', body: {'pin': pin});
    if (response.statusCode != 201) {
      final body = jsonDecode(response.body);
      throw Exception(body['error'] ?? 'Erro ao registrar check-in');
    }
  }

  Future<List<Presenca>> listarPresencas(String reuniaoId) async {
    final response = await _api.get('/reunioes/$reuniaoId/presencas');
    if (response.statusCode != 200) throw Exception('Erro ao listar presenças');
    final list = jsonDecode(response.body) as List<dynamic>;
    return list.map((e) => Presenca.fromJson(e as Map<String, dynamic>)).toList();
  }
}
