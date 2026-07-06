import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/projeto_provider.dart';
import '../config/theme.dart';
import '../utils/helpers.dart';
import '../widgets/app_widgets.dart';
import 'projeto_detalhe_page.dart';

/// Tela dedicada ao histórico de projetos concluídos/cancelados.
class HistoricoPage extends StatefulWidget {
  const HistoricoPage({super.key});

  @override
  State<HistoricoPage> createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ProjetoProvider>().carregarHistorico());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProjetoProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Projetos')),
      body: RefreshIndicator(
        onRefresh: () => context.read<ProjetoProvider>().carregarHistorico(),
        child: provider.historico.isEmpty
            ? const EmptyState(
                icon: Icons.history_toggle_off,
                message: 'Nenhum projeto concluído ou cancelado ainda',
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: provider.historico.length,
                itemBuilder: (context, index) {
                  final p = provider.historico[index];
                  return AppCard(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ProjetoDetalhePage(projetoId: p.id)),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.folder_special, color: Color(0xFF00663C)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                p.titulo,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            StatusChip(
                              label: Helpers.statusProjetoLabel(p.status),
                              color: AppTheme.statusProjetoColor(p.status),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(Helpers.modalidadeLabel(p.modalidade),
                            style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.check_circle_outline, size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text('${p.tarefasConcluidas}/${p.totalTarefas} tarefas',
                                style: const TextStyle(fontSize: 12, color: Colors.grey)),
                            const SizedBox(width: 12),
                            if (p.orientadorNome != null) ...[
                              const Icon(Icons.person_outline, size: 14, color: Colors.grey),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  p.orientadorNome!,
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
