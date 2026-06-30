import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tp4_mvp/models/user.dart';
import 'package:tp4_mvp/models/project.dart';
import 'package:tp4_mvp/models/task.dart';

class DatabaseService extends ChangeNotifier {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  static DatabaseService get instance => _instance;

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'e_project.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Tabela de usuários
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        cpf TEXT NOT NULL,
        cns TEXT NOT NULL,
        role TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        acceptedTerms INTEGER NOT NULL,
        acceptedPrivacy INTEGER NOT NULL
      )
    ''');

    // Tabela de senhas (hash)
    await db.execute('''
      CREATE TABLE passwords (
        email TEXT PRIMARY KEY,
        passwordHash TEXT NOT NULL
      )
    ''');

    // Tabela de projetos
    await db.execute('''
      CREATE TABLE projects (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        status TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        FOREIGN KEY(userId) REFERENCES users(id)
      )
    ''');

    // Tabela de tarefas
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        projectId INTEGER NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        status TEXT NOT NULL,
        dueDate TEXT,
        createdAt TEXT NOT NULL,
        FOREIGN KEY(projectId) REFERENCES projects(id)
      )
    ''');
  }

  // Operações de usuário
  Future<bool> isEmailUnique(String email) async {
    final db = await database;
    final count = Sqflite.firstIntValue(await db.rawQuery(
        'SELECT COUNT(*) FROM users WHERE email = ?',
        [email]));
    return count == 0;
  }

  Future<bool> isCpfUnique(String cpf) async {
    final db = await database;
    final count = Sqflite.firstIntValue(await db.rawQuery(
        'SELECT COUNT(*) FROM users WHERE cpf = ?',
        [cpf]));
    return count == 0;
  }

  Future<bool> isCnsUnique(String cns) async {
    final db = await database;
    final count = Sqflite.firstIntValue(await db.rawQuery(
        'SELECT COUNT(*) FROM users WHERE cns = ?',
        [cns]));
    return count == 0;
  }

  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert('users', user.toMap());
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<void> savePasswordHash(String email, String hash) async {
    final db = await database;
    await db.insert(
      'passwords',
      {'email': email, 'passwordHash': hash},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getPasswordHash(String email) async {
    final db = await database;
    final maps = await db.query(
      'passwords',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return maps.first['passwordHash'] as String?;
    }
    return null;
  }

  // Operações de projeto
  Future<void> insertProject(Project project) async {
    final db = await database;
    await db.insert('projects', project.toMap());
  }

  Future<List<Project>> getProjectsByUserId(int userId) async {
    final db = await database;
    final maps = await db.query(
      'projects',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return maps.map((map) => Project.fromMap(map)).toList();
  }

  // Operações de tarefa
  Future<void> insertTask(Task task) async {
    final db = await database;
    await db.insert('tasks', task.toMap());
  }

  Future<List<Task>> getTasksByProjectId(int projectId) async {
    final db = await database;
    final maps = await db.query(
      'tasks',
      where: 'projectId = ?',
      whereArgs: [projectId],
    );
    return maps.map((map) => Task.fromMap(map)).toList();
  }

  Future<List<Task>> getTasksByUserId(int userId) async {
    final db = await database;
    final maps = await db.rawQuery(
      'SELECT t.* FROM tasks t JOIN projects p ON t.projectId = p.id WHERE p.userId = ?',
      [userId],
    );
    return maps.map((map) => Task.fromMap(map)).toList();
  }
}
