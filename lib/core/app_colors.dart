import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors
  static Color backgroundColor = const Color.fromARGB(255, 99, 2, 120);
  static Color secondaryColor = const Color.fromARGB(255, 49, 158, 2);

  // Additional Colors
  static Color primaryPurple = const Color.fromARGB(255, 99, 2, 120);
  static Color primaryGreen = const Color.fromARGB(255, 49, 158, 2);
  
  // Neutral Colors
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color grey = Colors.grey;
  static Color lightGrey = const Color(0xFFF5F5F5);
  static Color darkGrey = const Color(0xFF424242);
  
  // Status Colors
  static Color success = const Color(0xFF4CAF50);
  static Color warning = const Color(0xFFFF9800);
  static Color error = const Color(0xFFF44336);
  static Color info = const Color(0xFF2196F3);
  
  // Gradient Colors
  static Color lightPurple = const Color(0xFFBA68C8);
  static Color lightGreen = const Color(0xFF81C784);
  
  // Text Colors
  static Color textPrimary = const Color(0xFF212121);
  static Color textSecondary = const Color(0xFF757575);
  static Color textHint = const Color(0xFF9E9E9E);
  
  // Background Colors
  static Color surfaceColor = Colors.white;
  static Color cardBackground = Colors.white;
  
  // Shadow Colors
  static Color shadowColor = Colors.black.withOpacity(0.1);
}