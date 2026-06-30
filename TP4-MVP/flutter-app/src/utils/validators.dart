import 'constants.dart';

/// Serviço de validação de campos de formulário.
///
/// Refatoração #2 - Extract Method:
/// A lógica de validação foi extraída de métodos com múltiplas
/// responsabilidades e centralizada nesta classe, separando
/// validação, formatação e persistência.
class Validators {
  // Construtor privado para impedir instanciação (Singleton-like utility)
  Validators._();

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp _cepRegex = RegExp(r'^\d{5}-\d{3}$');

  static final RegExp _cnsRegex = RegExp(r'^\d{15}$');

  /// Valida se o campo está preenchido.
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppConstants.requiredFieldMessage;
    }
    return null;
  }

  /// Valida o nome completo (mínimo 3 caracteres).
  static String? validateName(String? value) {
    final requiredError = required(value);
    if (requiredError != null) return requiredError;

    if (value!.trim().length < AppConstants.minNameLength) {
      return AppConstants.shortNameMessage;
    }
    return null;
  }

  /// Valida o formato do e-mail usando regex.
  static String? validateEmail(String? value) {
    final requiredError = required(value);
    if (requiredError != null) return requiredError;

    if (!_emailRegex.hasMatch(value!.trim())) {
      return AppConstants.invalidEmailMessage;
    }
    return null;
  }

  /// Valida a senha (mínimo 6 caracteres).
  static String? validatePassword(String? value) {
    final requiredError = required(value);
    if (requiredError != null) return requiredError;

    if (value!.length < AppConstants.minPasswordLength) {
      return AppConstants.shortPasswordMessage;
    }
    return null;
  }

  /// Valida o CEP no formato 00000-000.
  static String? validateCep(String? value) {
    final requiredError = required(value);
    if (requiredError != null) return requiredError;

    if (!_cepRegex.hasMatch(value!.trim())) {
      return AppConstants.invalidCepMessage;
    }
    return null;
  }

  /// Valida o CNS (Cartão Nacional de Saúde) com 15 dígitos numéricos.
  static String? validateCns(String? value) {
    final requiredError = required(value);
    if (requiredError != null) return requiredError;

    if (!_cnsRegex.hasMatch(value!.trim())) {
      return AppConstants.invalidCnsMessage;
    }
    return null;
  }

  /// Valida se a confirmação de senha é igual à senha.
  static String? validatePasswordConfirmation(String? value, String password) {
    final requiredError = required(value);
    if (requiredError != null) return requiredError;

    if (value != password) {
      return 'As senhas não coincidem.';
    }
    return null;
  }
}
