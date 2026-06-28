class User {
  final int? id;
  final String name;
  final String email;
  final String cpf;
  final String cns;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.cpf,
    required this.cns,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'cpf': cpf,
      'cns': cns,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      cpf: map['cpf'],
      cns: map['cns'],
    );
  }
}
