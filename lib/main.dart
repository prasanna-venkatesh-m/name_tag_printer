import 'package:flutter/material.dart';
import 'screens/qr_label_preview_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF2196F3),
        onPrimary: Colors.white,
        secondary: Color(0xFFFF5722),
        onSecondary: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black,
        background: Color(0xFFF5F5F5),
        onBackground: Colors.black,
        error: Colors.red,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: Color(0xFFF5F5F5),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color.fromARGB(136, 182, 181, 181),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFF5722),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: TextStyle(fontSize: 16),
        ),
      ),
    ),
    home: QRLabelPreviewScreen(
        apiUrl: "https://stage-techxconf-api.azurewebsites.net"),
  ));
}
//https://greatshinyphone95.conveyor.cloud
//https://stage-techxconf-api.azurewebsites.net
//https://prod-techxconf-api.azurewebsites.net
