import '../models/donation_model.dart';
import '../services/storage_service.dart';
import '../utils/constants.dart';

/// Repositório de doações.
class DonationRepository {
  final StorageService _storage;

  DonationRepository({StorageService? storage})
      : _storage = storage ?? StorageService.instance;

  Future<DonationModel> create({
    required String userId,
    required String donationType,
    required DateTime scheduledDate,
    String? location,
    String? notes,
  }) async {
    final donation = DonationModel.create(
      userId: userId,
      donationType: donationType,
      scheduledDate: scheduledDate,
      location: location,
      notes: notes,
    );
    await _storage.saveDonation(donation);
    return donation;
  }

  Future<List<DonationModel>> findByUser(String userId) async {
    return _storage.getDonationsByUser(userId);
  }

  Future<List<DonationModel>> findAll() async {
    return _storage.getAllDonations();
  }

  Future<DonationModel?> findById(String id) async {
    return _storage.getDonationById(id);
  }

  Future<DonationModel> updateStatus(String id, String status) async {
    final donation = _storage.getDonationById(id);
    if (donation == null) {
      throw Exception('Doação não encontrada: $id');
    }
    final updated = donation.copyWith(status: status);
    await _storage.saveDonation(updated);
    return updated;
  }

  Future<void> delete(String id) async {
    await _storage.deleteDonation(id);
  }

  /// Retorna estatísticas de doações de um usuário.
  Future<Map<String, int>> getStatsByUser(String userId) async {
    final donations = await findByUser(userId);
    return {
      'total': donations.length,
      'completed': donations.where((d) => d.status == AppConstants.statusCompleted).length,
      'pending': donations.where((d) => d.status == AppConstants.statusPending).length,
      'scheduled': donations.where((d) => d.status == AppConstants.statusScheduled).length,
    };
  }
}
