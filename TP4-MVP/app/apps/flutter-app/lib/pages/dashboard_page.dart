import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/auth_provider.dart';
import '../providers/projeto_provider.dart';
import '../providers/notificacao_provider.dart';
import '../services/documento_service.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import '../utils/helpers.dart';
import '../widgets/app_widgets.dart';
import 'projeto_detalhe_page.dart';
import 'historico_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProjetoProvider>().carregarProjetos();
      context.read<NotificacaoProvider>().carregar();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final projProvider = context.watch<ProjetoProvider>();
    final projetos = projProvider.projetos;

    final ativos = projetos.where((p) => p.status == 'EM_ANDAMENTO').length;
    final concluidos = projetos.where((p) => p.status == 'CONCLUIDO').length;
    final pendentes = projetos.where((p) => p.status == 'PENDENTE').length;
    final totalTarefas = projetos.fold<int>(0, (s, p) => s + p.totalTarefas);
    final tarefasConcluidas = projetos.fold<int>(0, (s, p) => s + p.tarefasConcluidas);

    return RefreshIndicator(
      onRefresh: () => context.read<ProjetoProvider>().carregarProjetos(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Saudação + ações rápidas
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Olá, ${auth.usuario?.nomeCompleto.split(' ').first ?? ''}!', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Text(AppConstants.papelLabel[auth.papel ?? 'ALUNO'] ?? '', style: TextStyle(color: Colors.grey.shade600)),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Histórico de Projetos',
                icon: const Icon(Icons.history),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoricoPage())),
              ),
              IconButton(
                tooltip: 'Baixar Relatório Geral (PDF)',
                icon: const Icon(Icons.picture_as_pdf),
                onPressed: () => DocumentoService().baixarRelatorioGeral(context),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Cards de métricas
          GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.4, children: [
            _MetricCard(title: 'Projetos Ativos', value: '$ativos', icon: Icons.folder_open, color: Colors.blue),
            _MetricCard(title: 'Concluídos', value: '$concluidos', icon: Icons.check_circle, color: Colors.green),
            _MetricCard(title: 'Pendentes', value: '$pendentes', icon: Icons.pending, color: Colors.orange),
            _MetricCard(title: 'Tarefas', value: '$tarefasConcluidas/$totalTarefas', icon: Icons.task_alt, color: const Color(0xFF00663C)),
          ]),
          const SizedBox(height: 24),

          // Gráfico de progresso
          if (totalTarefas > 0) ...[
            const Text('Progresso das Tarefas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 40,
                sections: [
                  PieChartSectionData(value: tarefasConcluidas.toDouble(), color: Colors.green, title: 'Concluídas', radius: 50, titleStyle: const TextStyle(color: Colors.white, fontSize: 11)),
                  PieChartSectionData(value: (totalTarefas - tarefasConcluidas).toDouble(), color: Colors.orange, title: 'Pendentes', radius: 50, titleStyle: const TextStyle(color: Colors.white, fontSize: 11)),
                ],
              )),
            ),
            const SizedBox(height: 24),
          ],

          // Projetos recentes
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Projetos Recentes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(onPressed: () {}, child: const Text('Ver todos')),
          ]),
          const SizedBox(height: 8),

          if (projProvider.isLoading)
            const Center(child: Padding(padding: EdgeInsets.all(40), child: CircularProgressIndicator()))
          else if (projetos.isEmpty)
            const EmptyState(icon: Icons.folder_off, message: 'Nenhum projeto ainda')
          else
            ...projetos.take(3).map((p) => AppCard(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProjetoDetalhePage(projetoId: p.id))),
                  child: Row(children: [
                    CircleAvatar(backgroundColor: const Color(0xFF00663C).withOpacity(0.1), child: const Icon(Icons.folder, color: Color(0xFF00663C))),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(p.titulo, style: const TextStyle(fontWeight: FontWeight.w600)),
                      Text('${Helpers.modalidadeLabel(p.modalidade)} • ${p.tarefasConcluidas}/${p.totalTarefas} tarefas', style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                    ])),
                    StatusChip(label: Helpers.statusProjetoLabel(p.status), color: AppTheme.statusProjetoColor(p.status)),
                  ]),
                )),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  const _MetricCard({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [Icon(icon, color: color, size: 20), const SizedBox(width: 6), Expanded(child: Text(title, style: TextStyle(fontSize: 12, color: Colors.grey.shade600), overflow: TextOverflow.ellipsis))]),
          Text(value, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: color)),
        ]),
      ),
    );
  }
}

