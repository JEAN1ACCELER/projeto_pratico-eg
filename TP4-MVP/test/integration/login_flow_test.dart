import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:doacao_mvp/providers/auth_provider.dart';
import 'package:doacao_mvp/pages/login_page.dart';

/// Testes de integração do fluxo de login.
/// Verifica o comportamento completo da tela de login.
void main() {
  group('LoginPage - Fluxo de Login', () {
    Widget buildLoginPage() {
      return MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => AuthProvider(),
          child: const LoginPage(),
        ),
      );
    }

    testWidgets('deve exibir campos de e-mail e senha', (tester) async {
      await tester.pumpWidget(buildLoginPage());

      expect(find.text('E-mail'), findsOneWidget);
      expect(find.text('Senha'), findsOneWidget);
    });

    testWidgets('deve exibir botão de login', (tester) async {
      await tester.pumpWidget(buildLoginPage());
      expect(find.text('Entrar'), findsOneWidget);
    });

    testWidgets('deve exibir link para cadastro', (tester) async {
      await tester.pumpWidget(buildLoginPage());
      expect(find.text('Cadastre-se'), findsOneWidget);
    });

    testWidgets('deve exibir link para recuperação de senha', (tester) async {
      await tester.pumpWidget(buildLoginPage());
      expect(find.text('Esqueci minha senha'), findsOneWidget);
    });

    testWidgets(
        'deve exibir erros de validação ao submeter formulário vazio',
        (tester) async {
      await tester.pumpWidget(buildLoginPage());

      await tester.tap(find.text('Entrar'));
      await tester.pump();

      expect(find.text('Este campo é obrigatório.'), findsWidgets);
    });

    testWidgets('deve exibir erro de e-mail inválido', (tester) async {
      await tester.pumpWidget(buildLoginPage());

      await tester.enterText(
        find.byType(TextFormField).first,
        'email_invalido',
      );
      await tester.tap(find.text('Entrar'));
      await tester.pump();

      expect(find.text('Por favor, insira um e-mail válido.'), findsOneWidget);
    });
  });
}
