import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para carregar arquivos de assets

class TermsDialog extends StatefulWidget {
  const TermsDialog({Key? key}) : super(key: key);

  @override
  State<TermsDialog> createState() => _TermsDialogState();
}

class _TermsDialogState extends State<TermsDialog> {
  String _termsContent = 'Carregando termos de uso...';

  @override
  void initState() {
    super.initState();
    _loadTermsContent();
  }

  Future<void> _loadTermsContent() async {
    try {
      String content = await rootBundle.loadString('docs/termos-de-uso.md');
      setState(() {
        _termsContent = content;
      });
    } catch (e) {
      setState(() {
        _termsContent = 'Não foi possível carregar os termos de uso: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Termos de Uso e Política de Privacidade'),
      content: SingleChildScrollView(
        child: Text(_termsContent),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Fechar'),
        ),
      ],
    );
  }
}
  }
}
