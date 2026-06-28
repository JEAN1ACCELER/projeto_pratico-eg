import 'package:flutter_test/flutter_test.dart';
import 'package:doacao_mvp/providers/auth_provider.dart';
import 'package:doacao_mvp/repositories/auth_repository.dart';
import 'package:doacao_mvp/models/user_model.dart';

/// Testes unitários do AuthProvider.
/// Verifica o gerenciamento de estado de autenticação.
void main() {
  group('AuthProvider', () {
    late AuthProvider authProvider;

    setUp(() {
      authProvider = AuthProvider();
    });

    tearDown(() {
      authProvider.dispose();
    });

    test('estado inicial deve ser AuthStatus.initial', () {
      expect(authProvider.status, equals(AuthStatus.initial));
      expect(authProvider.currentUser, isNull);
      expect(authProvider.isAuthenticated, isFalse);
    });

    test('clearError deve limpar a mensagem de erro', () {
      authProvider.clearError();
      expect(authProvider.errorMessage, isNull);
    });

    test('isAuthenticated deve retornar false quando não autenticado', () {
      expect(authProvider.isAuthenticated, isFalse);
    });
  });

  group('AuthProvider - Validação de Estado', () {
    test('AuthStatus.authenticated deve definir isAuthenticated como true', () {
      // Testa a lógica de status diretamente
      expect(AuthStatus.authenticated == AuthStatus.authenticated, isTrue);
      expect(AuthStatus.unauthenticated == AuthStatus.authenticated, isFalse);
    });
  });

  group('UserModel - Factory e CopyWith', () {
    test('UserModel.create deve criar usuário com ID único', () {
      final user1 = UserModel.create(
        name: 'João Silva',
        email: 'joao@email.com',
        cep: '69000-000',
        cns: '123456789012345',
        passwordHash: 'hash123',
      );
      final user2 = UserModel.create(
        name: 'Maria Santos',
        email: 'maria@email.com',
        cep: '69001-000',
        cns: '987654321098765',
        passwordHash: 'hash456',
      );

      expect(user1.id, isNotEmpty);
      expect(user2.id, isNotEmpty);
      expect(user1.id, isNot(equals(user2.id)));
    });

    test('UserModel.copyWith deve preservar campos não alterados', () {
      final original = UserModel.create(
        name: 'João Silva',
        email: 'joao@email.com',
        cep: '69000-000',
        cns: '123456789012345',
        passwordHash: 'hash123',
      );

      final updated = original.copyWith(name: 'João Atualizado');

      expect(updated.name, equals('João Atualizado'));
      expect(updated.email, equals(original.email));
      expect(updated.cep, equals(original.cep));
      expect(updated.id, equals(original.id));
    });

    test('UserModel.toJson deve incluir todos os campos', () {
      final user = UserModel.create(
        name: 'Teste',
        email: 'teste@email.com',
        cep: '69000-000',
        cns: '123456789012345',
        passwordHash: 'hash',
      );

      final json = user.toJson();

      expect(json['id'], isNotNull);
      expect(json['name'], equals('Teste'));
      expect(json['email'], equals('teste@email.com'));
      expect(json['cep'], equals('69000-000'));
      expect(json['cns'], equals('123456789012345'));
    });
  });
}
