import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
      ],
      child: const AcadProApp(),
    ),
  );
}

class AcadProApp extends StatelessWidget {
  const AcadProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AcadPro App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
