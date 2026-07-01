/// Constantes globais do sistema DoacaoMVP.
///
/// Refatoração #6 - Replace Magic Numbers:
/// Substituição de números mágicos por constantes nomeadas,
/// melhorando a legibilidade e a manutenibilidade do código.
class AppConstants {
  // Validação de campos
  static const int minNameLength = 3;
  static const int minPasswordLength = 6;
  static const int cnsLength = 15;
  static const int cepLength = 9; // formato: 00000-000

  // Configurações de API
  static const String baseUrl = 'http://localhost:3000';
  static const int connectTimeout = 5000;
  static const int receiveTimeout = 10000;

  // Chaves de armazenamento (Hive)
  static const String userBoxName = 'users';
  static const String donationBoxName = 'donations';
  static const String authBoxName = 'auth';

  // Chaves de SharedPreferences
  static const String isLoggedInKey = 'is_logged_in';
  static const String currentUserIdKey = 'current_user_id';

  // Rotas
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home';
  static const String profileRoute = '/profile';
  static const String listRoute = '/list';
  static const String detailsRoute = '/details';
  static const String formRoute = '/form';
  static const String forgotPasswordRoute = '/forgot-password';

  // Mensagens de erro
  static const String invalidEmailMessage = 'Por favor, insira um e-mail válido.';
  static const String shortPasswordMessage =
      'A senha deve ter no mínimo $minPasswordLength caracteres.';
  static const String shortNameMessage =
      'O nome deve ter no mínimo $minNameLength caracteres.';
  static const String invalidCepMessage = 'CEP inválido. Use o formato 00000-000.';
  static const String invalidCnsMessage = 'CNS deve conter $cnsLength dígitos numéricos.';
  static const String requiredFieldMessage = 'Este campo é obrigatório.';
  static const String loginErrorMessage = 'E-mail ou senha incorretos.';
  static const String genericErrorMessage = 'Ocorreu um erro. Tente novamente.';

  // Mensagens de sucesso
  static const String loginSuccessMessage = 'Login realizado com sucesso!';
  static const String registerSuccessMessage = 'Cadastro realizado com sucesso!';
  static const String donationCreatedMessage = 'Doação registrada com sucesso!';
  static const String profileUpdatedMessage = 'Perfil atualizado com sucesso!';

  // Tipos de doação
  static const List<String> donationTypes = [
    'Sangue Total',
    'Plaquetas',
    'Plasma',
    'Medula Óssea',
  ];

  // Status de doação
  static const String statusPending = 'Pendente';
  static const String statusScheduled = 'Agendada';
  static const String statusCompleted = 'Concluída';
  static const String statusCancelled = 'Cancelada';
}
