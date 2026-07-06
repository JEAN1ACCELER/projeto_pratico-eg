import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/documento_service.dart';
import '../config/constants.dart';
import '../utils/helpers.dart';
import '../widgets/app_widgets.dart';
import 'historico_page.dart';
import 'login_page.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final u = auth.usuario;

    return Scaffold(
      appBar: AppBar(title: const Text('Meu Perfil'), automaticallyImplyLeading: false),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: const Color(0xFF00663C).withOpacity(0.1),
                  child: Text(
                    (u?.nomeCompleto.isNotEmpty ?? false) ? u!.nomeCompleto.substring(0, 1).toUpperCase() : '?',
                    style: const TextStyle(fontSize: 36, color: Color(0xFF00663C), fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                Text(u?.nomeCompleto ?? '', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                StatusChip(label: AppConstants.papelLabel[u?.papel ?? 'ALUNO'] ?? '', color: const Color(0xFF00663C)),
              ]),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(leading: const Icon(Icons.email), title: const Text('E-mail'), subtitle: Text(u?.emailInstitucional ?? '')),
                const Divider(height: 1),
                ListTile(leading: const Icon(Icons.badge), title: const Text('Matrícula'), subtitle: Text(u?.matricula ?? '—')),
                const Divider(height: 1),
                ListTile(leading: const Icon(Icons.business), title: const Text('Departamento'), subtitle: Text(u?.departamento ?? '—')),
                const Divider(height: 1),
                ListTile(leading: const Icon(Icons.calendar_today), title: const Text('Membro desde'), subtitle: Text(Helpers.formatDate(u?.dataCadastro))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.history, color: Colors.grey),
            title: const Text('Histórico de Projetos'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoricoPage())),
          ),
          ListTile(
            leading: const Icon(Icons.picture_as_pdf, color: Colors.grey),
            title: const Text('Baixar Relatório Geral (PDF)'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => DocumentoService().baixarRelatorioGeral(context),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () async {
              await auth.logout();
              if (!context.mounted) return;
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const LoginPage()), (_) => false);
            },
            icon: const Icon(Icons.logout, color: Colors.red),
            label: const Text('Sair da Conta', style: TextStyle(color: Colors.red)),
          ),
          const SizedBox(height: 24),
          Text('E-Project v1.0.0 • UFAM/ICET', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
        ],
      ),
    );
  }
}
