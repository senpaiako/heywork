import 'package:flutter/material.dart';

class TColors {
  TColors._();

  // Basic Primary Colors (Inspired by Facebook and Twitter)
  static const Color primary = Color(0xFF2098E1); // Twitter Blue
  static const Color secondary = Color(0xFF0056b3); // Facebook Dark Blue
  static const Color accent = Color(0xFFB0C7FF); // Light Blue Accent

  // Text Colors
  static const Color textPrimary =
      Colors.black; // For text on light backgrounds
  static const Color textWhite = Colors.white; // For text on dark backgrounds
  static const Color textSecondary =
      Color(0xFF6C757D); // Medium grey for secondary text

  // Background Colors
  static const Color lightBackground =
      Color(0xFFF1F3F5); // Light grey background
  static const Color darkBackground =
      Color(0xFF1F1F1F); // Dark grey for dark mode

  // Container Colors
  static const Color lightContainer =
      Color(0xFFFFFFFF); // White container for light background
  static const Color darkContainer =
      Color(0xFF2C2C2C); // Dark container for dark background

  // Button Colors
  static const Color buttonPrimary =
      Color(0xFF2098E1); // Primary button color (blue)
  static const Color buttonSecondary =
      Color(0xFF0056b3); // Dark blue for secondary buttons
  static const Color buttonDisabled =
      Color(0xFFC4C4C4); // Grey for disabled buttons

  // Border Colors
  static const Color borderLight =
      Color(0xFFE0E0E0); // Light grey for borders in light mode
  static const Color borderDark =
      Color(0xFF3A3A3A); // Dark grey for borders in dark mode

  // Error and Validation Colors
  static const Color error = Color(0xFFD32F2F); // Red for error states
  static const Color success = Color(0xFF388E3C); // Green for success states
  static const Color warning = Color(0xFFF57C00); // Orange for warnings
  static const Color info =
      Color(0xFF17A2B8); // Teal for informational messages

  // Neutral Shades
  static const Color black =
      Color(0xFF232323); // Black for text and icons on light backgrounds
  static const Color darkGrey =
      Color(0xFF6C757D); // Medium grey for neutral elements
  static const Color lightGrey =
      Color(0xFFBDBDBD); // Light grey for subtle elements
}
