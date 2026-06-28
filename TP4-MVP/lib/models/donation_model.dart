import 'package:hive/hive.dart';
import '../utils/constants.dart';

part 'donation_model.g.dart';

/// Modelo de dados de uma doação de sangue.
@HiveType(typeId: 1)
class DonationModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final String donationType;

  @HiveField(3)
  final DateTime scheduledDate;

  @HiveField(4)
  final String status;

  @HiveField(5)
  final String? location;

  @HiveField(6)
  final String? notes;

  @HiveField(7)
  final DateTime createdAt;

  DonationModel({
    required this.id,
    required this.userId,
    required this.donationType,
    required this.scheduledDate,
    required this.status,
    this.location,
    this.notes,
    required this.createdAt,
  });

  /// Factory para criação de uma nova doação.
  factory DonationModel.create({
    required String userId,
    required String donationType,
    required DateTime scheduledDate,
    String? location,
    String? notes,
  }) {
    return DonationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      donationType: donationType,
      scheduledDate: scheduledDate,
      status: AppConstants.statusPending,
      location: location,
      notes: notes,
      createdAt: DateTime.now(),
    );
  }

  /// Cria uma cópia com campos atualizados.
  DonationModel copyWith({
    String? donationType,
    DateTime? scheduledDate,
    String? status,
    String? location,
    String? notes,
  }) {
    return DonationModel(
      id: id,
      userId: userId,
      donationType: donationType ?? this.donationType,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      status: status ?? this.status,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'donationType': donationType,
        'scheduledDate': scheduledDate.toIso8601String(),
        'status': status,
        'location': location,
        'notes': notes,
        'createdAt': createdAt.toIso8601String(),
      };

  @override
  String toString() =>
      'DonationModel(id: $id, type: $donationType, status: $status)';
}
