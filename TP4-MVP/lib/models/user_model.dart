import 'package:hive/hive.dart';

part 'user_model.g.dart';

/// Modelo de dados do usuário.
///
/// Refatoração #3 - Introduce Parameter Object:
/// Os parâmetros de criação de usuário foram agrupados neste objeto,
/// evitando métodos com muitos parâmetros espalhados pelo código.
@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String cep;

  @HiveField(4)
  final String cns;

  @HiveField(5)
  final String passwordHash;

  @HiveField(6)
  final DateTime createdAt;

  @HiveField(7)
  final String? bloodType;

  @HiveField(8)
  final int totalDonations;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.cep,
    required this.cns,
    required this.passwordHash,
    required this.createdAt,
    this.bloodType,
    this.totalDonations = 0,
  });

  /// Factory para criação de um novo usuário a partir dos dados do formulário.
  factory UserModel.create({
    required String name,
    required String email,
    required String cep,
    required String cns,
    required String passwordHash,
    String? bloodType,
  }) {
    return UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      cep: cep,
      cns: cns,
      passwordHash: passwordHash,
      createdAt: DateTime.now(),
      bloodType: bloodType,
    );
  }

  /// Cria uma cópia do modelo com campos atualizados.
  UserModel copyWith({
    String? name,
    String? email,
    String? cep,
    String? cns,
    String? bloodType,
    int? totalDonations,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      cep: cep ?? this.cep,
      cns: cns ?? this.cns,
      passwordHash: passwordHash,
      createdAt: createdAt,
      bloodType: bloodType ?? this.bloodType,
      totalDonations: totalDonations ?? this.totalDonations,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'cep': cep,
        'cns': cns,
        'createdAt': createdAt.toIso8601String(),
        'bloodType': bloodType,
        'totalDonations': totalDonations,
      };

  @override
  String toString() => 'UserModel(id: $id, name: $name, email: $email)';
}
