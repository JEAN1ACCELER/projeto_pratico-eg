import 'package:flutter/material.dart';

class TermsDialog extends StatelessWidget {
  const TermsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Termos de Uso e Política de Privacidade'),
      content: const SingleChildScrollView(
        child: Text(
          'Ao utilizar o AcadPro App, você concorda com a coleta de dados para fins acadêmicos. '
          'Seus dados como CPF e CNS são utilizados exclusivamente para validação de perfil. '
          'As senhas são armazenadas de forma criptografada com SHA-256 no banco de dados local SQLite.',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Fechar'),
        ),
      ],
    );
  }
}
