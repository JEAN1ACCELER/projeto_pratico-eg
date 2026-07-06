import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/tarefa.dart';
import '../models/entrega.dart';
import '../providers/auth_provider.dart';
import '../services/tarefa_service.dart';
import '../services/entrega_service.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import '../utils/helpers.dart';
import '../widgets/app_widgets.dart';
import 'tarefa_form_page.dart';

class TarefaDetalhePage extends StatefulWidget {
  final String tarefaId;
  const TarefaDetalhePage({super.key, required this.tarefaId});

  @override
  State<TarefaDetalhePage> createState() => _TarefaDetalhePageState();
}

class _TarefaDetalhePageState extends State<TarefaDetalhePage> {
  Tarefa? _tarefa;
  Entrega? _entrega;
  bool _isLoading = true;
  final _tarefaService = TarefaService();
  final _entregaService = EntregaService();

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    setState(() => _isLoading = true);
    try {
      _tarefa = await _tarefaService.buscarPorId(widget.tarefaId);
      _entrega = await _entregaService.buscarPorTarefa(widget.tarefaId);
    } catch (_) {}
    setState(() => _isLoading = false);
  }

  Future<void> _mudarStatus(String novoStatus) async {
    try {
      await _tarefaService.atualizarStatus(widget.tarefaId, novoStatus);
      _carregar();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: $e')));
    }
  }

  Future<void> _excluirTarefa() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir Tarefa'),
        content: const Text('Tem certeza que deseja excluir esta tarefa? Esta ação não pode ser desfeita.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
    if (confirm != true || !mounted) return;
    try {
      await _tarefaService.excluir(widget.tarefaId);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tarefa excluída'), backgroundColor: Color(0xFF00663C)));
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final isAluno = auth.isAluno;
    final isProfessor = auth.isProfessor || auth.isAdmin;

    if (_isLoading) return Scaffold(appBar: AppBar(), body: const Center(child: CircularProgressIndicator()));
    if (_tarefa == null) return Scaffold(appBar: AppBar(title: const Text('Tarefa')), body: const Center(child: Text('Tarefa não encontrada')));

    final t = _tarefa!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Tarefa'),
        actions: [
          // Editar tarefa
          if (isProfessor)
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'Editar Tarefa',
              onPressed: () async {
                final atualizado = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TarefaFormPage(projetoId: t.projetoId, tarefaId: t.id, tarefa: t)),
                );
                if (atualizado == true) _carregar();
              },
            ),
          // Excluir tarefa
          if (isProfessor)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              tooltip: 'Excluir Tarefa',
              onPressed: _excluirTarefa,
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _carregar,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Info da tarefa
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.titulo, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    StatusChip(label: Helpers.statusTarefaLabel(t.status), color: AppTheme.statusTarefaColor(t.status)),
                    const SizedBox(height: 12),
                    if (t.descricao != null && t.descricao!.isNotEmpty) ...[
                      const Text('Descrição:', style: TextStyle(fontWeight: FontWeight.w600)),
                      Text(t.descricao!, style: const TextStyle(fontSize: 14)),
                      const SizedBox(height: 8),
                    ],
                    if (t.prazo != null) _infoRow(Icons.calendar_today, 'Prazo: ${Helpers.formatDate(t.prazo)}'),
                    _infoRow(Icons.event, 'Criada em: ${Helpers.formatDate(t.createdAt)}'),
                    if (t.dataConclusao != null) _infoRow(Icons.check_circle, 'Concluída em: ${Helpers.formatDate(t.dataConclusao)}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Mudar status
            const Text('Mudar Status', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: AppConstants.statusTarefaLabel.keys.map((s) {
                return ChoiceChip(
                  label: Text(Helpers.statusTarefaLabel(s)),
                  selected: t.status == s,
                  selectedColor: AppTheme.statusTarefaColor(s),
                  labelStyle: TextStyle(color: t.status == s ? Colors.white : Colors.black87),
                  onSelected: (_) => _mudarStatus(s),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Seção de Entrega
            const Text('Entrega', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (_entrega == null) ...[
              if (isAluno)
                PrimaryButton(text: 'Submeter Entrega', icon: Icons.upload_file, onPressed: () => _mostrarDialogoSubmissao(context))
              else
                const Text('Nenhuma entrega submetida ainda.'),
            ] else
              _buildEntregaCard(_entrega!, isProfessor),
          ],
        ),
      ),
    );
  }

  Widget _buildEntregaCard(Entrega e, bool isProfessor) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatusChip(label: Helpers.statusAvaliacaoLabel(e.statusAvaliacao), color: AppTheme.statusAvaliacaoColor(e.statusAvaliacao)),
            const SizedBox(height: 8),
            Text('Enviado em: ${Helpers.formatDateTime(e.dataEnvio)}', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            if (e.dataAvaliacao != null) Text('Avaliado em: ${Helpers.formatDateTime(e.dataAvaliacao)}', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            if (e.comentarioAluno != null) ...[
              const SizedBox(height: 8),
              const Text('Comentário do Aluno:', style: TextStyle(fontWeight: FontWeight.w600)),
              Text(e.comentarioAluno!),
            ],
            if (e.feedbackOrientador != null) ...[
              const SizedBox(height: 12),
              const Text('Feedback do Orientador:', style: TextStyle(fontWeight: FontWeight.w600)),
              Text(e.feedbackOrientador!, style: const TextStyle(fontStyle: FontStyle.italic)),
            ],
            if (isProfessor && e.statusAvaliacao == 'PENDENTE') ...[
              const SizedBox(height: 12),
              PrimaryButton(text: 'Avaliar Entrega', icon: Icons.rate_review, onPressed: () => _mostrarDialogoAvaliacao(context, e.id)),
            ],
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoSubmissao(BuildContext context) {
    final comentarioController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Submeter Entrega'),
        content: AppTextField(label: 'Comentário (opcional)', controller: comentarioController, maxLines: 4),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () async {
              try {
                await _entregaService.submeter(widget.tarefaId, comentarioAluno: comentarioController.text.trim());
                if (!mounted) return;
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Entrega enviada!'), backgroundColor: Color(0xFF00663C)));
                _carregar();
              } catch (e) {
                if (!mounted) return;
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: $e')));
              }
            },
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }

  void _mostrarDialogoAvaliacao(BuildContext context, String entregaId) {
    final feedbackController = TextEditingController();
    String status = 'APROVADA';
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSt) => AlertDialog(
          title: const Text('Avaliar Entrega'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                value: 'APROVADA',
                groupValue: status,
                title: const Text('Aprovada'),
                onChanged: (v) => setSt(() => status = v!),
              ),
              RadioListTile<String>(
                value: 'NECESSITA_AJUSTE',
                groupValue: status,
                title: const Text('Necessita Ajuste'),
                onChanged: (v) => setSt(() => status = v!),
              ),
              AppTextField(label: 'Feedback', controller: feedbackController, maxLines: 3),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _entregaService.avaliar(
                    entregaId,
                    feedbackController.text.trim().isEmpty ? 'OK' : feedbackController.text.trim(),
                    status,
                  );
                  if (!mounted) return;
                  Navigator.pop(ctx);
                  _carregar();
                } catch (e) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: $e')));
                }
              },
              child: const Text('Avaliar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
