import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/reuniao_service.dart';
import '../models/reuniao.dart';
import '../config/theme.dart';
import '../utils/helpers.dart';
import '../widgets/app_widgets.dart';

class ReuniaoPage extends StatefulWidget {
  final String reuniaoId;
  final bool isProfessor;
  const ReuniaoPage({super.key, required this.reuniaoId, required this.isProfessor});

  @override
  State<ReuniaoPage> createState() => _ReuniaoPageState();
}

class _ReuniaoPageState extends State<ReuniaoPage> {
  Reuniao? _reuniao;
  bool _isLoading = true;
  final _service = ReuniaoService();

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    setState(() => _isLoading = true);
    try {
      final lista = await _service.listarPorProjeto('');
      // Buscar via presencas API direta é mais simples: buscar uma a uma não é ideal.
      // Como o detalhe vem da lista do projeto, usamos listarPresencas para mostrar.
    } catch (_) {}
    setState(() => _isLoading = false);
  }

  Future<void> _checkIn() async {
    final pinController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Check-in de Presença'),
        content: AppTextField(label: 'PIN da Reunião', controller: pinController, keyboardType: TextInputType.number),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
          ElevatedButton(onPressed: () async {
            try {
              await _service.checkIn(widget.reuniaoId, pinController.text.trim());
              if (!mounted) return;
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Presença registrada! ✓'), backgroundColor: Color(0xFF00663C)));
              _carregar();
            } catch (e) {
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: $e')));
            }
          }, child: const Text('Confirmar')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Reunião')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<List<Presenca>>(
              future: _service.listarPresencas(widget.reuniaoId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final presencas = snapshot.data ?? [];
                return RefreshIndicator(
                  onRefresh: _carregar,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            const Text('Lista de Presença', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text('${presencas.length} participantes', style: TextStyle(color: Colors.grey.shade600)),
                          ]),
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (presencas.isEmpty)
                        const EmptyState(icon: Icons.people_outline, message: 'Nenhuma presença registrada')
                      else
                        ...presencas.map((p) => AppCard(child: Row(children: [
                          const CircleAvatar(child: Icon(Icons.person, color: Color(0xFF00663C)), backgroundColor: Color(0x1A00663C)),
                          const SizedBox(width: 12),
                          Expanded(child: Text(p.usuarioNome)),
                          const Icon(Icons.check_circle, color: Colors.green),
                        ]))),
                      const SizedBox(height: 24),
                      if (auth.isAluno)
                        PrimaryButton(text: 'Fazer Check-in', icon: Icons.how_to_reg, onPressed: _checkIn),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
