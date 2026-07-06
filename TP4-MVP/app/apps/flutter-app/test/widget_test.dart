import 'package:flutter_test/flutter_test.dart';
import 'package:e_project/main.dart';

void main() {
  testWidgets('App renders SplashScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const EProjectApp());
    // Verifica que o texto "E-Project" aparece na splash
    expect(find.text('E-Project'), findsOneWidget);
  });
}
