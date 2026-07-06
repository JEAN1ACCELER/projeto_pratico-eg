import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';
import '../config/constants.dart';

/// Cliente HTTP central que gerencia o token JWT.
class ApiClient {
  static final ApiClient _instance = ApiClient._();
  factory ApiClient() => _instance;
  ApiClient._();

  String? _token;

  Future<String?> get token async {
    if (_token == null) {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString(AppConstants.tokenKey);
    }
    return _token;
  }

  Future<void> setToken(String? value) async {
    _token = value;
    final prefs = await SharedPreferences.getInstance();
    if (value != null) {
      await prefs.setString(AppConstants.tokenKey, value);
    } else {
      await prefs.remove(AppConstants.tokenKey);
      await prefs.remove(AppConstants.userIdKey);
      await prefs.remove(AppConstants.userNameKey);
      await prefs.remove(AppConstants.userEmailKey);
      await prefs.remove(AppConstants.userPapelKey);
    }
  }

  Future<Map<String, String>> _headers() async {
    final t = await token;
    return {
      'Content-Type': 'application/json',
      if (t != null) 'Authorization': 'Bearer $t',
    };
  }

  Future<http.Response> get(String path) async {
    return http.get(
      Uri.parse('${ApiConfig.baseUrl}$path'),
      headers: await _headers(),
    );
  }

  Future<http.Response> post(String path, {Map<String, dynamic>? body}) async {
    return http.post(
      Uri.parse('${ApiConfig.baseUrl}$path'),
      headers: await _headers(),
      body: body != null ? jsonEncode(body) : null,
    );
  }

  Future<http.Response> put(String path, {Map<String, dynamic>? body}) async {
    return http.put(
      Uri.parse('${ApiConfig.baseUrl}$path'),
      headers: await _headers(),
      body: body != null ? jsonEncode(body) : null,
    );
  }

  Future<http.Response> patch(String path, {Map<String, dynamic>? body}) async {
    return http.patch(
      Uri.parse('${ApiConfig.baseUrl}$path'),
      headers: await _headers(),
      body: body != null ? jsonEncode(body) : null,
    );
  }

  Future<http.Response> delete(String path) async {
    return http.delete(
      Uri.parse('${ApiConfig.baseUrl}$path'),
      headers: await _headers(),
    );
  }

  /// GET que retorna bytes (usado para download de PDF).
  Future<http.Response> getBytes(String path) async {
    return http.get(
      Uri.parse('${ApiConfig.baseUrl}$path'),
      headers: await _headers(),
    );
  }
}
