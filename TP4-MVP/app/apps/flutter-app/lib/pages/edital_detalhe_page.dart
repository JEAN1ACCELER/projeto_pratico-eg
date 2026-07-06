import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/edital.dart';
import '../config/theme.dart';
import '../utils/helpers.dart';
import '../widgets/app_widgets.dart';

/// Tela de detalhe de um edital, com link externo para o edital original.
class EditalDetalhePage extends StatelessWidget {
  final Edital edital;
  const EditalDetalhePage({super.key, required this.edital});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do Edital')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Cabeçalho
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.campaign, color: Color(0xFF00663C), size: 32),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          edital.titulo,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (edital.modalidade != null)
                    StatusChip(label: Helpers.modalidadeLabel(edital.modalidade!), color: const Color(0xFF00663C)),
                  const SizedBox(height: 16),

                  // Campos de informação
                  _infoRow(Icons.account_balance, 'Fonte', edital.fonte ?? '—'),
                  _infoRow(Icons.calendar_today, 'Publicação', Helpers.formatDate(edital.dataPublicacao)),
                  if (edital.dataEncerramento != null) ...[
                    _infoRow(Icons.event, 'Encerramento', Helpers.formatDate(edital.dataEncerramento)),
                    // Badge de prazo
                    const SizedBox(height: 8),
                    _buildPrazoBadge(edital.dataEncerramento!),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Descrição
          if (edital.descricao != null && edital.descricao!.isNotEmpty) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Descrição', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(edital.descricao!, style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Link externo
          if (edital.linkOriginal != null) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Edital Oficial', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Theme.of(context).colorScheme.primary, decoration: TextDecoration.underline),
                        text: edital.linkOriginal!,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => _abrirLink(edital.linkOriginal!),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Botão para abrir link
          if (edital.linkOriginal != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PrimaryButton(
                text: 'Abrir Edital Original',
                icon: Icons.open_in_new,
                onPressed: () => _abrirLink(edital.linkOriginal!),
              ),
            ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildPrazoBadge(DateTime dataEncerramento) {
    final agora = DateTime.now();
    final dias = dataEncerramento.difference(agora).inDays;
    final isExpirado = dias < 0;
    final isUrgente = dias >= 0 && dias <= 15;

    Color bg;
    String texto;
    if (isExpirado) {
      bg = Colors.red.shade100;
      texto = 'Encerrado há ${-dias} dias';
    } else if (isUrgente) {
      bg = Colors.orange.shade100;
      texto = dias == 0 ? 'Encerra hoje!' : '$dias dias restantes';
    } else {
      bg = Colors.green.shade100;
      texto = '$dias dias restantes';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isExpirado ? Icons.event_busy : isUrgente ? Icons.warning : Icons.event_available,
            size: 16,
            color: isExpirado ? Colors.red : isUrgente ? Colors.orange : Colors.green,
          ),
          const SizedBox(width: 6),
          Text(texto, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isExpirado ? Colors.red : Colors.black87)),
        ],
      ),
    );
  }

  Future<void> _abrirLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
