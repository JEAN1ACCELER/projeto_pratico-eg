import 'entrega.dart';

class Tarefa {
  final String id;
  final String titulo;
  final String? descricao;
  final DateTime? prazo;
  final String status;
  final DateTime? dataConclusao;
  final String projetoId;
  final DateTime createdAt;
  final Entrega? entrega;

  Tarefa({
    required this.id,
    required this.titulo,
    this.descricao,
    this.prazo,
    required this.status,
    this.dataConclusao,
    required this.projetoId,
    required this.createdAt,
    this.entrega,
  });

  factory Tarefa.fromJson(Map<String, dynamic> json) {
    return Tarefa(
      id: json['id'] as String,
      titulo: json['titulo'] as String,
      descricao: json['descricao'] as String?,
      prazo: json['prazo'] != null ? DateTime.parse(json['prazo'] as String) : null,
      status: json['status'] as String,
      dataConclusao: json['dataConclusao'] != null ? DateTime.parse(json['dataConclusao'] as String) : null,
      projetoId: json['projetoId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      entrega: json['entrega'] != null ? Entrega.fromJson(json['entrega'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'prazo': prazo?.toIso8601String(),
    };
  }
}
