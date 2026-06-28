import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/donation_provider.dart';
import '../widgets/layout/bottom_nav_bar.dart';
import '../widgets/layout/drawer_menu.dart';
import '../utils/constants.dart';

/// Tela 4: Dashboard com cards de métricas e gráficos.
/// Requisitos: fl_chart, Pull-to-Refresh, cards com métricas.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  Future<void> _loadData() async {
    final authProvider = context.read<AuthProvider>();
    final donationProvider = context.read<DonationProvider>();

    if (authProvider.currentUser != null) {
      await donationProvider.loadDonations(authProvider.currentUser!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final donationProvider = context.watch<DonationProvider>();
    final user = authProvider.currentUser;
    final stats = donationProvider.stats;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DoacaoMVP'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      drawer: const DrawerMenu(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go(AppConstants.formRoute),
        icon: const Icon(Icons.add),
        label: const Text('Nova Doação'),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Saudação
              _buildGreetingSection(user?.name ?? 'Usuário'),
              const SizedBox(height: 20),

              // Cards de métricas
              _buildMetricsGrid(stats),
              const SizedBox(height: 24),

              // Gráfico de doações
              Text(
                'Histórico de Doações',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              _buildDonationChart(stats),
              const SizedBox(height: 24),

              // Ações rápidas
              Text(
                'Ações Rápidas',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              _buildQuickActions(context),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreetingSection(String name) {
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? 'Bom dia'
        : hour < 18
            ? 'Boa tarde'
            : 'Boa noite';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$greeting, ${name.split(' ').first}!',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          'Você pode salvar até 3 vidas com uma única doação.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
        ),
      ],
    );
  }

  Widget _buildMetricsGrid(Map<String, int> stats) {
    final metrics = [
      _MetricData(
        title: 'Total',
        value: stats['total'] ?? 0,
        icon: Icons.bloodtype,
        color: Colors.red,
      ),
      _MetricData(
        title: 'Concluídas',
        value: stats['completed'] ?? 0,
        icon: Icons.check_circle,
        color: Colors.green,
      ),
      _MetricData(
        title: 'Agendadas',
        value: stats['scheduled'] ?? 0,
        icon: Icons.calendar_today,
        color: Colors.blue,
      ),
      _MetricData(
        title: 'Pendentes',
        value: stats['pending'] ?? 0,
        icon: Icons.pending,
        color: Colors.orange,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemCount: metrics.length,
      itemBuilder: (context, index) => _buildMetricCard(metrics[index]),
    );
  }

  Widget _buildMetricCard(_MetricData metric) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  metric.title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                Icon(metric.icon, color: metric.color, size: 20),
              ],
            ),
            Text(
              metric.value.toString(),
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: metric.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDonationChart(Map<String, int> stats) {
    final total = (stats['total'] ?? 0).toDouble();

    // Guard clause: exibe mensagem se não houver dados
    if (total == 0) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              children: [
                Icon(Icons.bar_chart, size: 48, color: Colors.grey.shade400),
                const SizedBox(height: 8),
                Text(
                  'Nenhuma doação registrada ainda.',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final sections = [
      PieChartSectionData(
        value: (stats['completed'] ?? 0).toDouble(),
        title: 'Concluídas',
        color: Colors.green,
        radius: 60,
        titleStyle: const TextStyle(fontSize: 11, color: Colors.white),
      ),
      PieChartSectionData(
        value: (stats['scheduled'] ?? 0).toDouble(),
        title: 'Agendadas',
        color: Colors.blue,
        radius: 60,
        titleStyle: const TextStyle(fontSize: 11, color: Colors.white),
      ),
      PieChartSectionData(
        value: (stats['pending'] ?? 0).toDouble(),
        title: 'Pendentes',
        color: Colors.orange,
        radius: 60,
        titleStyle: const TextStyle(fontSize: 11, color: Colors.white),
      ),
    ].where((s) => s.value > 0).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: sections,
              centerSpaceRadius: 40,
              sectionsSpace: 2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickActionCard(
            icon: Icons.add_circle_outline,
            label: 'Agendar\nDoação',
            color: Colors.red,
            onTap: () => context.go(AppConstants.formRoute),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickActionCard(
            icon: Icons.list_alt,
            label: 'Ver\nDoações',
            color: Colors.blue,
            onTap: () => context.go(AppConstants.listRoute),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickActionCard(
            icon: Icons.person_outline,
            label: 'Meu\nPerfil',
            color: Colors.green,
            onTap: () => context.go(AppConstants.profileRoute),
          ),
        ),
      ],
    );
  }
}

class _MetricData {
  final String title;
  final int value;
  final IconData icon;
  final Color color;

  const _MetricData({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
