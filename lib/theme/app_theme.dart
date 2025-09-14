import 'package:flutter/material.dart';

// ---------------------------------------------------------
// app_theme.dart
// Centralized ThemeData for the application.
// ---------------------------------------------------------

// Brand colors
const Color kPrimary = Color(0xFFE34C23);
const Color kAccent = Color(0xFFFC8A5A);
const Color kBorder = Color(0xFFE5E7EB);
const double kRadius = 12.0;

// Selection colors (from your Figma)
const Color kSelectionDark = Color(0xFF253747);
const Color kSelectionLight = Color(0xFFF3F4F6);
const Color kSelectionGrey = Color(0xFF9CA3AF);
const Color kSelectionWhite = Color(0xFFFFFFFF); // ✅ semantic white
const Color kSelectionBlue = Color(0xFF1F2937);
const Color kSelectionOrange = Color(0xFFE34C23);
const Color kSelectionCharcoal = Color(0xFF4B5563);
const Color kSelectionTeal = Color(0xFF6B7280);
const Color kSelectionGreen = Color(0xFF16A34A);
const Color kSelectionGreenLight = Color(0xFFF0FDF4); // ✅ new subtle green bg
const Color kSelectionSky = Color(0xFF7BE29E);
const Color kSelectionNeutral = Color(0xFFE5E7EB);

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color? primary;
  final Color? accent;
  final Color? border;

  // Add selection colors here
  final Color? selectionDark;
  final Color? selectionLight;
  final Color? selectionGrey;
  final Color? selectionWhite;
  final Color? selectionBlue;
  final Color? selectionOrange;
  final Color? selectionCharcoal;
  final Color? selectionTeal;
  final Color? selectionGreen;
  final Color? selectionGreenLight;
  final Color? selectionSky;
  final Color? selectionNeutral;

  const AppColors({
    this.primary,
    this.accent,
    this.border,
    this.selectionDark,
    this.selectionLight,
    this.selectionGrey,
    this.selectionWhite,
    this.selectionBlue,
    this.selectionOrange,
    this.selectionCharcoal,
    this.selectionTeal,
    this.selectionGreen,
    this.selectionGreenLight,
    this.selectionSky,
    this.selectionNeutral,
  });

  @override
  AppColors copyWith({
    Color? primary,
    Color? accent,
    Color? border,
    Color? selectionDark,
    Color? selectionLight,
    Color? selectionGrey,
    Color? selectionWhite,
    Color? selectionBlue,
    Color? selectionOrange,
    Color? selectionCharcoal,
    Color? selectionTeal,
    Color? selectionGreen,
    Color? selectionGreenLight,
    Color? selectionSky,
    Color? selectionNeutral,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      accent: accent ?? this.accent,
      border: border ?? this.border,
      selectionDark: selectionDark ?? this.selectionDark,
      selectionLight: selectionLight ?? this.selectionLight,
      selectionGrey: selectionGrey ?? this.selectionGrey,
      selectionWhite: selectionWhite ?? this.selectionWhite,
      selectionBlue: selectionBlue ?? this.selectionBlue,
      selectionOrange: selectionOrange ?? this.selectionOrange,
      selectionCharcoal: selectionCharcoal ?? this.selectionCharcoal,
      selectionTeal: selectionTeal ?? this.selectionTeal,
      selectionGreen: selectionGreen ?? this.selectionGreen,
      selectionGreenLight: selectionGreenLight ?? this.selectionGreenLight,
      selectionSky: selectionSky ?? this.selectionSky,
      selectionNeutral: selectionNeutral ?? this.selectionNeutral,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t),
      accent: Color.lerp(accent, other.accent, t),
      border: Color.lerp(border, other.border, t),
      selectionDark: Color.lerp(selectionDark, other.selectionDark, t),
      selectionLight: Color.lerp(selectionLight, other.selectionLight, t),
      selectionGrey: Color.lerp(selectionGrey, other.selectionGrey, t),
      selectionWhite: Color.lerp(selectionWhite, other.selectionWhite, t),
      selectionBlue: Color.lerp(selectionBlue, other.selectionBlue, t),
      selectionOrange: Color.lerp(selectionOrange, other.selectionOrange, t),
      selectionCharcoal: Color.lerp(selectionCharcoal, other.selectionCharcoal, t),
      selectionTeal: Color.lerp(selectionTeal, other.selectionTeal, t),
      selectionGreen: Color.lerp(selectionGreen, other.selectionGreen, t),
      selectionGreenLight: Color.lerp(selectionGreenLight, other.selectionGreenLight, t),
      selectionSky: Color.lerp(selectionSky, other.selectionSky, t),
      selectionNeutral: Color.lerp(selectionNeutral, other.selectionNeutral, t),
    );
  }
}

ThemeData buildAppTheme({bool dark = false}) {
  final seed = kPrimary;

  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: seed,
      brightness: dark ? Brightness.dark : Brightness.light,
    ),
    scaffoldBackgroundColor: kSelectionWhite, // ✅ always use semantic white
  );

  return base.copyWith(
    extensions: <ThemeExtension<dynamic>>[
      const AppColors(
        primary: kPrimary,
        accent: kAccent,
        border: kBorder,
        selectionDark: kSelectionDark,
        selectionLight: kSelectionLight,
        selectionGrey: kSelectionGrey,
        selectionWhite: kSelectionWhite, // ✅ semantic white
        selectionBlue: kSelectionBlue,
        selectionOrange: kSelectionOrange,
        selectionCharcoal: kSelectionCharcoal,
        selectionTeal: kSelectionTeal,
        selectionGreen: kSelectionGreen,
        selectionGreenLight: kSelectionGreenLight,
        selectionSky: kSelectionSky,
        selectionNeutral: kSelectionNeutral,
      ),
    ],
  );
}
