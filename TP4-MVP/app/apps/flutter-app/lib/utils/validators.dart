import 'package:email_validator/email_validator.dart';
import '../config/constants.dart';

class Validators {
  static String? nome(String? value) {
    if (value == null || value.trim().isEmpty) return 'Nome completo é obrigatório';
    if (value.trim().length < 3) return 'Nome deve ter pelo menos 3 caracteres';
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'E-mail é obrigatório';
    if (!EmailValidator.validate(value)) return 'E-mail inválido';
    if (!value.endsWith(AppConstants.sufixoEmailInstitucional)) {
      return 'Use seu e-mail institucional $AppConstants.sufixoEmailInstitucional';
    }
    return null;
  }

  static String? senha(String? value) {
    if (value == null || value.isEmpty) return 'Senha é obrigatória';
    if (value.length < AppConstants.minSenhaLength) {
      return 'Senha deve ter pelo menos ${AppConstants.minSenhaLength} caracteres';
    }
    return null;
  }

  static String? confirmarSenha(String? value, String senha) {
    if (value == null || value.isEmpty) return 'Confirmação de senha é obrigatória';
    if (value != senha) return 'As senhas não coincidem';
    return null;
  }

  static String? obrigatorio(String? value, [String campo = 'Este campo']) {
    if (value == null || value.trim().isEmpty) return '$campo é obrigatório';
    return null;
  }
}
