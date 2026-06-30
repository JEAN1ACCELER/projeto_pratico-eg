import 'package:flutter/material.dart';
import 'package:provider/provider';
import '../services/settings_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final settingsService = Provider.of<SettingsService>(context);
    bool _notificationsEnabled = settingsService.notificationsEnabled;
    bool _darkModeEnabled = settingsService.darkModeEnabled;
    String _selectedLanguage = settingsService.selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue.shade700, Colors.blue.shade400],
                ),
              ),
              child: const Text(
                'Configurações',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Notificações',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  SwitchListTile(
                    title: const Text('Habilitar Notificações'),
                    subtitle: const Text('Receba notificações de tarefas e projetos'),
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      settingsService.setNotificationsEnabled(value);
                    },
                  ),
                  const Divider(),
                  const SizedBox(height: 20),
                  const Text(
                    'Aparência',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  SwitchListTile(
                    title: const Text('Modo Escuro'),
                    subtitle: const Text('Ativar tema escuro'),
                    value: _darkModeEnabled,
                    onChanged: (value) {
                      settingsService.setDarkModeEnabled(value);
                    },
                  ),
                  const Divider(),
                  const SizedBox(height: 20),
                  const Text(
                    'Idioma',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  DropdownButton<String>(
                    value: _selectedLanguage,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(
                        value: 'pt-BR',
                        child: Text('Português (Brasil)'),
                      ),
                      DropdownMenuItem(
                        value: 'en-US',
                        child: Text('English (United States)'),
                      ),
                      DropdownMenuItem(
                        value: 'es-ES',
                        child: Text('Español (España)'),
                      ),
                    ],
                    onChanged: (value) {
                      settingsService.setSelectedLanguage(value ?? 'pt-BR');
                    },
                  ),
                  const Divider(),
                  const SizedBox(height: 20),
                  const Text(
                    'Sobre',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'E-Project',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Versão: 1.0.0',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Plataforma de Gestão de Projetos Acadêmicos',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {
                                  _showDialog(
                                    'Termos de Uso',
                                    'Aqui estão os termos de uso da aplicação...',
                                  );
                                },
                                child: const Text('Termos'),
                              ),
                              TextButton(
                                onPressed: () {
                                  _showDialog(
                                    'Política de Privacidade',
                                    'Aqui está a política de privacidade da aplicação...',
                                  );
                                },
                                child: const Text('Privacidade'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Text(content),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}
