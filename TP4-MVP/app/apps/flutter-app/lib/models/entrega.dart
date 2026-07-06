class Entrega {
  final String id;
  final String tarefaId;
  final String? arquivoUrl;
  final String? comentarioAluno;
  final String? feedbackOrientador;
  final String statusAvaliacao;
  final DateTime dataEnvio;
  final DateTime? dataAvaliacao;

  Entrega({
    required this.id,
    required this.tarefaId,
    this.arquivoUrl,
    this.comentarioAluno,
    this.feedbackOrientador,
    required this.statusAvaliacao,
    required this.dataEnvio,
    this.dataAvaliacao,
  });

  factory Entrega.fromJson(Map<String, dynamic> json) {
    return Entrega(
      id: json['id'] as String,
      tarefaId: json['tarefaId'] as String,
      arquivoUrl: json['arquivoUrl'] as String?,
      comentarioAluno: json['comentarioAluno'] as String?,
      feedbackOrientador: json['feedbackOrientador'] as String?,
      statusAvaliacao: json['statusAvaliacao'] as String,
      dataEnvio: DateTime.parse(json['dataEnvio'] as String),
      dataAvaliacao: json['dataAvaliacao'] != null ? DateTime.parse(json['dataAvaliacao'] as String) : null,
    );
  }
}
