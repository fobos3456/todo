import 'package:material_ui/material_ui.dart';

class AppTheme {
  static ThemeData get lightTheme {
    const primaryColor = Color(0xFF00668B);
    const primaryContainer = Color(0xFFC5E7FF);
    const secondaryColor = Color(0xFF006A60);
    const secondaryContainer = Color(0xFF9CF1E4);
    const surfaceColor = Colors.white;
    const errorColor = Color(0xFFBA1A1A);

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        primaryContainer: primaryContainer,
        secondary: secondaryColor,
        secondaryContainer: secondaryContainer,
        surface: surfaceColor,
        error: errorColor,
      ),
      scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF191C1E)),
        titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF191C1E)),
        bodyLarge: TextStyle(fontSize: 15, height: 1.5, color: Color(0xFF191C1E)),
        bodyMedium: TextStyle(fontSize: 14, height: 1.4, color: Color(0xFF40484C)),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: surfaceColor,
      ),
    );
  }
}
