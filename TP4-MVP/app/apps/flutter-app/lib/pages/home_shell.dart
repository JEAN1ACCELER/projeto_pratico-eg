import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/notificacao_provider.dart';
import '../config/theme.dart';
import 'dashboard_page.dart';
import 'projetos_page.dart';
import 'editais_page.dart';
import 'notificacoes_page.dart';
import 'perfil_page.dart';

/// Shell principal com BottomNavigationBar (após login).
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    DashboardPage(),
    ProjetosPage(),
    EditaisPage(),
    NotificacoesPage(),
    PerfilPage(),
  ];

  @override
  void initState() {
    super.initState();
    // Carregar notificações ao abrir
    Future.microtask(() {
      context.read<NotificacaoProvider>().carregar();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final notifProvider = context.watch<NotificacaoProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Project'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          // Badge de notificações
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  setState(() => _currentIndex = 3);
                },
              ),
              if (notifProvider.naoLidas > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                    child: Text(
                      notifProvider.naoLidas > 9 ? '9+' : '${notifProvider.naoLidas}',
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Center(
              child: Text(auth.usuario?.nomeCompleto.split(' ').first ?? '', style: const TextStyle(color: Colors.white, fontSize: 14)),
            ),
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'Projetos'),
          BottomNavigationBarItem(icon: Icon(Icons.campaign), label: 'Editais'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Alertas'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
