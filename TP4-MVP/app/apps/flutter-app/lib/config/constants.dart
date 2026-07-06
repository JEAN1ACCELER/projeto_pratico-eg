/// Constantes globais do E-Project (domínio acadêmico UFAM).
class AppConstants {
  AppConstants._();

  // Modalidades de projeto (UFAM)
  static const List<String> modalidades = [
    'PIBIC',
    'PIBITI',
    'PIBEX',
    'PACE',
    'POS_GRADUACAO',
  ];

  static const Map<String, String> modalidadeLabel = {
    'PIBIC': 'PIBIC — Iniciação Científica',
    'PIBITI': 'PIBITI — Iniciação em Desenvolvimento Tecnológico',
    'PIBEX': 'PIBEX — Extensão',
    'PACE': 'PACE — Ações Consolidadas e Extensionistas',
    'POS_GRADUACAO': 'Pós-Graduação',
  };

  // Papéis
  static const Map<String, String> papelLabel = {
    'PROFESSOR': 'Professor Orientador',
    'ALUNO': 'Aluno Orientando',
    'ADMINISTRADOR': 'Administrador',
  };

  // Status de projeto
  static const Map<String, String> statusProjetoLabel = {
    'EM_ANDAMENTO': 'Em Andamento',
    'PENDENTE': 'Pendente',
    'CONCLUIDO': 'Concluído',
    'CANCELADO': 'Cancelado',
  };

  // Status de tarefa (Kanban)
  static const Map<String, String> statusTarefaLabel = {
    'A_FAZER': 'A Fazer',
    'EM_ANDAMENTO': 'Em Andamento',
    'CONCLUIDO': 'Concluído',
  };

  // Avaliação de entrega
  static const Map<String, String> statusAvaliacaoLabel = {
    'PENDENTE': 'Aguardando Avaliação',
    'APROVADA': 'Aprovada',
    'NECESSITA_AJUSTE': 'Necessita Ajuste',
  };

  // Validação
  static const int minSenhaLength = 6;
  static const String sufixoEmailInstitucional = '@ufam.edu.br';

  // SharedPreferences keys
  static const String tokenKey = 'jwt_token';
  static const String userIdKey = 'user_id';
  static const String userNameKey = 'user_name';
  static const String userEmailKey = 'user_email';
  static const String userPapelKey = 'user_papel';
}
