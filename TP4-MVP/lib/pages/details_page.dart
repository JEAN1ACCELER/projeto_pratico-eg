import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/donation_model.dart';
import '../providers/auth_provider.dart';
import '../providers/donation_provider.dart';
import '../app/theme.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';
import '../utils/helpers.dart';

/// Tela 7: Detalhes de uma doação com Hero animation e SliverAppBar.
class DetailsPage extends StatefulWidget {
  final String donationId;

  const DetailsPage({super.key, required this.donationId});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  DonationModel? _donation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadDonation());
  }

  void _loadDonation() {
    final donationProvider = context.read<DonationProvider>();
    try {
      _donation = donationProvider.donations.firstWhere(
        (d) => d.id == widget.donationId,
      );
      setState(() {});
    } catch (_) {
      // Doação não encontrada
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_donation == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalhes')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final statusColor = AppTheme.statusColor(_donation!.status);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar com Hero animation
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(_donation!.donationType),
              background: Hero(
                tag: 'donation-${_donation!.id}',
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.primary.withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Icon(Icons.bloodtype, size: 80, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),

          // Conteúdo
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: statusColor),
                        ),
                        child: Text(
                          _donation!.status,
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Informações detalhadas
                  _buildDetailCard(context),
                  const SizedBox(height: 20),

                  // Ações
                  _buildActionsSection(context),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informações da Doação',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Divider(height: 24),
            _buildDetailRow(
              icon: Icons.bloodtype,
              label: 'Tipo de Doação',
              value: _donation!.donationType,
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              icon: Icons.calendar_today,
              label: 'Data Agendada',
              value: Formatters.formatDate(_donation!.scheduledDate),
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              icon: Icons.location_on,
              label: 'Local',
              value: _donation!.location ?? 'Não informado',
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              icon: Icons.access_time,
              label: 'Registrado em',
              value: Formatters.formatDateTime(_donation!.createdAt),
            ),
            if (_donation!.notes != null && _donation!.notes!.isNotEmpty) ...[
              const SizedBox(height: 12),
              _buildDetailRow(
                icon: Icons.notes,
                label: 'Observações',
                value: _donation!.notes!,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                value,
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionsSection(BuildContext context) {
    final isPending = _donation!.status == AppConstants.statusPending;
    final isScheduled = _donation!.status == AppConstants.statusScheduled;

    return Column(
      children: [
        if (isPending)
          ElevatedButton.icon(
            onPressed: () => _updateStatus(AppConstants.statusScheduled),
            icon: const Icon(Icons.calendar_today),
            label: const Text('Confirmar Agendamento'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          ),
        if (isScheduled) ...[
          ElevatedButton.icon(
            onPressed: () => _updateStatus(AppConstants.statusCompleted),
            icon: const Icon(Icons.check_circle),
            label: const Text('Marcar como Concluída'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          ),
          const SizedBox(height: 8),
        ],
        if (isPending || isScheduled) ...[
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () => _handleDelete(context),
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            label: const Text('Cancelar Doação',
                style: TextStyle(color: Colors.red)),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.red),
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _updateStatus(String status) async {
    final donationProvider = context.read<DonationProvider>();
    await donationProvider.updateStatus(_donation!.id, status);

    if (!mounted) return;

    setState(() {
      _donation = _donation!.copyWith(status: status);
    });
    Helpers.showSuccessSnackBar(context, 'Status atualizado com sucesso!');
  }

  Future<void> _handleDelete(BuildContext context) async {
    final confirmed = await Helpers.showConfirmDialog(
      context,
      title: 'Cancelar Doação',
      message: 'Tem certeza que deseja cancelar esta doação?',
      confirmText: 'Cancelar Doação',
    );

    if (!confirmed || !context.mounted) return;

    final donationProvider = context.read<DonationProvider>();
    await donationProvider.updateStatus(_donation!.id, AppConstants.statusCancelled);

    if (!context.mounted) return;
    Helpers.showSuccessSnackBar(context, 'Doação cancelada.');
    context.go(AppConstants.listRoute);
  }
}
