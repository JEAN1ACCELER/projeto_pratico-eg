import 'dart:convert';
import 'api_client.dart';
import '../models/edital.dart';

class EditalService {
  final ApiClient _api = ApiClient();

  Future<List<Edital>> listar() async {
    final response = await _api.get('/editais');
    if (response.statusCode != 200) throw Exception('Erro ao listar editais');
    final list = jsonDecode(response.body) as List<dynamic>;
    return list.map((e) => Edital.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Edital> buscarPorId(String id) async {
    final response = await _api.get('/editais/$id');
    if (response.statusCode != 200) throw Exception('Erro ao buscar edital');
    return Edital.fromJson(jsonDecode(response.body));
  }
}
