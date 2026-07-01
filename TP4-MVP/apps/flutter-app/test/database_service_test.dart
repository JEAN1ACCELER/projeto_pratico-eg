import 'package:flutter_test/flutter_test.dart';
import 'package:e_project/models/user.dart';
import 'package:e_project/services/database_service.dart';

void main() {
  group('DatabaseService', () {
    late DatabaseService databaseService;

    setUp(() async {
      databaseService = DatabaseService.instance;
      await databaseService.initializeDatabase();
    });

    test('Deve inserir um usuário com sucesso', () async {
      final user = User(
        name: 'Ana Costa',
        email: 'ana@example.com',
        cpf: '456.789.012-34',
        cns: '456789012345678',
        role: 'donor',
        createdAt: DateTime.now(),
        acceptedTerms: true,
        acceptedPrivacy: true,
      );

      await databaseService.insertUser(user);
      final retrievedUser = await databaseService.getUserByEmail('ana@example.com');

      expect(retrievedUser, isNotNull);
      expect(retrievedUser?.name, equals('Ana Costa'));
      expect(retrievedUser?.email, equals('ana@example.com'));
    });

    test('Deve retornar null para usuário inexistente', () async {
      final user = await databaseService.getUserByEmail('inexistente@example.com');
      expect(user, isNull);
    });

    test('Deve salvar e recuperar hash de senha', () async {
      const email = 'teste@example.com';
      const passwordHash = 'abc123def456';

      await databaseService.savePasswordHash(email, passwordHash);
      final retrievedHash = await databaseService.getPasswordHash(email);

      expect(retrievedHash, equals(passwordHash));
    });

    test('Deve inserir um projeto com sucesso', () async {
      const userId = '1';
      const title = 'Projeto de Pesquisa';
      const description = 'Descrição do projeto';

      await databaseService.insertProject(userId, title, description);
      final projects = await databaseService.getProjectsByUserId(1);

      expect(projects, isNotEmpty);
      expect(projects.first['title'], equals(title));
    });

    test('Deve inserir uma tarefa com sucesso', () async {
      const projectId = 1;
      const title = 'Tarefa 1';
      const description = 'Descrição da tarefa';
      final dueDate = DateTime.now().add(const Duration(days: 7)).toString();

      await databaseService.insertTask(projectId, title, description, dueDate);
      final tasks = await databaseService.getTasksByProjectId(projectId);

      expect(tasks, isNotEmpty);
      expect(tasks.first['title'], equals(title));
    });

    test('Deve retornar lista vazia para projeto sem tarefas', () async {
      const projectId = 999;
      final tasks = await databaseService.getTasksByProjectId(projectId);

      expect(tasks, isEmpty);
    });
  });
}
