import 'tarefa.dart';

class Projeto {
  final String id;
  final String titulo;
  final String modalidade;
  final String status;
  final DateTime dataInicio;
  final DateTime dataTermino;
  final String? resumo;
  final String orientadorId;
  final String orientandoId;
  final DateTime createdAt;

  // Campos opcionais (do include da API)
  final String? orientadorNome;
  final String? orientandoNome;
  final int totalTarefas;
  final int tarefasConcluidas;
  final int progresso;
  final List<Tarefa> tarefas;

  Projeto({
    required this.id,
    required this.titulo,
    required this.modalidade,
    required this.status,
    required this.dataInicio,
    required this.dataTermino,
    this.resumo,
    required this.orientadorId,
    required this.orientandoId,
    required this.createdAt,
    this.orientadorNome,
    this.orientandoNome,
    this.totalTarefas = 0,
    this.tarefasConcluidas = 0,
    this.progresso = 0,
    this.tarefas = const [],
  });

  factory Projeto.fromJson(Map<String, dynamic> json) {
    final tarefasRaw = json['tarefas'] as List<dynamic>?;
    final tarefas = tarefasRaw?.map((t) => Tarefa.fromJson(t as Map<String, dynamic>)).toList() ?? <Tarefa>[];

    final count = json['_count'] is Map ? (json['_count']['tarefas'] as int?) : null;

    return Projeto(
      id: json['id'] as String,
      titulo: json['titulo'] as String,
      modalidade: json['modalidade'] as String,
      status: json['status'] as String,
      dataInicio: DateTime.parse(json['dataInicio'] as String),
      dataTermino: DateTime.parse(json['dataTermino'] as String),
      resumo: json['resumo'] as String?,
      orientadorId: (json['orientadorId'] as String?) ?? (json['orientador']?['id'] ?? ''),
      orientandoId: (json['orientandoId'] as String?) ?? (json['orientando']?['id'] ?? ''),
      createdAt: DateTime.parse(json['createdAt'] as String),
      orientadorNome: json['orientador']?['nomeCompleto'] as String?,
      orientandoNome: json['orientando']?['nomeCompleto'] as String?,
      totalTarefas: json['totalTarefas'] as int? ?? count ?? tarefas.length,
      tarefasConcluidas: json['tarefasConcluidas'] as int? ?? tarefas.where((t) => t.status == 'CONCLUIDO').length,
      progresso: json['progresso'] as int? ?? 0,
      tarefas: tarefas,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'modalidade': modalidade,
      'status': status,
      'dataInicio': dataInicio.toIso8601String(),
      'dataTermino': dataTermino.toIso8601String(),
      'resumo': resumo,
      'orientandoId': orientandoId,
    };
  }
}
