import 'package:flutter/material.dart';
import '../common/custom_textfield.dart';
import '../../utils/constants.dart';
import '../../utils/validators.dart';

/// Formulário de criação/edição de doação.
class DonationForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController locationController;
  final TextEditingController notesController;
  final String? selectedType;
  final DateTime? selectedDate;
  final void Function(String?) onTypeChanged;
  final void Function(DateTime) onDateChanged;

  const DonationForm({
    super.key,
    required this.formKey,
    required this.locationController,
    required this.notesController,
    required this.selectedType,
    required this.selectedDate,
    required this.onTypeChanged,
    required this.onDateChanged,
  });

  @override
  State<DonationForm> createState() => _DonationFormState();
}

class _DonationFormState extends State<DonationForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tipo de doação
          DropdownButtonFormField<String>(
            value: widget.selectedType,
            decoration: const InputDecoration(
              labelText: 'Tipo de Doação',
              prefixIcon: Icon(Icons.bloodtype),
            ),
            items: AppConstants.donationTypes
                .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                .toList(),
            onChanged: widget.onTypeChanged,
            validator: (value) =>
                value == null ? 'Selecione o tipo de doação.' : null,
          ),
          const SizedBox(height: 16),

          // Data agendada
          CustomTextField(
            label: 'Data Agendada',
            controller: TextEditingController(
              text: widget.selectedDate != null
                  ? '${widget.selectedDate!.day.toString().padLeft(2, '0')}/${widget.selectedDate!.month.toString().padLeft(2, '0')}/${widget.selectedDate!.year}'
                  : '',
            ),
            prefixIcon: Icons.calendar_today,
            readOnly: true,
            onTap: () => _selectDate(context),
            validator: (_) =>
                widget.selectedDate == null ? 'Selecione uma data.' : null,
          ),
          const SizedBox(height: 16),

          // Local
          CustomTextField(
            label: 'Local (Hemocentro)',
            controller: widget.locationController,
            prefixIcon: Icons.location_on,
            validator: Validators.required,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 16),

          // Observações
          TextFormField(
            controller: widget.notesController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Observações (opcional)',
              prefixIcon: Icon(Icons.notes),
              alignLabelWithHint: true,
            ),
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      locale: const Locale('pt', 'BR'),
    );
    if (picked != null) {
      widget.onDateChanged(picked);
    }
  }
}
