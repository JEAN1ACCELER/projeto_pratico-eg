import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/app_widgets.dart';
import '../config/constants.dart';
import '../utils/validators.dart';
import 'home_shell.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _matriculaController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarController = TextEditingController();
  String _papel = 'ALUNO';
  bool _aceiteTermos = false;
  bool _aceitePrivacidade = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _matriculaController.dispose();
    _senhaController.dispose();
    _confirmarController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_aceiteTermos || !_aceitePrivacidade) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Aceite os Termos e a Política de Privacidade')));
      return;
    }
    final auth = context.read<AuthProvider>();
    final ok = await auth.register(
      nomeCompleto: _nomeController.text.trim(),
      emailInstitucional: _emailController.text.trim(),
      senha: _senhaController.text,
      papel: _papel,
      matricula: _matriculaController.text.trim().isEmpty ? null : _matriculaController.text.trim(),
    );
    if (!mounted) return;
    if (ok) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const HomeShell()), (_) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(auth.errorMessage ?? 'Erro ao cadastrar')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Criar Conta')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Icon(Icons.person_add, size: 64, color: Color(0xFF00663C)),
              const SizedBox(height: 16),
              const Text('Crie sua conta', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              AppTextField(label: 'Nome Completo', controller: _nomeController, prefixIcon: Icons.person, validator: Validators.nome),
              const SizedBox(height: 16),
              AppTextField(label: 'E-mail institucional', hint: 'seu.nome@ufam.edu.br', controller: _emailController, prefixIcon: Icons.email, keyboardType: TextInputType.emailAddress, validator: Validators.email),
              const SizedBox(height: 16),
              AppTextField(label: 'Matrícula (opcional)', controller: _matriculaController, prefixIcon: Icons.badge, keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _papel,
                decoration: const InputDecoration(labelText: 'Sou um...', prefixIcon: Icon(Icons.school)),
                items: const [
                  DropdownMenuItem(value: 'ALUNO', child: Text('Aluno Orientando')),
                  DropdownMenuItem(value: 'PROFESSOR', child: Text('Professor Orientador')),
                ],
                onChanged: (v) => setState(() => _papel = v ?? 'ALUNO'),
              ),
              const SizedBox(height: 16),
              AppTextField(label: 'Senha', controller: _senhaController, prefixIcon: Icons.lock, obscureText: true, validator: Validators.senha),
              const SizedBox(height: 16),
              AppTextField(label: 'Confirmar Senha', controller: _confirmarController, prefixIcon: Icons.lock_outline, obscureText: true, validator: (v) => Validators.confirmarSenha(v, _senhaController.text)),
              const SizedBox(height: 16),
              CheckboxListTile(value: _aceiteTermos, title: const Text('Aceito os Termos de Uso'), controlAffinity: ListTileControlAffinity.leading, onChanged: (v) => setState(() => _aceiteTermos = v ?? false)),
              CheckboxListTile(value: _aceitePrivacidade, title: const Text('Aceito a Política de Privacidade'), controlAffinity: ListTileControlAffinity.leading, onChanged: (v) => setState(() => _aceitePrivacidade = v ?? false)),
              const SizedBox(height: 16),
              PrimaryButton(text: 'Cadastrar', onPressed: _signup, isLoading: auth.isLoading),
              const SizedBox(height: 16),
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Já tenho conta')),
            ],
          ),
        ),
      ),
    );
  }
}
