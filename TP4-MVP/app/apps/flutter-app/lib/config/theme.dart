import 'package:flutter/material.dart';

/// Tema do E-Project baseado em Material Design 3 (verde institucional UFAM).
class AppTheme {
  AppTheme._();

  // Verde institucional UFAM
  static const Color _primaryColor = Color(0xFF00663C);
  static const Color _secondaryColor = Color(0xFF00855B);
  static const Color _accentColor = Color(0xFF6A0DAD);
  static const Color _backgroundColor = Color(0xFFF7F9F8);
  static const Color _surfaceColor = Colors.white;
  static const Color _errorColor = Color(0xFFB00020);

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _primaryColor,
      primary: _primaryColor,
      secondary: _secondaryColor,
      tertiary: _accentColor,
      error: _errorColor,
      surface: _surfaceColor,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: _backgroundColor,

      appBarTheme: AppBarTheme(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _primaryColor,
          side: const BorderSide(color: _primaryColor),
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _errorColor),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),

      cardTheme: CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: _surfaceColor,
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: _primaryColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
      ),
    );
  }

  /// Cor por status de projeto.
  static Color statusProjetoColor(String status) {
    switch (status) {
      case 'EM_ANDAMENTO':
        return Colors.blue;
      case 'PENDENTE':
        return Colors.orange;
      case 'CONCLUIDO':
        return Colors.green;
      case 'CANCELADO':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  /// Cor por status de tarefa (Kanban).
  static Color statusTarefaColor(String status) {
    switch (status) {
      case 'A_FAZER':
        return Colors.orange;
      case 'EM_ANDAMENTO':
        return Colors.blue;
      case 'CONCLUIDO':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  /// Cor por status de avaliação de entrega.
  static Color statusAvaliacaoColor(String status) {
    switch (status) {
      case 'APROVADA':
        return Colors.green;
      case 'NECESSITA_AJUSTE':
        return Colors.orange;
      default:
        return Colors.blueGrey;
    }
  }
}
