import 'package:flutter/material.dart';

/// Funções auxiliares reutilizáveis em toda a aplicação.
class Helpers {
  Helpers._();

  /// Exibe um SnackBar com mensagem de erro.
  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Exibe um SnackBar com mensagem de sucesso.
  static void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Exibe um AlertDialog de confirmação.
  static Future<bool> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirmar',
    String cancelText = 'Cancelar',
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// Simula o envio de e-mail (imprime no console conforme especificação H6).
  static void simulateEmailSend({
    required String toEmail,
    required String subject,
    required String body,
  }) {
    debugPrint('=== SIMULAÇÃO DE ENVIO DE E-MAIL ===');
    debugPrint('Para: $toEmail');
    debugPrint('Assunto: $subject');
    debugPrint('Corpo: $body');
    debugPrint('====================================');
  }
}
