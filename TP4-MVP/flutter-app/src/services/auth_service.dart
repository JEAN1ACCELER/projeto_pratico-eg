import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../models/user.dart';
import 'database_service.dart';

class AuthService {
  final DatabaseService _dbService = DatabaseService();

  String _hashPassword(String password) {
    var bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  Future<bool> register(User user, String password) async {
    final db = await _dbService.database;
    
    int userId = await db.insert('users', user.toMap());
    await db.insert('passwords', {
      'user_id': userId,
      'password_hash': _hashPassword(password),
    });
    
    return userId > 0;
  }

  Future<User?> login(String email, String password) async {
    final db = await _dbService.database;
    
    List<Map<String, dynamic>> users = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (users.isEmpty) return null;

    int userId = users.first['id'];
    List<Map<String, dynamic>> passwords = await db.query(
      'passwords',
      where: 'user_id = ? AND password_hash = ?',
      whereArgs: [userId, _hashPassword(password)],
    );

    if (passwords.isNotEmpty) {
      return User.fromMap(users.first);
    }
    
    return null;
  }
}
