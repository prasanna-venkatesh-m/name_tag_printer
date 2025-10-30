import 'package:flutter/material.dart';
import 'screens/qr_label_preview_screen.dart';

void main() {
  // String apiUrl = 'https://greatshinyphone95.conveyor.cloud'; //LOCAL
  String apiUrl = 'https://stage-techxconf-api.azurewebsites.net';     //STAGE
  // String apiUrl = 'https://prod-techxconf-api.azurewebsites.net';      //PROD

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF6366F1), // Modern indigo
        onPrimary: Colors.white,
        secondary: Color(0xFF10B981), // Fresh green
        onSecondary: Colors.white,
        tertiary: Color(0xFFF59E0B), // Warm amber
        surface: Colors.white,
        onSurface: Color(0xFF1F2937),
        background: Color(0xFFF9FAFB),
        onBackground: Color(0xFF1F2937),
        error: Color(0xFFEF4444),
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: Color(0xFFF9FAFB),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1F2937),
          letterSpacing: -0.5,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF374151),
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: Color(0xFF4B5563),
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: Color(0xFF6B7280),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF6366F1),
        foregroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF6366F1),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
          shadowColor: Color(0xFF6366F1).withOpacity(0.3),
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.white,
        shadowColor: Colors.black.withOpacity(0.05),
      ),
    ),
    home: QRLabelPreviewScreen(apiUrl: apiUrl),
  ));
}
