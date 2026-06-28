import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:doacao_mvp/providers/auth_provider.dart';
import 'package:doacao_mvp/pages/register_page.dart';

/// Testes de integração do fluxo de cadastro (H6).
/// Verifica o comportamento completo da tela de cadastro.
void main() {
  group('RegisterPage - Fluxo de Cadastro (H6)', () {
    Widget buildRegisterPage() {
      return MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => AuthProvider(),
          child: const RegisterPage(),
        ),
      );
    }

    testWidgets('deve exibir todos os campos obrigatórios', (tester) async {
      await tester.pumpWidget(buildRegisterPage());

      expect(find.text('Nome Completo'), findsOneWidget);
      expect(find.text('E-mail'), findsOneWidget);
      expect(find.text('CEP'), findsOneWidget);
      expect(find.text('CNS (Cartão Nacional de Saúde)'), findsOneWidget);
      expect(find.text('Senha'), findsOneWidget);
      expect(find.text('Confirmar Senha'), findsOneWidget);
    });

    testWidgets('deve exibir botão de criar conta', (tester) async {
      await tester.pumpWidget(buildRegisterPage());
      expect(find.text('Criar Conta'), findsOneWidget);
    });

    testWidgets('deve exibir informação sobre envio de e-mail (H6)',
        (tester) async {
      await tester.pumpWidget(buildRegisterPage());
      expect(
        find.textContaining('e-mail com orientações'),
        findsOneWidget,
      );
    });

    testWidgets(
        'deve exibir erros de validação ao submeter formulário vazio',
        (tester) async {
      await tester.pumpWidget(buildRegisterPage());

      await tester.tap(find.text('Criar Conta'));
      await tester.pump();

      expect(find.text('Este campo é obrigatório.'), findsWidgets);
    });

    testWidgets('deve exibir erro de CNS inválido', (tester) async {
      await tester.pumpWidget(buildRegisterPage());

      // Preenche nome, email, CEP e senha para chegar ao CNS
      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'João Silva');
      await tester.enterText(fields.at(1), 'joao@email.com');
      await tester.enterText(fields.at(2), '69000-000');
      await tester.enterText(fields.at(3), '12345'); // CNS inválido
      await tester.enterText(fields.at(4), 'senha123');
      await tester.enterText(fields.at(5), 'senha123');

      await tester.tap(find.text('Criar Conta'));
      await tester.pump();

      expect(
        find.textContaining('CNS deve conter 15 dígitos'),
        findsOneWidget,
      );
    });

    testWidgets('deve exibir link para login', (tester) async {
      await tester.pumpWidget(buildRegisterPage());
      expect(find.text('Faça login'), findsOneWidget);
    });
  });
}
