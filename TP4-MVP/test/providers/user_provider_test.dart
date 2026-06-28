import 'package:flutter_test/flutter_test.dart';
import 'package:doacao_mvp/providers/user_provider.dart';
import 'package:doacao_mvp/utils/validators.dart';
import 'package:doacao_mvp/utils/formatters.dart';
import 'package:doacao_mvp/utils/constants.dart';

/// Testes unitários do UserProvider e utilitários relacionados.
void main() {
  group('UserProvider', () {
    late UserProvider userProvider;

    setUp(() {
      userProvider = UserProvider();
    });

    tearDown(() {
      userProvider.dispose();
    });

    test('estado inicial deve ter user nulo e isLoading false', () {
      expect(userProvider.user, isNull);
      expect(userProvider.isLoading, isFalse);
      expect(userProvider.errorMessage, isNull);
    });

    test('clearError deve limpar a mensagem de erro', () {
      userProvider.clearError();
      expect(userProvider.errorMessage, isNull);
    });
  });

  group('Validators', () {
    group('validateName', () {
      test('deve retornar erro para nome vazio', () {
        expect(Validators.validateName(''), isNotNull);
        expect(Validators.validateName(null), isNotNull);
      });

      test('deve retornar erro para nome com menos de 3 caracteres', () {
        expect(Validators.validateName('AB'), isNotNull);
      });

      test('deve retornar null para nome válido', () {
        expect(Validators.validateName('João Silva'), isNull);
        expect(Validators.validateName('Ana'), isNull);
      });
    });

    group('validateEmail', () {
      test('deve retornar erro para e-mail inválido', () {
        expect(Validators.validateEmail('email_invalido'), isNotNull);
        expect(Validators.validateEmail('sem@dominio'), isNotNull);
        expect(Validators.validateEmail(''), isNotNull);
      });

      test('deve retornar null para e-mail válido', () {
        expect(Validators.validateEmail('usuario@email.com'), isNull);
        expect(Validators.validateEmail('teste@ufam.edu.br'), isNull);
      });
    });

    group('validatePassword', () {
      test('deve retornar erro para senha com menos de 6 caracteres', () {
        expect(Validators.validatePassword('12345'), isNotNull);
        expect(Validators.validatePassword(''), isNotNull);
      });

      test('deve retornar null para senha válida', () {
        expect(Validators.validatePassword('senha123'), isNull);
        expect(Validators.validatePassword('123456'), isNull);
      });
    });

    group('validateCep', () {
      test('deve retornar erro para CEP inválido', () {
        expect(Validators.validateCep('69000000'), isNotNull);
        expect(Validators.validateCep('6900-000'), isNotNull);
        expect(Validators.validateCep(''), isNotNull);
      });

      test('deve retornar null para CEP válido', () {
        expect(Validators.validateCep('69000-000'), isNull);
        expect(Validators.validateCep('01310-100'), isNull);
      });
    });

    group('validateCns', () {
      test('deve retornar erro para CNS inválido', () {
        expect(Validators.validateCns('12345'), isNotNull);
        expect(Validators.validateCns('1234567890123456'), isNotNull);
        expect(Validators.validateCns(''), isNotNull);
      });

      test('deve retornar null para CNS com 15 dígitos', () {
        expect(Validators.validateCns('123456789012345'), isNull);
        expect(Validators.validateCns('987654321098765'), isNull);
      });
    });

    group('validatePasswordConfirmation', () {
      test('deve retornar erro quando senhas não coincidem', () {
        expect(
          Validators.validatePasswordConfirmation('senha123', 'outrasenha'),
          isNotNull,
        );
      });

      test('deve retornar null quando senhas coincidem', () {
        expect(
          Validators.validatePasswordConfirmation('senha123', 'senha123'),
          isNull,
        );
      });
    });
  });

  group('Formatters', () {
    test('formatCep deve formatar corretamente', () {
      expect(Formatters.formatCep('69000000'), equals('69000-000'));
    });

    test('formatCns deve formatar em grupos', () {
      final formatted = Formatters.formatCns('123456789012345');
      expect(formatted, contains(' '));
    });

    test('capitalizeWords deve capitalizar cada palavra', () {
      expect(Formatters.capitalizeWords('joão silva'), equals('João Silva'));
    });
  });

  group('AppConstants', () {
    test('minPasswordLength deve ser 6', () {
      expect(AppConstants.minPasswordLength, equals(6));
    });

    test('minNameLength deve ser 3', () {
      expect(AppConstants.minNameLength, equals(3));
    });

    test('cnsLength deve ser 15', () {
      expect(AppConstants.cnsLength, equals(15));
    });

    test('donationTypes não deve estar vazio', () {
      expect(AppConstants.donationTypes, isNotEmpty);
    });
  });
}
