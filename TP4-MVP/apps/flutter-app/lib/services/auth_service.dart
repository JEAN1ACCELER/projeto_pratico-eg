import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:tp4_mvp/models/user.dart';
import 'package:tp4_mvp/services/database_service.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = await DatabaseService.instance.getUserByEmail(email);
      if (user == null) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // Validar senha (em produção, usar hash seguro)
      final hashedPassword = sha256.convert(utf8.encode(password)).toString();
      final storedPassword = await DatabaseService.instance.getPasswordHash(email);

      if (storedPassword != hashedPassword) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      _currentUser = user;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signup(User user, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final hashedPassword = sha256.convert(utf8.encode(password)).toString();
      await DatabaseService.instance.insertUser(user);
      await DatabaseService.instance.savePasswordHash(user.email, hashedPassword);

      _currentUser = user;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    notifyListeners();
  }
}
