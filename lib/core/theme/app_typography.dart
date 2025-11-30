import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography system using Inter font family
class AppTypography {
  // Headings
  static TextStyle heading1(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.inter(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      height: 1.2,
      color: color ?? (isDark ? Colors.white : const Color(0xFF111827)),
    );
  }

  static TextStyle heading2(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.inter(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      height: 1.3,
      color: color ?? (isDark ? Colors.white : const Color(0xFF111827)),
    );
  }

  static TextStyle heading3(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.inter(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      height: 1.3,
      color: color ?? (isDark ? Colors.white : const Color(0xFF111827)),
    );
  }

  static TextStyle heading4(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 1.4,
      color: color ?? (isDark ? Colors.white : const Color(0xFF111827)),
    );
  }

  // Body text
  static TextStyle bodyLarge(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      height: 1.5,
      color: color ?? (isDark ? const Color(0xFFF9FAFB) : const Color(0xFF111827)),
    );
  }

  static TextStyle bodyMedium(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      height: 1.5,
      color: color ?? (isDark ? const Color(0xFFF9FAFB) : const Color(0xFF111827)),
    );
  }

  static TextStyle bodySmall(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      height: 1.5,
      color: color ?? (isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280)),
    );
  }

  // Captions
  static TextStyle caption(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.4,
      color: color ?? (isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280)),
    );
  }

  static TextStyle captionBold(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      height: 1.4,
      color: color ?? (isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280)),
    );
  }

  // Button text
  static TextStyle button(BuildContext context, {Color? color}) {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.2,
      letterSpacing: 0.5,
      color: color ?? Colors.white,
    );
  }

  static TextStyle buttonSmall(BuildContext context, {Color? color}) {
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.2,
      letterSpacing: 0.5,
      color: color ?? Colors.white,
    );
  }

  // Labels
  static TextStyle label(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.4,
      color: color ?? (isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280)),
    );
  }

  static TextStyle labelBold(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.4,
      color: color ?? (isDark ? const Color(0xFFF9FAFB) : const Color(0xFF111827)),
    );
  }
}
