import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notificacao_provider.dart';
import '../config/theme.dart';
import '../utils/helpers.dart';
import '../widgets/app_widgets.dart';

class NotificacoesPage extends StatefulWidget {
  const NotificacoesPage({super.key});

  @override
  State<NotificacoesPage> createState() => _NotificacoesPageState();
}

class _NotificacoesPageState extends State<NotificacoesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<NotificacaoProvider>().carregar());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotificacaoProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
        automaticallyImplyLeading: false,
        actions: [
          if (provider.naoLidas > 0)
            TextButton.icon(onPressed: () => provider.marcarTodas(), icon: const Icon(Icons.done_all, color: Colors.white), label: const Text('Marcar todas', style: TextStyle(color: Colors.white))),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => provider.carregar(),
        child: provider.isLoading && provider.notificacoes.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : provider.notificacoes.isEmpty
                ? const EmptyState(icon: Icons.notifications_off_outlined, message: 'Nenhuma notificação')
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: provider.notificacoes.length,
                    itemBuilder: (context, index) {
                      final n = provider.notificacoes[index];
                      return AppCard(
                        onTap: () {
                          if (!n.lida) provider.marcarComoLida(n.id);
                        },
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          CircleAvatar(backgroundColor: n.lida ? Colors.grey.shade200 : const Color(0xFF00663C).withOpacity(0.15), child: Icon(n.icon, color: n.lida ? Colors.grey : const Color(0xFF00663C))),
                          const SizedBox(width: 12),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(n.conteudo, style: TextStyle(fontWeight: n.lida ? FontWeight.normal : FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(Helpers.timeAgo(n.dataEnvio), style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          ])),
                          if (!n.lida) Container(width: 10, height: 10, decoration: const BoxDecoration(color: Color(0xFF00663C), shape: BoxShape.circle)),
                        ]),
                      );
                    },
                  ),
      ),
    );
  }
}
