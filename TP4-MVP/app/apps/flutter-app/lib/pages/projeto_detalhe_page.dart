import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/projeto.dart';
import '../models/tarefa.dart';
import '../providers/auth_provider.dart';
import '../providers/projeto_provider.dart';
import '../services/documento_service.dart';
import '../services/tarefa_service.dart';
import '../services/reuniao_service.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import '../utils/helpers.dart';
import '../widgets/app_widgets.dart';
import 'tarefa_detalhe_page.dart';
import 'tarefa_form_page.dart';
import 'reuniao_page.dart';

class ProjetoDetalhePage extends StatefulWidget {
  final String projetoId;
  const ProjetoDetalhePage({super.key, required this.projetoId});

  @override
  State<ProjetoDetalhePage> createState() => _ProjetoDetalhePageState();
}

class _ProjetoDetalhePageState extends State<ProjetoDetalhePage> {
  Projeto? _projeto;
  List<Tarefa> _tarefas = [];
  bool _isLoading = true;
  final _tarefaService = TarefaService();
  final _reuniaoService = ReuniaoService();

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    setState(() => _isLoading = true);
    try {
      final projeto = await context.read<ProjetoProvider>().service.buscarPorId(widget.projetoId);
      final tarefas = await _tarefaService.listarPorProjeto(widget.projetoId);
      setState(() {
        _projeto = projeto;
        _tarefas = tarefas;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _baixarRelatorio() async {
    final titulo = _projeto?.titulo ?? 'projeto';
    await DocumentoService().baixarRelatorioProjeto(context, widget.projetoId, titulo);
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final isProfessor = auth.isProfessor || auth.isAdmin;

    if (_isLoading) {
      return Scaffold(appBar: AppBar(), body: const Center(child: CircularProgressIndicator()));
    }
    if (_projeto == null) {
      return Scaffold(appBar: AppBar(title: const Text('Projeto')), body: const Center(child: Text('Projeto não encontrado')));
    }
    final p = _projeto!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(p.titulo, maxLines: 1, overflow: TextOverflow.ellipsis),
          actions: [
            IconButton(icon: const Icon(Icons.picture_as_pdf), onPressed: _baixarRelatorio, tooltip: 'Gerar Relatório'),
          ],
          bottom: const TabBar(tabs: [Tab(text: 'Visão Geral'), Tab(text: 'Reuniões')], labelColor: Colors.white, unselectedLabelColor: Colors.white70),
        ),
        body: TabBarView(
          children: [
            // Tab 1: Visão Geral + Tarefas
            RefreshIndicator(
              onRefresh: _carregar,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(p.titulo, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        StatusChip(label: Helpers.statusProjetoLabel(p.status), color: AppTheme.statusProjetoColor(p.status)),
                        const SizedBox(height: 12),
                        _infoRow(Icons.category, Helpers.modalidadeLabel(p.modalidade)),
                        _infoRow(Icons.calendar_today, 'Vigência: ${Helpers.formatDate(p.dataInicio)} - ${Helpers.formatDate(p.dataTermino)}'),
                        if (p.orientadorNome != null) _infoRow(Icons.person, 'Orientador: ${p.orientadorNome}'),
                        if (p.orientandoNome != null) _infoRow(Icons.school, 'Orientando: ${p.orientandoNome}'),
                        if (p.resumo != null) ...[const SizedBox(height: 12), Text(p.resumo!, style: const TextStyle(fontSize: 14))],
                      ]),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    const Text('Tarefas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    if (isProfessor)
                      TextButton.icon(onPressed: () async {
                        await Navigator.push(context, MaterialPageRoute(builder: (_) => TarefaFormPage(projetoId: widget.projetoId)));
                        _carregar();
                      }, icon: const Icon(Icons.add), label: const Text('Nova')),
                  ]),
                  if (_tarefas.isEmpty)
                    const EmptyState(icon: Icons.task, message: 'Nenhuma tarefa neste projeto')
                  else
                    ..._tarefas.map((t) => AppCard(
                          onTap: () async {
                            await Navigator.push(context, MaterialPageRoute(builder: (_) => TarefaDetalhePage(tarefaId: t.id)));
                            _carregar();
                          },
                          child: Row(children: [
                            Icon(Icons.task, color: AppTheme.statusTarefaColor(t.status)),
                            const SizedBox(width: 12),
                            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(t.titulo, style: const TextStyle(fontWeight: FontWeight.w600)),
                              if (t.prazo != null) Text('Prazo: ${Helpers.formatDate(t.prazo)}', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                            ])),
                            StatusChip(label: Helpers.statusTarefaLabel(t.status), color: AppTheme.statusTarefaColor(t.status)),
                          ]),
                        )),
                ],
              ),
            ),
            // Tab 2: Reuniões
            ReuniaoTab(projetoId: widget.projetoId, reuniaoService: _reuniaoService, isProfessor: isProfessor),
          ],
        ),
        floatingActionButton: isProfessor
            ? FloatingActionButton(
                onPressed: () async {
                  await Navigator.push(context, MaterialPageRoute(builder: (_) => TarefaFormPage(projetoId: widget.projetoId)));
                  _carregar();
                },
                child: const Icon(Icons.add_task),
              )
            : null,
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(children: [Icon(icon, size: 18, color: Colors.grey.shade600), const SizedBox(width: 8), Expanded(child: Text(text, style: TextStyle(fontSize: 14)))]),
    );
  }
}

/// Tab de reuniões dentro do detalhe do projeto.
class ReuniaoTab extends StatefulWidget {
  final String projetoId;
  final ReuniaoService reuniaoService;
  final bool isProfessor;
  const ReuniaoTab({super.key, required this.projetoId, required this.reuniaoService, required this.isProfessor});

  @override
  State<ReuniaoTab> createState() => _ReuniaoTabState();
}

class _ReuniaoTabState extends State<ReuniaoTab> {
  List<dynamic> _reunioes = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    setState(() => _loading = true);
    try {
      _reunioes = await widget.reuniaoService.listarPorProjeto(widget.projetoId);
    } catch (_) {}
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    return RefreshIndicator(
      onRefresh: _carregar,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (widget.isProfessor)
            PrimaryButton(text: 'Agendar Reunião', icon: Icons.event_available, onPressed: () async {
              final date = await showDatePicker(context: context, initialDate: DateTime.now().add(const Duration(days: 1)), firstDate: DateTime.now(), lastDate: DateTime(2035));
              if (date == null || !mounted) return;
              final time = await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 14, minute: 0));
              if (time == null || !mounted) return;
              final dt = DateTime(date.year, date.month, date.day, time.hour, time.minute);
              try {
                await widget.reuniaoService.criar(widget.projetoId, {'dataHora': dt.toIso8601String(), 'local': 'A definir'});
                _carregar();
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: $e')));
              }
            }),
          const SizedBox(height: 16),
          if (_reunioes.isEmpty)
            const EmptyState(icon: Icons.event_busy, message: 'Nenhuma reunião agendada')
          else
            ..._reunioes.map((r) => AppCard(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ReuniaoPage(reuniaoId: r.id, isProfessor: widget.isProfessor))),
                  child: Row(children: [
                    const Icon(Icons.event, color: Color(0xFF00663C)),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(Helpers.formatDateTime(r.dataHora), style: const TextStyle(fontWeight: FontWeight.w600)),
                      if (r.local != null) Text(r.local!, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                      Text('${r.presencas.length} presentes', style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                    ])),
                    if (widget.isProfessor && r.pinCheckIn != null) Chip(label: Text('PIN: ${r.pinCheckIn}')),
                  ]),
                )),
        ],
      ),
    );
  }
}
