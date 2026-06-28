import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/donation_provider.dart';
import '../widgets/common/custom_button.dart';
import '../widgets/forms/donation_form.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';

/// Tela 8: Formulário de criação/edição de doação.
/// Utiliza DatePicker, Form e TextFormField com validação.
class FormPage extends StatefulWidget {
  final String? donationId;

  const FormPage({super.key, this.donationId});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();

  String? _selectedType;
  DateTime? _selectedDate;

  bool get _isEditing => widget.donationId != null;

  @override
  void dispose() {
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    // Refatoração #4 - Guard Clause: valida antes de prosseguir
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDate == null) {
      Helpers.showErrorSnackBar(context, 'Selecione uma data para a doação.');
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final donationProvider = context.read<DonationProvider>();

    if (authProvider.currentUser == null) return;

    final success = await donationProvider.createDonation(
      userId: authProvider.currentUser!.id,
      donationType: _selectedType!,
      scheduledDate: _selectedDate!,
      location: _locationController.text.trim(),
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      Helpers.showSuccessSnackBar(context, AppConstants.donationCreatedMessage);
      context.go(AppConstants.listRoute);
    } else {
      Helpers.showErrorSnackBar(
        context,
        donationProvider.errorMessage ?? AppConstants.genericErrorMessage,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final donationProvider = context.watch<DonationProvider>();
    final isLoading = donationProvider.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Doação' : 'Agendar Doação'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.go(AppConstants.listRoute),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho informativo
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.red.shade700),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Agende sua doação com antecedência. '
                      'Lembre-se de estar bem hidratado e alimentado.',
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Text(
              'Dados da Doação',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            // Formulário de doação
            DonationForm(
              formKey: _formKey,
              locationController: _locationController,
              notesController: _notesController,
              selectedType: _selectedType,
              selectedDate: _selectedDate,
              onTypeChanged: (type) => setState(() => _selectedType = type),
              onDateChanged: (date) => setState(() => _selectedDate = date),
            ),
            const SizedBox(height: 32),

            // Botão de submissão
            CustomButton(
              label: _isEditing ? 'Salvar Alterações' : 'Agendar Doação',
              onPressed: isLoading ? null : _handleSubmit,
              isLoading: isLoading,
              icon: _isEditing ? Icons.save : Icons.calendar_today,
            ),
            const SizedBox(height: 16),

            // Botão cancelar
            CustomButton(
              label: 'Cancelar',
              isOutlined: true,
              onPressed: () => context.go(AppConstants.listRoute),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
