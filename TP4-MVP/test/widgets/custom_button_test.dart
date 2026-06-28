import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:doacao_mvp/widgets/common/custom_button.dart';

/// Testes de widget para o CustomButton.
void main() {
  group('CustomButton', () {
    testWidgets('deve exibir o label corretamente', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              label: 'Entrar',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Entrar'), findsOneWidget);
    });

    testWidgets('deve exibir CircularProgressIndicator quando isLoading é true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomButton(
              label: 'Entrar',
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Entrar'), findsNothing);
    });

    testWidgets('deve chamar onPressed quando pressionado',
        (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              label: 'Clique',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      expect(pressed, isTrue);
    });

    testWidgets('deve renderizar como OutlinedButton quando isOutlined é true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              label: 'Cancelar',
              isOutlined: true,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('deve exibir ícone quando fornecido',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              label: 'Login',
              icon: Icons.login,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.login), findsOneWidget);
    });
  });
}
