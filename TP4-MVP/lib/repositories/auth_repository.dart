import '../models/user_model.dart';
import '../services/storage_service.dart';

/// Repositório de autenticação.
///
/// Refatoração #7 - Introduce Repository:
/// A lógica de autenticação foi abstraída neste repositório,
/// separando completamente a camada de dados da camada de UI.
class AuthRepository {
  final StorageService _storage;

  AuthRepository({StorageService? storage})
      : _storage = storage ?? StorageService.instance;

  /// Realiza login verificando e-mail e senha no armazenamento local.
  Future<UserModel?> login(String email, String password) async {
    final user = _storage.getUserByEmail(email);

    // Guard clause: retorna null imediatamente se usuário não encontrado
    if (user == null) return null;

    // Guard clause: verifica a senha (hash simples para MVP)
    if (user.passwordHash != _hashPassword(password)) return null;

    await _storage.setLoggedIn(user.id);
    return user;
  }

  /// Registra um novo usuário no armazenamento local.
  Future<UserModel> register({
    required String name,
    required String email,
    required String cep,
    required String cns,
    required String password,
    String? bloodType,
  }) async {
    final user = UserModel.create(
      name: name,
      email: email,
      cep: cep,
      cns: cns,
      passwordHash: _hashPassword(password),
      bloodType: bloodType,
    );

    await _storage.saveUser(user);
    await _storage.setLoggedIn(user.id);
    return user;
  }

  /// Realiza logout do usuário atual.
  Future<void> logout() async {
    await _storage.logout();
  }

  /// Verifica se há um usuário logado.
  bool get isLoggedIn => _storage.isLoggedIn;

  /// Retorna o usuário atualmente logado.
  UserModel? get currentUser {
    final userId = _storage.currentUserId;
    if (userId == null) return null;
    return _storage.getUserById(userId);
  }

  /// Verifica se um e-mail já está cadastrado.
  bool isEmailRegistered(String email) {
    return _storage.getUserByEmail(email) != null;
  }

  /// Hash simples de senha para o MVP (em produção, usar bcrypt ou similar).
  String _hashPassword(String password) {
    // Implementação simplificada para MVP
    return password.split('').reversed.join() + password.length.toString();
  }
}
