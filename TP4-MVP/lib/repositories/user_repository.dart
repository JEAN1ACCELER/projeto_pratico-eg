import '../models/user_model.dart';
import '../services/storage_service.dart';

/// Repositório de usuários.
class UserRepository {
  final StorageService _storage;

  UserRepository({StorageService? storage})
      : _storage = storage ?? StorageService.instance;

  Future<UserModel?> findById(String id) async {
    return _storage.getUserById(id);
  }

  Future<UserModel?> findByEmail(String email) async {
    return _storage.getUserByEmail(email);
  }

  Future<List<UserModel>> findAll() async {
    return _storage.getAllUsers();
  }

  Future<void> save(UserModel user) async {
    await _storage.saveUser(user);
  }

  Future<void> delete(String id) async {
    await _storage.deleteUser(id);
  }

  Future<UserModel> update(UserModel user) async {
    await _storage.saveUser(user);
    return user;
  }
}
