class Reuniao {
  final String id;
  final String projetoId;
  final DateTime dataHora;
  final String? local;
  final String? resumo;
  final String? pinCheckIn;
  final List<Presenca> presencas;

  Reuniao({
    required this.id,
    required this.projetoId,
    required this.dataHora,
    this.local,
    this.resumo,
    this.pinCheckIn,
    this.presencas = const [],
  });

  factory Reuniao.fromJson(Map<String, dynamic> json) {
    final presencasRaw = json['presencas'] as List<dynamic>?;
    return Reuniao(
      id: json['id'] as String,
      projetoId: json['projetoId'] as String,
      dataHora: DateTime.parse(json['dataHora'] as String),
      local: json['local'] as String?,
      resumo: json['resumo'] as String?,
      pinCheckIn: json['pinCheckIn'] as String?,
      presencas: presencasRaw?.map((p) => Presenca.fromJson(p as Map<String, dynamic>)).toList() ?? [],
    );
  }
}

class Presenca {
  final String id;
  final String reuniaoId;
  final String usuarioId;
  final String usuarioNome;
  final DateTime createdAt;

  Presenca({
    required this.id,
    required this.reuniaoId,
    required this.usuarioId,
    required this.usuarioNome,
    required this.createdAt,
  });

  factory Presenca.fromJson(Map<String, dynamic> json) {
    return Presenca(
      id: json['id'] as String,
      reuniaoId: json['reuniaoId'] as String,
      usuarioId: (json['usuarioId'] as String?) ?? (json['usuario']?['id'] ?? ''),
      usuarioNome: json['usuario']?['nomeCompleto'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
