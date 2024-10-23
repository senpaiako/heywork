import 'package:flutter/material.dart';

class TColors {
  TColors._();

  // App Basic Colors
  static const Color primary =
      Color(0xFF2098E1); // Primary blue (RGB 32, 152, 225)
  static const Color secondary =
      Color(0xFF0056b3); // Darker blue for secondary actions
  static const Color accent = Color(0xFFB0C7FF); // Light blue accent

  // Text Colors
  static const Color textPrimary = Colors.black; // Primary text color (black)
  static const Color textSecondary =
      Color(0xFF6C757D); // Medium grey for secondary text
  static const Color textWhite = Colors.white; // White text

  // Background Colors
  static const Color light = Color(0xFFFFFFFF); // White background
  static const Color dark =
      Color(0xFFf8f9fa); // Very light grey for dark backgrounds
  static const Color primaryBackground =
      Color.fromARGB(255, 168, 210, 245); // Light blue background

  // Background Container Colors
  static const Color lightContainer = Color(0xFFFFFFFF); // White container
  static const Color darkContainer =
      Color(0xFFE1E1E1); // Light grey container for contrast

  // Button Colors
  static const Color buttonPrimary =
      Color(0xFF2098E1); // Primary button color (blue)
  static const Color buttonSecondary =
      Color(0xFF0056b3); // Secondary button color (dark blue)
  static const Color buttonDisabled =
      Color(0xFFC4C4C4); // Disabled button color (grey)

  // Border Colors
  static const Color borderPrimary = Color(0xFFD9D9D9); // Light border
  static const Color borderSecondary =
      Color(0xFFE6E6E6); // Slightly darker border

  // Error and Validation Colors
  static const Color error = Color(0xFFD32F2F); // Error color (red)
  static const Color success = Color(0xFF388E3C); // Success color (green)
  static const Color warning = Color(0xFFF57C00); // Warning color (orange)
  static const Color info = Color(0xFF17A2B8); // Info color (teal)

  // Neutral Shades
  static const Color black = Color(0xFF232323); // Black color
  static const Color darkerGrey = Color(0xFF4F4F4F); // Darker grey
  static const Color darkGrey = Color(0xFF939393); // Medium grey
  static const Color grey = Color(0xFFE0E0E0); // Light grey
}
