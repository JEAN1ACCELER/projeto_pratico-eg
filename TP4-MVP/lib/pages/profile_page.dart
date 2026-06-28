import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/common/custom_button.dart';
import '../widgets/layout/bottom_nav_bar.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';
import '../utils/helpers.dart';

/// Tela 5: Perfil do usuário com informações e configurações.
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header com avatar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.white,
                    child: Text(
                      user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.email,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  if (user.bloodType != null) ...[
                    const SizedBox(height: 8),
                    Chip(
                      label: Text(
                        'Tipo: ${user.bloodType}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: Colors.white.withOpacity(0.2),
                    ),
                  ],
                ],
              ),
            ),

            // Informações do perfil
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informações Pessoais',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(context, [
                    _InfoItem(
                      icon: Icons.person,
                      label: 'Nome',
                      value: user.name,
                    ),
                    _InfoItem(
                      icon: Icons.email,
                      label: 'E-mail',
                      value: user.email,
                    ),
                    _InfoItem(
                      icon: Icons.location_on,
                      label: 'CEP',
                      value: Formatters.formatCep(user.cep),
                    ),
                    _InfoItem(
                      icon: Icons.credit_card,
                      label: 'CNS',
                      value: Formatters.formatCns(user.cns),
                    ),
                    _InfoItem(
                      icon: Icons.calendar_today,
                      label: 'Membro desde',
                      value: Formatters.formatDate(user.createdAt),
                    ),
                  ]),
                  const SizedBox(height: 20),

                  // Configurações
                  Text(
                    'Configurações',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: Column(
                      children: [
                        SwitchListTile(
                          title: const Text('Notificações'),
                          subtitle: const Text('Receber lembretes de doação'),
                          secondary: const Icon(Icons.notifications),
                          value: _notificationsEnabled,
                          onChanged: (value) {
                            setState(() => _notificationsEnabled = value);
                          },
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.description),
                          title: const Text('Termos de Uso'),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () => _showTermsDialog(context),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Botão de logout
                  CustomButton(
                    label: 'Sair da Conta',
                    isOutlined: true,
                    icon: Icons.logout,
                    color: Colors.red,
                    onPressed: () => _handleLogout(context),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, List<_InfoItem> items) {
    return Card(
      child: Column(
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return Column(
            children: [
              ListTile(
                leading: Icon(item.icon,
                    color: Theme.of(context).colorScheme.primary),
                title: Text(item.label,
                    style: const TextStyle(
                        fontSize: 12, color: Colors.grey)),
                subtitle: Text(item.value,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500)),
              ),
              if (index < items.length - 1) const Divider(height: 1),
            ],
          );
        }).toList(),
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    final confirmed = await Helpers.showConfirmDialog(
      context,
      title: 'Sair',
      message: 'Tem certeza que deseja sair da sua conta?',
      confirmText: 'Sair',
      cancelText: 'Cancelar',
    );

    if (!confirmed || !context.mounted) return;

    final authProvider = context.read<AuthProvider>();
    await authProvider.logout();
    if (context.mounted) context.go(AppConstants.loginRoute);
  }

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Termos de Uso'),
        content: const SingleChildScrollView(
          child: Text(
            'Ao utilizar o DoacaoMVP, você concorda com os termos e condições '
            'estabelecidos para o uso do aplicativo. Os dados fornecidos serão '
            'utilizados exclusivamente para fins de gestão de doações de sangue. '
            'Para mais informações, consulte o arquivo docs/termos-de-uso.md.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}

class _InfoItem {
  final IconData icon;
  final String label;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });
}
