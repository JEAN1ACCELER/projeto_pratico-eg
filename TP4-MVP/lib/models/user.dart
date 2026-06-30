class User {
  final int? id;
  final String name;
  final String email;
  final String cpf;
  final String cns;
  final String role; // 'donor' ou 'recipient'
  final DateTime createdAt;
  final bool acceptedTerms;
  final bool acceptedPrivacy;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.cpf,
    required this.cns,
    required this.role,
    required this.createdAt,
    required this.acceptedTerms,
    required this.acceptedPrivacy,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'cpf': cpf,
      'cns': cns,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
      'acceptedTerms': acceptedTerms ? 1 : 0,
      'acceptedPrivacy': acceptedPrivacy ? 1 : 0,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map["id"],
      name: map["name"],
      email: map["email"],
      cpf: map["cpf"],
      cns: map["cns"],
      role: map["role"],
      createdAt: DateTime.parse(map["createdAt"]),
      acceptedTerms: map["acceptedTerms"] == 1,
      acceptedPrivacy: map["acceptedPrivacy"] == 1,
    );
  }

  static bool isValidCpf(String cpf) {
    if (cpf.length != 11 || !RegExp(r'^\d{11}$').hasMatch(cpf)) {
      return false;
    }
    // Remove non-numeric characters
    cpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');

    // Teste de CPFs inválidos conhecidos
    if (cpf == "00000000000" ||
        cpf == "11111111111" ||
        cpf == "22222222222" ||
        cpf == "33333333333" ||
        cpf == "44444444444" ||
        cpf == "55555555555" ||
        cpf == "66666666666" ||
        cpf == "77777777777" ||
        cpf == "88888888888" ||
        cpf == "99999999999") {
      return false;
    }

    // Validação do primeiro dígito verificador
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(cpf[i]) * (10 - i);
    }
    int remainder = sum % 11;
    int digit1 = (remainder < 2) ? 0 : 11 - remainder;

    if (int.parse(cpf[9]) != digit1) {
      return false;
    }

    // Validação do segundo dígito verificador
    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += int.parse(cpf[i]) * (11 - i);
    }
    remainder = sum % 11;
    int digit2 = (remainder < 2) ? 0 : 11 - remainder;

    if (int.parse(cpf[10]) != digit2) {
      return false;
    }

    return true;
  }

  static bool isValidCns(String cns) {
    if (cns.length != 15 || !RegExp(r'^\d{15}$').hasMatch(cns)) {
      return false;
    }
    // Implementação da validação do CNS (simplificada para o MVP)
    // Para uma validação completa, seria necessário um algoritmo mais complexo.
    // Aqui, apenas verificamos o formato básico.
    return true;
  }
}
