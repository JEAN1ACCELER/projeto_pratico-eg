import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';
import '../config/constants.dart';
import '../models/usuario.dart';

class AuthService {
  final http.Client _client = http.Client();

  Future<Map<String, dynamic>> register({
    required String nomeCompleto,
    required String emailInstitucional,
    required String senha,
    required String papel,
    String? matricula,
    String? departamento,
    bool aceiteTermos = true,
    bool aceitePrivacidade = true,
  }) async {
    final response = await _client.post(
      Uri.parse('${ApiConfig.baseUrl}/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nomeCompleto': nomeCompleto,
        'emailInstitucional': emailInstitucional,
        'senha': senha,
        'papel': papel,
        'matricula': matricula,
        'departamento': departamento,
        'aceiteTermos': aceiteTermos,
        'aceitePrivacidade': aceitePrivacidade,
      }),
    );

    final body = jsonDecode(response.body);
    if (response.statusCode != 201) {
      throw Exception(body['error'] ?? 'Erro ao criar conta');
    }

    await _saveSession(body);
    return body;
  }

  Future<Map<String, dynamic>> login(String email, String senha) async {
    final response = await _client.post(
      Uri.parse('${ApiConfig.baseUrl}/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'emailInstitucional': email, 'senha': senha}),
    );

    final body = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw Exception(body['error'] ?? 'Erro ao fazer login');
    }

    await _saveSession(body);
    return body;
  }

  Future<Usuario> getMe() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AppConstants.tokenKey);
    if (token == null) throw Exception('Não autenticado');

    final response = await _client.get(
      Uri.parse('${ApiConfig.baseUrl}/auth/me'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar usuário');
    }

    return Usuario.fromJson(jsonDecode(response.body));
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.tokenKey);
    await prefs.remove(AppConstants.userIdKey);
    await prefs.remove(AppConstants.userNameKey);
    await prefs.remove(AppConstants.userEmailKey);
    await prefs.remove(AppConstants.userPapelKey);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.tokenKey) != null;
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.tokenKey);
  }

  Future<String?> getUserPapel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.userPapelKey);
  }

  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.userNameKey);
  }

  Future<void> _saveSession(Map<String, dynamic> body) async {
    final prefs = await SharedPreferences.getInstance();
    final usuario = body['usuario'] as Map<String, dynamic>;
    await prefs.setString(AppConstants.tokenKey, body['token'] as String);
    await prefs.setString(AppConstants.userIdKey, usuario['id'] as String);
    await prefs.setString(AppConstants.userNameKey, usuario['nomeCompleto'] as String);
    await prefs.setString(AppConstants.userEmailKey, usuario['emailInstitucional'] as String);
    await prefs.setString(AppConstants.userPapelKey, usuario['papel'] as String);
  }
}
