import 'package:intl/intl.dart';

/// Funções utilitárias de formatação de dados.
class Formatters {
  Formatters._();

  static final DateFormat _dateFormat = DateFormat('dd/MM/yyyy', 'pt_BR');
  static final DateFormat _dateTimeFormat = DateFormat('dd/MM/yyyy HH:mm', 'pt_BR');

  /// Formata uma data para o padrão brasileiro dd/MM/yyyy.
  static String formatDate(DateTime date) => _dateFormat.format(date);

  /// Formata uma data e hora para o padrão dd/MM/yyyy HH:mm.
  static String formatDateTime(DateTime dateTime) => _dateTimeFormat.format(dateTime);

  /// Formata o CEP adicionando o hífen automaticamente.
  static String formatCep(String cep) {
    final digits = cep.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 8) return cep;
    return '${digits.substring(0, 5)}-${digits.substring(5)}';
  }

  /// Formata o CNS em grupos de 3 dígitos para exibição.
  static String formatCns(String cns) {
    final digits = cns.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 15) return cns;
    return '${digits.substring(0, 3)} ${digits.substring(3, 7)} ${digits.substring(7, 11)} ${digits.substring(11)}';
  }

  /// Capitaliza a primeira letra de cada palavra.
  static String capitalizeWords(String text) {
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
}
