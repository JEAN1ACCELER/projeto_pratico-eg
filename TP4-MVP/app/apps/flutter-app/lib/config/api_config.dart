import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb, kDebugMode;

/// Configuração de conexão com a API E-Project.
///
/// O endereço é escolhido automaticamente conforme a plataforma onde o app roda:
/// - Web (Chrome/Edge): usa `localhost` (mesma máquina do backend).
/// - Android (emulador): usa `10.0.2.2` (alias do host local no emulador).
/// - Android (físico) / iOS (físico): use o IP da máquina na rede (ex.: 192.168.x.x).
/// - Windows/macOS/Linux (desktop): usa `localhost`.
class ApiConfig {
  static String get baseUrl {
    // Rodando no navegador (Flutter Web) -> localhost
    if (kIsWeb) return 'http://localhost:3000';

    // Plataformas nativas
    if (Platform.isAndroid) {
      // Emulador Android acessa o host via 10.0.2.2.
      // Em dispositivo físico, troque pelo IP do seu computador (ex.: 192.168.0.10).
      return 'http://10.0.2.2:3000';
    }

    // Desktop (Windows/macOS/Linux) e iOS simulator -> localhost
    return 'http://localhost:3000';
  }

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 15);

  /// Indica se estamos em modo debug (para mensagens de log, etc.).
  static const bool isDebug = kDebugMode;
}
