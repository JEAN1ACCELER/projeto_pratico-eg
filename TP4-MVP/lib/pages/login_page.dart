import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/common/custom_button.dart';
import '../widgets/common/custom_textfield.dart';
import '../utils/constants.dart';
import '../utils/validators.dart';
import '../utils/helpers.dart';

/// Tela 2: Login com autenticação por e-mail e senha.
/// Requisitos: validação de campos, SnackBar de erro, redirecionamento.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    // Refatoração #4 - Guard Clause: valida o formulário antes de prosseguir
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.login(
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      Helpers.showSuccessSnackBar(context, AppConstants.loginSuccessMessage);
      context.go(AppConstants.homeRoute);
    } else {
      Helpers.showErrorSnackBar(
        context,
        authProvider.errorMessage ?? AppConstants.loginErrorMessage,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final isLoading = authProvider.status == AuthStatus.loading;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),

              // Logo e título
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.bloodtype, size: 48, color: Colors.white),
              ),
              const SizedBox(height: 16),
              Text(
                'DoacaoMVP',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Faça login para continuar',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
              ),
              const SizedBox(height: 40),

              // Formulário de login
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      label: 'E-mail',
                      controller: _emailController,
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.validateEmail,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      label: 'Senha',
                      controller: _passwordController,
                      prefixIcon: Icons.lock_outlined,
                      obscureText: true,
                      validator: Validators.validatePassword,
                      textInputAction: TextInputAction.done,
                    ),
                  ],
                ),
              ),

              // Esqueci minha senha
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => _showForgotPasswordDialog(),
                  child: const Text('Esqueci minha senha'),
                ),
              ),
              const SizedBox(height: 8),

              // Botão de login
              CustomButton(
                label: 'Entrar',
                onPressed: isLoading ? null : _handleLogin,
                isLoading: isLoading,
                icon: Icons.login,
              ),
              const SizedBox(height: 16),

              // Link para cadastro
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Não tem uma conta?'),
                  TextButton(
                    onPressed: () => context.go(AppConstants.registerRoute),
                    child: const Text('Cadastre-se'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Recuperar Senha'),
        content: const Text(
          'Para recuperar sua senha, entre em contato com o suporte ou cadastre-se novamente.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}
