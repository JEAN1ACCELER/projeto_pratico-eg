import 'dart:convert';
import 'api_client.dart';
import '../models/notificacao.dart';

class NotificacaoService {
  final ApiClient _api = ApiClient();

  Future<List<Notificacao>> listar() async {
    final response = await _api.get('/notificacoes');
    if (response.statusCode != 200) throw Exception('Erro ao listar notificações');
    final list = jsonDecode(response.body) as List<dynamic>;
    return list.map((e) => Notificacao.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<int> contarNaoLidas() async {
    final response = await _api.get('/notificacoes/nao-lidas');
    if (response.statusCode != 200) return 0;
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    return body['count'] as int;
  }

  Future<void> marcarComoLida(String id) async {
    await _api.patch('/notificacoes/$id/lida');
  }

  Future<void> marcarTodasComoLidas() async {
    await _api.patch('/notificacoes/marcar-todas-lidas');
  }
}
