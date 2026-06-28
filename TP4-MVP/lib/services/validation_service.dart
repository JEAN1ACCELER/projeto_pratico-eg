import '../utils/validators.dart';

/// Serviço de validação centralizado.
/// Delega as validações para a classe Validators,
/// podendo ser injetado via Provider.
class ValidationService {
  const ValidationService();

  String? validateName(String? value) => Validators.validateName(value);
  String? validateEmail(String? value) => Validators.validateEmail(value);
  String? validatePassword(String? value) => Validators.validatePassword(value);
  String? validateCep(String? value) => Validators.validateCep(value);
  String? validateCns(String? value) => Validators.validateCns(value);
  String? validateRequired(String? value) => Validators.required(value);

  String? validatePasswordConfirmation(String? value, String password) =>
      Validators.validatePasswordConfirmation(value, password);
}
