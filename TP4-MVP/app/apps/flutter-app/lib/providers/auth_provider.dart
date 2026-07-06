import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/constants.dart';
import '../models/usuario.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  Usuario? _usuario;
  String? _papel;
  bool _isLoading = false;
  String? _errorMessage;

  Usuario? get usuario => _usuario;
  String? get papel => _papel;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _usuario != null;
  String? get errorMessage => _errorMessage;
  bool get isProfessor => _papel == 'PROFESSOR';
  bool get isAluno => _papel == 'ALUNO';
  bool get isAdmin => _papel == 'ADMINISTRADOR';

  /// Verifica sessão salva ao abrir o app.
  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AppConstants.tokenKey);
    if (token == null) return false;

    try {
      final user = await _authService.getMe();
      _usuario = user;
      _papel = user.papel;
      notifyListeners();
      return true;
    } catch (_) {
      await logout();
      return false;
    }
  }

  Future<bool> login(String email, String senha) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _authService.login(email, senha);
      _papel = result['usuario']['papel'] as String;
      _usuario = Usuario.fromJson(result['usuario'] as Map<String, dynamic>);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = _parseError(e);
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register({
    required String nomeCompleto,
    required String emailInstitucional,
    required String senha,
    required String papel,
    String? matricula,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _authService.register(
        nomeCompleto: nomeCompleto,
        emailInstitucional: emailInstitucional,
        senha: senha,
        papel: papel,
        matricula: matricula,
      );
      _papel = result['usuario']['papel'] as String;
      _usuario = Usuario.fromJson(result['usuario'] as Map<String, dynamic>);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = _parseError(e);
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _usuario = null;
    _papel = null;
    notifyListeners();
  }

  String _parseError(dynamic e) {
    final msg = e.toString();
    if (msg.contains('E-mail deve ser institucional')) return 'Use seu e-mail @ufam.edu.br';
    if (msg.contains('E-mail já cadastrado')) return 'Este e-mail já está cadastrado';
    if (msg.contains('Senha deve ter')) return 'Senha deve ter pelo menos 6 caracteres';
    if (msg.contains('E-mail ou senha incorretos')) return 'E-mail ou senha incorretos';
    return 'Ocorreu um erro. Tente novamente.';
  }
}
