import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/projeto_provider.dart';
import 'providers/notificacao_provider.dart';
import 'config/theme.dart';
import 'pages/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const EProjectApp());
}

class EProjectApp extends StatelessWidget {
  const EProjectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProjetoProvider()),
        ChangeNotifierProvider(create: (_) => NotificacaoProvider()),
      ],
      child: MaterialApp(
        title: 'E-Project',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
