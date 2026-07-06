import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/projeto_provider.dart';
import '../config/constants.dart';
import '../utils/validators.dart';
import '../widgets/app_widgets.dart';

class ProjetoFormPage extends StatefulWidget {
  const ProjetoFormPage({super.key});

  @override
  State<ProjetoFormPage> createState() => _ProjetoFormPageState();
}

class _ProjetoFormPageState extends State<ProjetoFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _resumoController = TextEditingController();
  String _modalidade = 'PIBIC';
  DateTime? _dataInicio = DateTime.now();
  DateTime? _dataTermino = DateTime.now().add(const Duration(days: 365));

  @override
  void dispose() {
    _tituloController.dispose();
    _resumoController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context, bool isTermino) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isTermino ? _dataTermino! : _dataInicio!,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked != null) setState(() => isTermino ? _dataTermino = picked : _dataInicio = picked);
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;
    final provider = context.read<ProjetoProvider>();
    final ok = await provider.criar({
      'titulo': _tituloController.text.trim(),
      'modalidade': _modalidade,
      'dataInicio': _dataInicio!.toIso8601String(),
      'dataTermino': _dataTermino!.toIso8601String(),
      'resumo': _resumoController.text.trim(),
    });
    if (!mounted) return;
    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Projeto criado com sucesso!'), backgroundColor: Color(0xFF00663C)));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Erro ao criar projeto')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Projeto')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppTextField(label: 'Título do Projeto', controller: _tituloController, prefixIcon: Icons.title, validator: (v) => Validators.obrigatorio(v, 'Título')),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _modalidade,
                decoration: const InputDecoration(labelText: 'Modalidade', prefixIcon: Icon(Icons.category)),
                items: AppConstants.modalidades.map((m) => DropdownMenuItem(value: m, child: Text(AppConstants.modalidadeLabel[m] ?? m))).toList(),
                onChanged: (v) => setState(() => _modalidade = v ?? 'PIBIC'),
              ),
              const SizedBox(height: 16),
              Row(children: [
                Expanded(child: InkWell(onTap: () => _pickDate(context, false), child: InputDecorator(decoration: const InputDecoration(labelText: 'Início', prefixIcon: Icon(Icons.calendar_today)), child: Text(_fmt(_dataInicio))))),
                const SizedBox(width: 12),
                Expanded(child: InkWell(onTap: () => _pickDate(context, true), child: InputDecorator(decoration: const InputDecoration(labelText: 'Término', prefixIcon: Icon(Icons.event)), child: Text(_fmt(_dataTermino))))),
              ]),
              const SizedBox(height: 16),
              AppTextField(label: 'Resumo', controller: _resumoController, maxLines: 4, prefixIcon: Icons.description),
              const SizedBox(height: 24),
              PrimaryButton(text: 'Criar Projeto', icon: Icons.save, onPressed: _salvar),
            ],
          ),
        ),
      ),
    );
  }

  String _fmt(DateTime? d) => d == null ? '—' : '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}
