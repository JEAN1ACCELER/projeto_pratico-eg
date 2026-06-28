import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:doacao_mvp/widgets/common/custom_textfield.dart';
import 'package:doacao_mvp/utils/validators.dart';

/// Testes de widget para o CustomTextField.
void main() {
  group('CustomTextField', () {
    testWidgets('deve exibir o label corretamente', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomTextField(label: 'E-mail'),
          ),
        ),
      );

      expect(find.text('E-mail'), findsOneWidget);
    });

    testWidgets('deve exibir ícone de prefixo quando fornecido',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              label: 'E-mail',
              prefixIcon: Icons.email,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.email), findsOneWidget);
    });

    testWidgets('deve aceitar entrada de texto', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              label: 'Nome',
              controller: controller,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'João Silva');
      expect(controller.text, equals('João Silva'));
    });

    testWidgets('deve exibir botão de visibilidade para campo de senha',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              label: 'Senha',
              obscureText: true,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('deve exibir mensagem de erro de validação',
        (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: CustomTextField(
                label: 'E-mail',
                validator: Validators.validateEmail,
              ),
            ),
          ),
        ),
      );

      formKey.currentState!.validate();
      await tester.pump();

      expect(find.text('Este campo é obrigatório.'), findsOneWidget);
    });
  });
}
