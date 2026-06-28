import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'services/storage_service.dart';
import 'app/app.dart';

/// Ponto de entrada da aplicação DoacaoMVP.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configura a orientação para retrato
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Inicializa o serviço de armazenamento local (Hive)
  await StorageService.instance.init();

  runApp(const App());
}
