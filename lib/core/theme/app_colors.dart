import 'package:flutter/material.dart';

/// App color palette following the design system
class AppColors {
  // Light Mode Colors
  static const Color lightPrimary = Color(0xFF6366F1); // Indigo
  static const Color lightSecondary = Color(0xFF8B5CF6); // Purple
  static const Color lightBackground = Color(0xFFF9FAFB); // Soft white
  static const Color lightCardBackground = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF111827);
  static const Color lightTextSecondary = Color(0xFF6B7280);
  static const Color lightSuccess = Color(0xFF10B981); // Green
  static const Color lightWarning = Color(0xFFF59E0B); // Amber
  static const Color lightError = Color(0xFFEF4444); // Red
  static const Color lightDivider = Color(0xFFE5E7EB);

  // Dark Mode Colors
  static const Color darkPrimary = Color(0xFF818CF8); // Lighter Indigo
  static const Color darkSecondary = Color(0xFFA78BFA); // Lighter Purple
  static const Color darkBackground = Color(0xFF111827);
  static const Color darkCardBackground = Color(0xFF1F2937);
  static const Color darkTextPrimary = Color(0xFFF9FAFB);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);
  static const Color darkSuccess = Color(0xFF34D399);
  static const Color darkWarning = Color(0xFFFBBF24);
  static const Color darkError = Color(0xFFF87171);
  static const Color darkDivider = Color(0xFF374151);

  // Priority Colors
  static const Color priorityHigh = Color(0xFFEF4444); // Red
  static const Color priorityMedium = Color(0xFFF59E0B); // Yellow
  static const Color priorityLow = Color(0xFF3B82F6); // Blue

  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFF6366F1),
    Color(0xFF8B5CF6),
  ];

  static const List<Color> successGradient = [
    Color(0xFF10B981),
    Color(0xFF6366F1),
  ];

  static const List<Color> darkGradient = [
    Color(0xFF818CF8),
    Color(0xFFA78BFA),
  ];

  // Accent Colors for customization
  static const List<Color> accentColors = [
    Color(0xFF6366F1), // Indigo
    Color(0xFF8B5CF6), // Purple
    Color(0xFFEC4899), // Pink
    Color(0xFFF59E0B), // Amber
    Color(0xFF10B981), // Green
    Color(0xFF3B82F6), // Blue
    Color(0xFFEF4444), // Red
    Color(0xFF14B8A6), // Teal
  ];
  // New Background Colors
  static const Color bgGray900 = Color(0xFF111827); // gray-900
  static const Color blue50 = Color(0xFFEFF6FF); // blue-50
  static const Color purple50 = Color(0xFFFAF5FF); // purple-50
  static const Color pink50 = Color(0xFFFDF2F8); // pink-50

  static const List<Color> lightBackgroundGradient = [
    blue50,
    purple50,
    pink50,
  ];

  static BoxDecoration getPageDecoration(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: isDark ? bgGray900 : null,
      gradient: isDark
          ? null
          : const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: lightBackgroundGradient,
              stops: [0.0, 0.5, 1.0],
            ),
    );
  }
}
