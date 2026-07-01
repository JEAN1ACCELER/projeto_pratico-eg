import 'package:flutter_test/flutter_test.dart';
import 'package:e_project/models/user.dart';
import 'package:e_project/services/auth_service.dart';
import 'package:e_project/services/database_service.dart';

void main() {
  group('AuthService', () {
    late AuthService authService;

    setUp(() {
      authService = AuthService();
    });

    test('Inicialmente não deve ter usuário autenticado', () {
      expect(authService.currentUser, isNull);
      expect(authService.isAuthenticated, isFalse);
    });

    test('Deve indicar quando está carregando', () {
      expect(authService.isLoading, isFalse);
    });

    test('Deve criar um novo usuário com sucesso', () async {
      final user = User(
        name: 'João Silva',
        email: 'joao@example.com',
        cpf: '123.456.789-00',
        cns: '123456789012345',
        role: 'donor',
        createdAt: DateTime.now(),
        acceptedTerms: true,
        acceptedPrivacy: true,
      );

      final success = await authService.signup(user, 'senha123');

      expect(success, isTrue);
      expect(authService.currentUser, isNotNull);
      expect(authService.currentUser?.email, equals('joao@example.com'));
    });

    test('Deve fazer logout com sucesso', () async {
      final user = User(
        name: 'Maria Santos',
        email: 'maria@example.com',
        cpf: '987.654.321-00',
        cns: '987654321098765',
        role: 'recipient',
        createdAt: DateTime.now(),
        acceptedTerms: true,
        acceptedPrivacy: true,
      );

      await authService.signup(user, 'senha456');
      expect(authService.isAuthenticated, isTrue);

      await authService.logout();
      expect(authService.currentUser, isNull);
      expect(authService.isAuthenticated, isFalse);
    });

    test('Deve validar email duplicado', () async {
      final user1 = User(
        name: 'Pedro Oliveira',
        email: 'pedro@example.com',
        cpf: '111.222.333-44',
        cns: '111222333444555',
        role: 'donor',
        createdAt: DateTime.now(),
        acceptedTerms: true,
        acceptedPrivacy: true,
      );

      final user2 = User(
        name: 'Paulo Oliveira',
        email: 'pedro@example.com',
        cpf: '555.666.777-88',
        cns: '555666777888999',
        role: 'recipient',
        createdAt: DateTime.now(),
        acceptedTerms: true,
        acceptedPrivacy: true,
      );

      await authService.signup(user1, 'senha789');
      final success = await authService.signup(user2, 'senha789');

      expect(success, isFalse);
    });
  });
}
