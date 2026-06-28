import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../repositories/auth_repository.dart';
import '../utils/helpers.dart';

/// Estado de autenticação da aplicação.
enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

/// Provider de autenticação.
///
/// Refatoração #5 - Extract Provider:
/// O estado de autenticação foi extraído do widget e centralizado
/// neste ChangeNotifier, permitindo reatividade em toda a aplicação.
class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthStatus _status = AuthStatus.initial;
  UserModel? _currentUser;
  String? _errorMessage;

  AuthProvider({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepository();

  AuthStatus get status => _status;
  UserModel? get currentUser => _currentUser;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _status == AuthStatus.authenticated;

  /// Verifica o estado de autenticação ao iniciar o app.
  void checkAuthStatus() {
    if (_authRepository.isLoggedIn) {
      _currentUser = _authRepository.currentUser;
      _status = _currentUser != null
          ? AuthStatus.authenticated
          : AuthStatus.unauthenticated;
    } else {
      _status = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  /// Realiza o login do usuário.
  Future<bool> login(String email, String password) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = await _authRepository.login(email, password);

      if (user == null) {
        _status = AuthStatus.unauthenticated;
        _errorMessage = 'E-mail ou senha incorretos.';
        notifyListeners();
        return false;
      }

      _currentUser = user;
      _status = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = 'Erro ao realizar login. Tente novamente.';
      notifyListeners();
      return false;
    }
  }

  /// Registra um novo usuário e simula envio de e-mail (H6).
  Future<bool> register({
    required String name,
    required String email,
    required String cep,
    required String cns,
    required String password,
    String? bloodType,
  }) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      if (_authRepository.isEmailRegistered(email)) {
        _status = AuthStatus.unauthenticated;
        _errorMessage = 'Este e-mail já está cadastrado.';
        notifyListeners();
        return false;
      }

      final user = await _authRepository.register(
        name: name,
        email: email,
        cep: cep,
        cns: cns,
        password: password,
        bloodType: bloodType,
      );

      // H6: Simula envio de e-mail com guia de orientações
      Helpers.simulateEmailSend(
        toEmail: email,
        subject: 'Bem-vindo ao DoacaoMVP - Guia de Orientações',
        body: '''
Olá, $name!

Seu cadastro foi realizado com sucesso.
Aqui está o seu guia de orientações para iniciar o processo de doação de sangue:

1. Beba bastante água antes da doação.
2. Faça uma refeição leve antes de ir ao hemocentro.
3. Apresente um documento de identidade com foto.
4. Informe ao médico todos os medicamentos que estiver tomando.

Obrigado por ser um doador!
Equipe DoacaoMVP
''',
      );

      _currentUser = user;
      _status = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = 'Erro ao realizar cadastro. Tente novamente.';
      notifyListeners();
      return false;
    }
  }

  /// Realiza o logout do usuário.
  Future<void> logout() async {
    await _authRepository.logout();
    _currentUser = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
