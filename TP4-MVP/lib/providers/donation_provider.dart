import 'package:flutter/foundation.dart';
import '../models/donation_model.dart';
import '../repositories/donation_repository.dart';

/// Provider de doações.
class DonationProvider extends ChangeNotifier {
  final DonationRepository _repository;

  List<DonationModel> _donations = [];
  bool _isLoading = false;
  String? _errorMessage;
  Map<String, int> _stats = {};

  DonationProvider({DonationRepository? repository})
      : _repository = repository ?? DonationRepository();

  List<DonationModel> get donations => List.unmodifiable(_donations);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, int> get stats => Map.unmodifiable(_stats);

  /// Carrega as doações de um usuário.
  Future<void> loadDonations(String userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _donations = await _repository.findByUser(userId);
      _stats = await _repository.getStatsByUser(userId);
    } catch (e) {
      _errorMessage = 'Erro ao carregar doações.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Cria uma nova doação.
  Future<bool> createDonation({
    required String userId,
    required String donationType,
    required DateTime scheduledDate,
    String? location,
    String? notes,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final donation = await _repository.create(
        userId: userId,
        donationType: donationType,
        scheduledDate: scheduledDate,
        location: location,
        notes: notes,
      );
      _donations.insert(0, donation);
      _stats['total'] = (_stats['total'] ?? 0) + 1;
      _stats['pending'] = (_stats['pending'] ?? 0) + 1;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Erro ao criar doação.';
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Atualiza o status de uma doação.
  Future<void> updateStatus(String id, String status) async {
    try {
      final updated = await _repository.updateStatus(id, status);
      final index = _donations.indexWhere((d) => d.id == id);
      if (index != -1) {
        _donations[index] = updated;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Erro ao atualizar status.';
      notifyListeners();
    }
  }

  /// Remove uma doação.
  Future<void> deleteDonation(String id) async {
    try {
      await _repository.delete(id);
      _donations.removeWhere((d) => d.id == id);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Erro ao remover doação.';
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
