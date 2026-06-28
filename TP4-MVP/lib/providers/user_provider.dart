import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';

/// Provider de perfil do usuário.
class UserProvider extends ChangeNotifier {
  final UserRepository _repository;

  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;

  UserProvider({UserRepository? repository})
      : _repository = repository ?? UserRepository();

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Carrega o perfil do usuário pelo ID.
  Future<void> loadUser(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await _repository.findById(userId);
    } catch (e) {
      _errorMessage = 'Erro ao carregar perfil.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Atualiza o perfil do usuário.
  Future<bool> updateProfile({
    required String userId,
    String? name,
    String? cep,
    String? bloodType,
  }) async {
    if (_user == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      final updated = _user!.copyWith(
        name: name,
        cep: cep,
        bloodType: bloodType,
      );
      await _repository.save(updated);
      _user = updated;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Erro ao atualizar perfil.';
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
