import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:tp4_mvp/models/user.dart';
import 'package:tp4_mvp/services/auth_service.dart';
import 'package:tp4_mvp/services/database_service.dart';
import 'package:tp4_mvp/components/app_logo.dart';
import 'package:tp4_mvp/components/custom_text_field.dart';
import 'package:tp4_mvp/components/primary_button.dart';
import 'package:tp4_mvp/components/terms_dialog.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _cnsController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _acceptedTerms = false;
  bool _acceptedPrivacy = false;
  String _errorMessage = '';
  String _selectedRole = 'donor';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _cnsController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String email) {
    if (!EmailValidator.validate(email)) {
      return 'Email inválido';
    }
    return null;
  }

  String? _validatePassword(String password) {
    if (password.length < 6) {
      return 'Senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  void _signup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Clear any previous error message
    setState(() {
      _errorMessage = '';
    });

    if (!_acceptedTerms || !_acceptedPrivacy) {
      setState(() {
        _errorMessage = 'Você deve aceitar os Termos de Uso e Política de Privacidade';
      });
      return;
    }

    final user = User(
      name: _nameController.text,
      email: _emailController.text,
      cpf: _cpfController.text,
      cns: _cnsController.text,
      role: _selectedRole,
      createdAt: DateTime.now(),
      acceptedTerms: _acceptedTerms,
      acceptedPrivacy: _acceptedPrivacy,
    );

    final authService = Provider.of<AuthService>(context, listen: false);
    final databaseService = Provider.of<DatabaseService>(context, listen: false);

    // Check for uniqueness before attempting signup
    if (!await databaseService.isEmailUnique(_emailController.text)) {
      setState(() {
        _errorMessage = 'Este email já está cadastrado.';
      });
      return;
    }
    if (!await databaseService.isCpfUnique(_cpfController.text)) {
      setState(() {
        _errorMessage = 'Este CPF já está cadastrado.';
      });
      return;
    }
    if (!await databaseService.isCnsUnique(_cnsController.text)) {
      setState(() {
        _errorMessage = 'Este CNS já está cadastrado.';
      });
      return;
    }

    final success = await authService.signup(user, _passwordController.text);

    if (success) {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/dashboard');
      }
    } else {
      setState(() {
        _errorMessage = authService.errorMessage ?? 'Erro ao criar conta. Tente novamente.';
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
      appBar: AppBar(
        title: const Text('Cadastro'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
              const AppLogo(icon: Icons.person_add),
              const SizedBox(height: 20),
              const Text(
                'Crie sua conta',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _nameController,
                labelText: 'Nome Completo',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu nome completo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: _emailController,
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu email';
                  }
                  if (!EmailValidator.validate(value)) {
                    return 'Email inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: _cpfController,
                labelText: 'CPF',
                hintText: '000.000.000-00',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu CPF';
                  }
                  if (!User.isValidCpf(value)) {
                    return 'CPF inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: _cnsController,
                labelText: 'CNS (Cartão Nacional de Saúde)',
                hintText: 'Seu número de CNS',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu CNS';
                  }
                  if (!User.isValidCns(value)) {
                    return 'CNS inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                decoration: InputDecoration(
                  labelText: 'Tipo de Usuário',
                  prefixIcon: const Icon(Icons.category),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: 'donor', child: Text('Doador')),
                  DropdownMenuItem(value: 'recipient', child: Text('Receptor')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value ?? 'donor';
                  });
                },
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: _passwordController,
                labelText: 'Senha',
                hintText: '••••••••',
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
              const SizedBox(height: 15),
              CustomTextField(
                controller: _confirmPasswordController,
                labelText: 'Confirmar Senha',
                hintText: '••••••••',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, confirme sua senha';
                  }
                  if (value != _passwordController.text) {
                    return 'As senhas não correspondem';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
                  ],
                ),
              ),
              CheckboxListTile(
                title: const Text('Aceito os Termos de Uso'),
                value: _acceptedTerms,
                onChanged: (value) {
                  setState(() {
                    _acceptedTerms = value ?? false;
                  });
                },
                secondary: GestureDetector(
                  onTap: _showTermsDialog,
                  child: const Icon(Icons.info),
                ),
              ),
              CheckboxListTile(
                title: const Text('Aceito a Política de Privacidade'),
                value: _acceptedPrivacy,
                onChanged: (value) {
                  setState(() {
                    _acceptedPrivacy = value ?? false;
                  });
                },
                secondary: GestureDetector(
                  onTap: _showTermsDialog,
                  child: const Icon(Icons.info),
                ),
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
                        text: 'Cadastrar',
                        onPressed: _signup,
                        isLoading: authService.isLoading,
                      ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
