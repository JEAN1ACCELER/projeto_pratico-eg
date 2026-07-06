class Edital {
  final String id;
  final String titulo;
  final String? descricao;
  final String? modalidade;
  final String? fonte;
  final String? linkOriginal;
  final DateTime dataPublicacao;
  final DateTime? dataEncerramento;
  final bool ativo;

  Edital({
    required this.id,
    required this.titulo,
    this.descricao,
    this.modalidade,
    this.fonte,
    this.linkOriginal,
    required this.dataPublicacao,
    this.dataEncerramento,
    required this.ativo,
  });

  factory Edital.fromJson(Map<String, dynamic> json) {
    return Edital(
      id: json['id'] as String,
      titulo: json['titulo'] as String,
      descricao: json['descricao'] as String?,
      modalidade: json['modalidade'] as String?,
      fonte: json['fonte'] as String?,
      linkOriginal: json['linkOriginal'] as String?,
      dataPublicacao: DateTime.parse(json['dataPublicacao'] as String),
      dataEncerramento: json['dataEncerramento'] != null ? DateTime.parse(json['dataEncerramento'] as String) : null,
      ativo: json['ativo'] as bool? ?? true,
    );
  }
}
