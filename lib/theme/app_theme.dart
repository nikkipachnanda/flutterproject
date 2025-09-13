import 'package:flutter/material.dart';

// ---------------------------------------------------------
// app_theme.dart
// Centralized ThemeData for the application.
// Place this file at: lib/theme/app_theme.dart
// ---------------------------------------------------------

// Brand colors
const Color kPrimary = Color(0xFFE34C23);
const Color kAccent = Color(0xFFFC8A5A);
const Color kBorder = Color(0xFFE5E7EB);
const double kRadius = 12.0;

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color? primary;
  final Color? accent;
  final Color? border;

  const AppColors({this.primary, this.accent, this.border});

/*************  ✨ Windsurf Command ⭐  *************/
  /// Create a new [AppColors] that is a copy of this one, but with the given
  /// fields replaced. If a field is not provided, the corresponding field from
  /// this object is used.
/*******  274214d0-266f-4415-95a5-5d20e53f3869  *******/  @override
  AppColors copyWith({Color? primary, Color? accent, Color? border}) {
    return AppColors(
      primary: primary ?? this.primary,
      accent: accent ?? this.accent,
      border: border ?? this.border,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t),
      accent: Color.lerp(accent, other.accent, t),
      border: Color.lerp(border, other.border, t),
    );
  }
}

// Optional: centralized typography
class AppTypography {
  static const TextStyle headline =
      TextStyle(fontSize: 22, fontWeight: FontWeight.w700);
  static const TextStyle subtitle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  static const TextStyle body = TextStyle(fontSize: 14);
  static const TextStyle caption =
      TextStyle(fontSize: 12, color: Colors.grey);
}

ThemeData buildAppTheme({bool dark = false}) {
  final seed = kPrimary;

  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: seed,
      brightness: dark ? Brightness.dark : Brightness.light,
    ),
    scaffoldBackgroundColor:
        dark ? const Color(0xFF0F1720) : Colors.white,
  );

  final textTheme = const TextTheme(
    headlineLarge: AppTypography.headline,
    titleMedium: AppTypography.subtitle,
    bodyMedium: AppTypography.body,
    bodySmall: AppTypography.caption,
  );

  return base.copyWith(
    textTheme: textTheme,

    // App bar
    appBarTheme: AppBarTheme(
      backgroundColor: dark ? Colors.black : Colors.white,
      foregroundColor: dark ? Colors.white : Colors.black,
      elevation: 0,
      titleTextStyle: textTheme.headlineLarge,
      iconTheme: IconThemeData(color: dark ? Colors.white : Colors.black),
    ),

    // Elevated button (fixed)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(kPrimary),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadius),
          ),
        ),
        textStyle: MaterialStateProperty.all(
          const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        elevation: MaterialStateProperty.all(0),
      ),
    ),

    // Input decoration
    inputDecorationTheme: InputDecorationTheme(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kRadius),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kRadius),
        borderSide: BorderSide(color: kBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kRadius),
        borderSide: BorderSide(color: kPrimary, width: 1.6),
      ),
      hintStyle: const TextStyle(color: Colors.grey),
    ),

    // Checkbox
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(kPrimary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    ),

    // Dividers & elevations
    dividerColor: kBorder,

    // Extensions
    extensions: <ThemeExtension<dynamic>>[
      const AppColors(
        primary: kPrimary,
        accent: kAccent,
        border: kBorder,
      ),
    ],
  );
}
