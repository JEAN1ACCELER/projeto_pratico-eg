import 'package:flutter/material.dart';

class Notificacao {
  final String id;
  final String usuarioId;
  final String tipo;
  final String conteudo;
  final bool lida;
  final DateTime dataEnvio;

  Notificacao({
    required this.id,
    required this.usuarioId,
    required this.tipo,
    required this.conteudo,
    required this.lida,
    required this.dataEnvio,
  });

  factory Notificacao.fromJson(Map<String, dynamic> json) {
    return Notificacao(
      id: json['id'] as String,
      usuarioId: json['usuarioId'] as String,
      tipo: json['tipo'] as String,
      conteudo: json['conteudo'] as String,
      lida: json['lida'] as bool? ?? false,
      dataEnvio: DateTime.parse(json['dataEnvio'] as String),
    );
  }

  IconData get icon {
    switch (tipo) {
      case 'NOVA_TAREFA':
        return Icons.assignment;
      case 'PRAZO_PROXIMO':
        return Icons.schedule;
      case 'STATUS_PROJETO':
        return Icons.folder_shared;
      case 'NOVO_EDITAL':
        return Icons.campaign;
      case 'PRESENCA_IRREGULAR':
        return Icons.warning;
      case 'FEEDBACK_ENTREGA':
        return Icons.rate_review;
      default:
        return Icons.notifications;
    }
  }
}
