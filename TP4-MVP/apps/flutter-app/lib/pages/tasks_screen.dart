import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // Para formatação de data
import '../models/project.dart';
import '../models/task.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  Project? _selectedProject; // Para selecionar o projeto associado à tarefa
  List<Project> _userProjects = []; // Lista de projetos do usuário

  @override
  void initState() {
    super.initState();
    _loadUserProjects();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _loadUserProjects() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.currentUser;
    if (user != null) {
      final projects = await DatabaseService.instance.getProjectsByUserId(user.id!);
      setState(() {
        _userProjects = projects;
        _selectedProject = projects.isNotEmpty ? projects.first : null;
      });
    }
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nova Tarefa'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<Project>(
              value: _selectedProject,
              decoration: InputDecoration(
                labelText: 'Projeto Associado',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: _userProjects.map((project) {
                return DropdownMenuItem<Project>(
                  value: project,
                  child: Text(project.title),
                );
              }).toList(),
              onChanged: (Project? newValue) {
                setState(() {
                  _selectedProject = newValue;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Por favor, selecione um projeto';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Título da Tarefa',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) {
                  setState(() {
                    _selectedDate = date;
                  });
                }
              },
              icon: const Icon(Icons.calendar_today),
              label: Text(
                _selectedDate != null
                    ? 'Data: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                    : 'Selecionar Data',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_selectedProject == null) {
                // Mostrar erro ou aviso
                return;
              }
              if (_titleController.text.isNotEmpty) {
                final newTask = Task(
                  projectId: _selectedProject!.id!,
                  title: _titleController.text,
                  description: _descriptionController.text,
                  dueDate: _selectedDate,
                  createdAt: DateTime.now(),
                );
                await DatabaseService.instance.insertTask(newTask);
                _titleController.clear();
                _descriptionController.clear();
                _selectedDate = null;
                if (mounted) {
                  Navigator.pop(context);
                  setState(() {}); // Atualiza a lista de tarefas
                }
              }
            },
            child: const Text('Criar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    return Scaffold(
      body: FutureBuilder<List<Task>>(
        future: user != null
            ? DatabaseService.instance.getTasksByUserId(user.id!)
            : Future.value([]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final tasks = snapshot.data ?? [];

          if (tasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.checklist,
                    size: 80,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Nenhuma tarefa criada',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _showAddTaskDialog,
                    icon: const Icon(Icons.add),
                    label: const Text('Criar Tarefa'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: Icon(
                    Icons.task,
                    color: Colors.blue.shade700,
                  ),
                  title: Text(task.title),
                  subtitle: Text(
                    'Projeto: ${_userProjects.firstWhere((p) => p.id == task.projectId, orElse: () => Project(id: -1, userId: -1, title: 'Desconhecido', description: '', createdAt: DateTime.now())).title}\n' +
                    'Descrição: ${task.description}\n' +
                    'Vencimento: ${task.dueDate != null ? DateFormat('dd/MM/yyyy').format(task.dueDate!) : 'N/A'}',
                  ),
                  trailing: Chip(
                    label: Text(task.status),
                    backgroundColor: task.status == 'pending'
                        ? Colors.orange.shade100
                        : task.status == 'in_progress'
                            ? Colors.blue.shade100
                            : Colors.green.shade100,
                  ),
                  onTap: () {
                    // Navegar para detalhes da tarefa
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: Colors.blue.shade700,
        child: const Icon(Icons.add),
      ),
    );
  }
}
