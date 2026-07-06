class Usuario {
  final String id;
  final String nomeCompleto;
  final String emailInstitucional;
  final String papel;
  final String? matricula;
  final String? departamento;
  final DateTime dataCadastro;
  final bool ativo;

  Usuario({
    required this.id,
    required this.nomeCompleto,
    required this.emailInstitucional,
    required this.papel,
    this.matricula,
    this.departamento,
    required this.dataCadastro,
    required this.ativo,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] as String,
      nomeCompleto: json['nomeCompleto'] as String,
      emailInstitucional: json['emailInstitucional'] as String,
      papel: json['papel'] as String,
      matricula: json['matricula'] as String?,
      departamento: json['departamento'] as String?,
      dataCadastro: DateTime.parse(json['dataCadastro'] as String),
      ativo: json['ativo'] as bool? ?? true,
    );
  }
}
