import 'package:flutter/material.dart';
import '../services/edital_service.dart';
import '../models/edital.dart';
import '../config/theme.dart';
import '../utils/helpers.dart';
import '../widgets/app_widgets.dart';
import 'edital_detalhe_page.dart';

class EditaisPage extends StatefulWidget {
  const EditaisPage({super.key});

  @override
  State<EditaisPage> createState() => _EditaisPageState();
}

class _EditaisPageState extends State<EditaisPage> {
  final _service = EditalService();
  List<Edital> _editais = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    setState(() => _isLoading = true);
    try {
      _editais = await _service.listar();
    } catch (_) {}
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editais Abertos'), automaticallyImplyLeading: false),
      body: RefreshIndicator(
        onRefresh: _carregar,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _editais.isEmpty
                ? const EmptyState(icon: Icons.campaign_outlined, message: 'Nenhum edital aberto no momento')
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _editais.length,
                    itemBuilder: (context, index) {
                      final e = _editais[index];
                      return AppCard(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EditalDetalhePage(edital: e))),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(children: [
                            const Icon(Icons.campaign, color: Color(0xFF00663C)),
                            const SizedBox(width: 8),
                            Expanded(child: Text(e.titulo, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                            const Icon(Icons.chevron_right, color: Colors.grey),
                          ]),
                          const SizedBox(height: 8),
                          if (e.modalidade != null) StatusChip(label: Helpers.modalidadeLabel(e.modalidade!), color: const Color(0xFF00663C)),
                          const SizedBox(height: 8),
                          if (e.descricao != null) Text(e.descricao!, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
                          const SizedBox(height: 8),
                          Row(children: [
                            if (e.fonte != null) ...[const Icon(Icons.account_balance, size: 14, color: Colors.grey), const SizedBox(width: 4), Text(e.fonte!, style: const TextStyle(fontSize: 12, color: Colors.grey))],
                            const Spacer(),
                            if (e.dataEncerramento != null) ...[const Icon(Icons.event, size: 14, color: Colors.grey), const SizedBox(width: 4), Text('Encerra: ${Helpers.formatDate(e.dataEncerramento)}', style: const TextStyle(fontSize: 12, color: Colors.grey))],
                          ]),
                        ]),
                      );
                    },
                  ),
      ),
    );
  }
}
