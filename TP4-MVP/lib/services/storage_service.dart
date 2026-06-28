import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_model.dart';
import '../models/donation_model.dart';
import '../utils/constants.dart';

/// Serviço de persistência local utilizando Hive.
///
/// Refatoração #7 - Introduce Repository:
/// A lógica de persistência foi abstraída neste serviço,
/// separando a camada de dados da camada de UI.
///
/// Implementa o padrão Singleton para garantir uma única instância.
class StorageService {
  static StorageService? _instance;

  StorageService._();

  /// Retorna a instância única do serviço (Singleton Pattern).
  static StorageService get instance {
    _instance ??= StorageService._();
    return _instance!;
  }

  late Box<UserModel> _userBox;
  late Box<DonationModel> _donationBox;
  late Box<dynamic> _authBox;

  /// Inicializa o Hive e registra os adapters.
  Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserModelAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(DonationModelAdapter());
    }

    _userBox = await Hive.openBox<UserModel>(AppConstants.userBoxName);
    _donationBox = await Hive.openBox<DonationModel>(AppConstants.donationBoxName);
    _authBox = await Hive.openBox<dynamic>(AppConstants.authBoxName);
  }

  // ---- Operações de Usuário ----

  Future<void> saveUser(UserModel user) async {
    await _userBox.put(user.id, user);
  }

  UserModel? getUserById(String id) => _userBox.get(id);

  UserModel? getUserByEmail(String email) {
    try {
      return _userBox.values.firstWhere(
        (user) => user.email.toLowerCase() == email.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }

  List<UserModel> getAllUsers() => _userBox.values.toList();

  Future<void> deleteUser(String id) async {
    await _userBox.delete(id);
  }

  // ---- Operações de Doação ----

  Future<void> saveDonation(DonationModel donation) async {
    await _donationBox.put(donation.id, donation);
  }

  DonationModel? getDonationById(String id) => _donationBox.get(id);

  List<DonationModel> getDonationsByUser(String userId) {
    return _donationBox.values
        .where((d) => d.userId == userId)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  List<DonationModel> getAllDonations() => _donationBox.values.toList();

  Future<void> deleteDonation(String id) async {
    await _donationBox.delete(id);
  }

  // ---- Operações de Autenticação ----

  Future<void> setLoggedIn(String userId) async {
    await _authBox.put(AppConstants.isLoggedInKey, true);
    await _authBox.put(AppConstants.currentUserIdKey, userId);
  }

  Future<void> logout() async {
    await _authBox.delete(AppConstants.isLoggedInKey);
    await _authBox.delete(AppConstants.currentUserIdKey);
  }

  bool get isLoggedIn => _authBox.get(AppConstants.isLoggedInKey, defaultValue: false) as bool;

  String? get currentUserId =>
      _authBox.get(AppConstants.currentUserIdKey) as String?;
}
