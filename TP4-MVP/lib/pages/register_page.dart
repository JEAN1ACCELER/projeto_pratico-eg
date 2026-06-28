import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/common/custom_button.dart';
import '../widgets/forms/user_form.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';

/// Tela 3: Cadastro de usuário.
/// Rastreabilidade H6: "Enquanto doador em potencial, quero me cadastrar
/// no aplicativo e receber por e-mail um guia com orientações de uso."
///
/// Campos: Nome completo, E-mail, CEP, CNS (15 dígitos), Senha.
/// Validação em tempo real e persistência com Hive.
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cepController = TextEditingController();
  final _cnsController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _selectedBloodType;

  static const List<String> _bloodTypes = [
    'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _cepController.dispose();
    _cnsController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    // Refatoração #4 - Guard Clause: valida antes de prosseguir
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.register(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      cep: _cepController.text.trim(),
      cns: _cnsController.text.trim(),
      password: _passwordController.text,
      bloodType: _selectedBloodType,
    );

    if (!mounted) return;

    if (success) {
      Helpers.showSuccessSnackBar(context, AppConstants.registerSuccessMessage);
      context.go(AppConstants.homeRoute);
    } else {
      Helpers.showErrorSnackBar(
        context,
        authProvider.errorMessage ?? AppConstants.genericErrorMessage,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final isLoading = authProvider.status == AuthStatus.loading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.go(AppConstants.loginRoute),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bem-vindo!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                'Preencha os dados abaixo para se cadastrar.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
              ),
              const SizedBox(height: 24),

              // Formulário de cadastro (UserForm - widget extraído)
              UserForm(
                formKey: _formKey,
                nameController: _nameController,
                emailController: _emailController,
                cepController: _cepController,
                cnsController: _cnsController,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
              ),
              const SizedBox(height: 16),

              // Tipo sanguíneo (opcional)
              DropdownButtonFormField<String>(
                value: _selectedBloodType,
                decoration: const InputDecoration(
                  labelText: 'Tipo Sanguíneo (opcional)',
                  prefixIcon: Icon(Icons.bloodtype),
                ),
                items: _bloodTypes
                    .map((type) =>
                        DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _selectedBloodType = value),
              ),
              const SizedBox(height: 24),

              // Informação sobre o e-mail (H6)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue.shade700),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Após o cadastro, você receberá um e-mail com orientações de uso.',
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Botão de cadastro
              CustomButton(
                label: 'Criar Conta',
                onPressed: isLoading ? null : _handleRegister,
                isLoading: isLoading,
                icon: Icons.person_add,
              ),
              const SizedBox(height: 16),

              // Link para login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Já tem uma conta?'),
                  TextButton(
                    onPressed: () => context.go(AppConstants.loginRoute),
                    child: const Text('Faça login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
