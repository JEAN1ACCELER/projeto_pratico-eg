import 'package:flutter/material.dart';
import '../models/tarefa.dart';
import '../services/tarefa_service.dart';
import '../utils/validators.dart';
import '../utils/helpers.dart';
import '../widgets/app_widgets.dart';

class TarefaFormPage extends StatefulWidget {
  final String projetoId;
  final String? tarefaId;
  final Tarefa? tarefa;

  /// Criação: passe projetoId.
  /// Edição: passe tarefaId e tarefa preenchida.
  const TarefaFormPage({super.key, required this.projetoId, this.tarefaId, this.tarefa});

  @override
  State<TarefaFormPage> createState() => _TarefaFormPageState();
}

class _TarefaFormPageState extends State<TarefaFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  DateTime? _prazo;
  final _service = TarefaService();
  bool _saving = false;
  late final bool _isEditing;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.tarefa != null;
    if (_isEditing) {
      _tituloController.text = widget.tarefa!.titulo;
      _descricaoController.text = widget.tarefa!.descricao ?? '';
      _prazo = widget.tarefa!.prazo;
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final data = {
        'titulo': _tituloController.text.trim(),
        'descricao': _descricaoController.text.trim(),
        if (_prazo != null) 'prazo': _prazo!.toIso8601String(),
      };

      if (_isEditing && widget.tarefaId != null) {
        await _service.atualizar(widget.tarefaId!, data);
      } else {
        await _service.criar(widget.projetoId, data);
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isEditing ? 'Tarefa atualizada!' : 'Tarefa criada!'),
          backgroundColor: const Color(0xFF00663C),
        ),
      );
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: $e')));
    }
    setState(() => _saving = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? 'Editar Tarefa' : 'Nova Tarefa')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppTextField(label: 'Título da Tarefa', controller: _tituloController, prefixIcon: Icons.task, validator: (v) => Validators.obrigatorio(v, 'Título')),
              const SizedBox(height: 16),
              AppTextField(label: 'Descrição', controller: _descricaoController, maxLines: 3, prefixIcon: Icons.description),
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _prazo ?? DateTime.now().add(const Duration(days: 7)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2035),
                  );
                  if (picked != null) setState(() => _prazo = picked);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Prazo (opcional)', prefixIcon: Icon(Icons.calendar_today)),
                  child: Text(_prazo == null ? 'Selecionar data' : Helpers.formatDate(_prazo)),
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(text: _isEditing ? 'Salvar Alterações' : 'Criar Tarefa', icon: Icons.save, isLoading: _saving, onPressed: _salvar),
              if (_isEditing) ...[
                const SizedBox(height: 12),
                TextButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Limpar prazo'),
                        content: const Text('Deseja remover o prazo desta tarefa?'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
                          TextButton(
                            onPressed: () {
                              setState(() => _prazo = null);
                              Navigator.pop(ctx);
                            },
                            child: const Text('Remover', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.clear, size: 16),
                  label: const Text('Remover prazo'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
