import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../common/custom_textfield.dart';
import '../../utils/validators.dart';

/// Formulário de dados do usuário reutilizável.
class UserForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController cepController;
  final TextEditingController cnsController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool showPasswordFields;

  const UserForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.cepController,
    required this.cnsController,
    required this.passwordController,
    required this.confirmPasswordController,
    this.showPasswordFields = true,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            label: 'Nome Completo',
            controller: nameController,
            prefixIcon: Icons.person,
            validator: Validators.validateName,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'E-mail',
            controller: emailController,
            prefixIcon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            validator: Validators.validateEmail,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'CEP',
            controller: cepController,
            prefixIcon: Icons.location_on,
            keyboardType: TextInputType.number,
            maxLength: 9,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              _CepInputFormatter(),
            ],
            validator: Validators.validateCep,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'CNS (Cartão Nacional de Saúde)',
            controller: cnsController,
            prefixIcon: Icons.credit_card,
            keyboardType: TextInputType.number,
            maxLength: 15,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: Validators.validateCns,
            textInputAction:
                showPasswordFields ? TextInputAction.next : TextInputAction.done,
          ),
          if (showPasswordFields) ...[
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Senha',
              controller: passwordController,
              prefixIcon: Icons.lock,
              obscureText: true,
              validator: Validators.validatePassword,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Confirmar Senha',
              controller: confirmPasswordController,
              prefixIcon: Icons.lock_outline,
              obscureText: true,
              validator: (value) => Validators.validatePasswordConfirmation(
                value,
                passwordController.text,
              ),
              textInputAction: TextInputAction.done,
            ),
          ],
        ],
      ),
    );
  }
}

/// Formatador de CEP: insere o hífen automaticamente.
class _CepInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (text.length <= 5) return newValue.copyWith(text: text);
    final formatted = '${text.substring(0, 5)}-${text.substring(5)}';
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
