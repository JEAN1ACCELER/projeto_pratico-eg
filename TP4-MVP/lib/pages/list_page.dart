import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/donation_model.dart';
import '../providers/auth_provider.dart';
import '../providers/donation_provider.dart';
import '../widgets/common/loading_indicator.dart';
import '../widgets/layout/bottom_nav_bar.dart';
import '../app/theme.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';

/// Tela 6: Listagem de doações com FutureBuilder e ListView.builder.
class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  String _filterStatus = 'Todos';

  static const List<String> _statusFilters = [
    'Todos',
    'Pendente',
    'Agendada',
    'Concluída',
    'Cancelada',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadDonations());
  }

  Future<void> _loadDonations() async {
    final authProvider = context.read<AuthProvider>();
    final donationProvider = context.read<DonationProvider>();
    if (authProvider.currentUser != null) {
      await donationProvider.loadDonations(authProvider.currentUser!.id);
    }
  }

  List<DonationModel> _getFilteredDonations(List<DonationModel> donations) {
    if (_filterStatus == 'Todos') return donations;
    return donations.where((d) => d.status == _filterStatus).toList();
  }

  @override
  Widget build(BuildContext context) {
    final donationProvider = context.watch<DonationProvider>();
    final filtered = _getFilteredDonations(donationProvider.donations);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Doações'),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go(AppConstants.formRoute),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Filtros por status
          _buildFilterChips(),

          // Lista de doações
          Expanded(
            child: donationProvider.isLoading
                ? const LoadingIndicator(message: 'Carregando doações...')
                : RefreshIndicator(
                    onRefresh: _loadDonations,
                    child: filtered.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: filtered.length,
                            itemBuilder: (context, index) =>
                                _buildDonationCard(filtered[index]),
                          ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: _statusFilters
            .map(
              (status) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(status),
                  selected: _filterStatus == status,
                  onSelected: (selected) {
                    if (selected) setState(() => _filterStatus = status);
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildDonationCard(DonationModel donation) {
    final statusColor = AppTheme.statusColor(donation.status);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.go(AppConstants.detailsRoute, extra: donation.id),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Ícone de tipo
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.bloodtype, color: Colors.red),
              ),
              const SizedBox(width: 12),

              // Informações
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      donation.donationType,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      donation.location ?? 'Local não informado',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      Formatters.formatDate(donation.scheduledDate),
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // Status badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor.withOpacity(0.3)),
                ),
                child: Text(
                  donation.status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bloodtype_outlined, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'Nenhuma doação encontrada.',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: () => context.go(AppConstants.formRoute),
            icon: const Icon(Icons.add),
            label: const Text('Agendar primeira doação'),
          ),
        ],
      ),
    );
  }
}
