import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp4_mvp/services/auth_service.dart';
import 'package:tp4_mvp/components/app_logo.dart';
import 'package:tp4_mvp/components/custom_text_field.dart';
import 'package:tp4_mvp/components/primary_button.dart';
import 'package:tp4_mvp/components/terms_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Clear any previous error message
    setState(() {
      _errorMessage = '';
    });

    final authService = Provider.of<AuthService>(context, listen: false);
    final success = await authService.login(
      _emailController.text,
      _passwordController.text,
    );

    if (success) {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/dashboard');
      }
    } else {
      setState(() {
        _errorMessage = 'Email ou senha incorretos';
      });
    }
  }

  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (context) => const TermsDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue.shade700, Colors.blue.shade400],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppLogo(),
              const SizedBox(height: 20),
              const Text(
                'E-Project',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                    const Text(
                      'Bem-vindo de volta',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
              CustomTextField(
                controller: _emailController,
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu email';
                  }
                  // Basic email format validation
                  if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                    return 'Email inválido';
                  }
                  return null;
                },
              ),
                    const SizedBox(height: 15),
              CustomTextField(
                controller: _passwordController,
                labelText: 'Senha',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira sua senha';
                  }
                  if (value.length < 6) {
                    return 'Senha deve ter pelo menos 6 caracteres';
                  }
                  return null;
                },
              ),
                    if (_errorMessage.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _errorMessage,
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    Consumer<AuthService>(
                      builder: (context, authService, _) {
                        return SizedBox(
                          width: double.infinity,
                          child: PrimaryButton(
                            text: 'Entrar',
                            onPressed: _login,
                            isLoading: authService.isLoading,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Não tem conta? '),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/signup');
                          },
                          child: const Text(
                            'Cadastre-se',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
              GestureDetector(
                      onTap: _showTermsDialog,
                      child: const Text(
                        'Termos de Uso e Política de Privacidade',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
