import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/projeto_provider.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import '../utils/helpers.dart';
import '../widgets/app_widgets.dart';
import 'projeto_detalhe_page.dart';
import 'projeto_form_page.dart';
import 'historico_page.dart';

class ProjetosPage extends StatefulWidget {
  const ProjetosPage({super.key});

  @override
  State<ProjetosPage> createState() => _ProjetosPageState();
}

class _ProjetosPageState extends State<ProjetosPage> {
  String _filtroStatus = 'TODOS';

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ProjetoProvider>().carregarProjetos());
  }

  List<MapEntry<String, String>> get _filtros => const [
    MapEntry('TODOS', 'Todos'),
    MapEntry('EM_ANDAMENTO', 'Em Andamento'),
    MapEntry('PENDENTE', 'Pendentes'),
    MapEntry('CONCLUIDO', 'Concluídos'),
    MapEntry('CANCELADO', 'Cancelados'),
  ];

  @override
  Widget build(BuildContext context) {
    final projProvider = context.watch<ProjetoProvider>();
    final auth = context.watch<AuthProvider>();
    final isProfessor = auth.isProfessor || auth.isAdmin;

    final projetosFiltrados = _filtroStatus == 'TODOS'
        ? projProvider.projetos
        : projProvider.projetos.where((p) => p.status == _filtroStatus).toList();

    return Scaffold(
      floatingActionButton: isProfessor
          ? FloatingActionButton(
              onPressed: () async {
                await Navigator.push(context, MaterialPageRoute(builder: (_) => const ProjetoFormPage()));
                if (!mounted) return;
                context.read<ProjetoProvider>().carregarProjetos();
              },
              child: const Icon(Icons.add),
            )
          : null,
      body: Column(
        children: [
          // Barra de filtros (chips de status)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _filtros.map((e) {
                  final selected = _filtroStatus == e.key;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(e.value),
                      selected: selected,
                      selectedColor: const Color(0xFF00663C),
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : Colors.black87,
                        fontSize: 13,
                      ),
                      onSelected: (_) => setState(() => _filtroStatus = e.key),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          // Lista de projetos
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => context.read<ProjetoProvider>().carregarProjetos(),
              child: projProvider.isLoading && projProvider.projetos.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : projetosFiltrados.isEmpty
                      ? EmptyState(
                          icon: Icons.folder_off,
                          message: 'Nenhum projeto encontrado',
                          buttonText: isProfessor ? 'Criar Projeto' : null,
                          onButtonPressed: isProfessor
                              ? () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProjetoFormPage()))
                              : null,
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: projetosFiltrados.length,
                          itemBuilder: (context, index) {
                            final p = projetosFiltrados[index];
                            return AppCard(
                              onTap: () async {
                                await Navigator.push(context, MaterialPageRoute(builder: (_) => ProjetoDetalhePage(projetoId: p.id)));
                                if (!mounted) return;
                                context.read<ProjetoProvider>().carregarProjetos();
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(child: Text(p.titulo, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                                      StatusChip(label: Helpers.statusProjetoLabel(p.status), color: AppTheme.statusProjetoColor(p.status)),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(Helpers.modalidadeLabel(p.modalidade), style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                                  if (p.resumo != null && p.resumo!.isNotEmpty) ...[
                                    const SizedBox(height: 4),
                                    Text(p.resumo!, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                                  ],
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      const Icon(Icons.task_alt, size: 16, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text('${p.tarefasConcluidas}/${p.totalTarefas} tarefas', style: const TextStyle(fontSize: 13)),
                                      const Spacer(),
                                      if (p.totalTarefas > 0)
                                        Expanded(
                                          child: LinearProgressIndicator(
                                            value: p.totalTarefas > 0 ? p.tarefasConcluidas / p.totalTarefas : 0,
                                            backgroundColor: Colors.grey.shade200,
                                            color: const Color(0xFF00663C),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
