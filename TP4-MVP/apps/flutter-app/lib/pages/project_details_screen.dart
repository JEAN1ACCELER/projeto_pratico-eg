import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/project.dart';
import '../models/task.dart';
import '../services/database_service.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final Project project;

  const ProjectDetailsScreen({Key? key, required this.project}) : super(key: key);

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await DatabaseService.instance.getTasksByProjectId(widget.project.id!);
    setState(() {
      _tasks = tasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project.title),
        backgroundColor: Colors.blue.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.project.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              widget.project.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Text(
                  'Status:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8.0),
                Chip(
                  label: Text(widget.project.status),
                  backgroundColor: widget.project.status == 'active'
                      ? Colors.green.shade100
                      : Colors.grey.shade100,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Tarefas do Projeto:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            _tasks.isEmpty
                ? const Text('Nenhuma tarefa associada a este projeto.')
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      final task = _tasks[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          title: Text(task.title),
                          subtitle: Text(
                            '${task.description}\nVencimento: ${task.dueDate != null ? DateFormat('dd/MM/yyyy').format(task.dueDate!) : 'N/A'}'
                          ),
                          trailing: Chip(
                            label: Text(task.status),
                            backgroundColor: task.status == 'pending'
                                ? Colors.orange.shade100
                                : task.status == 'in_progress'
                                    ? Colors.blue.shade100
                                    : Colors.green.shade100,
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
