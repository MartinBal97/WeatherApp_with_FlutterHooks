import 'package:flutter/material.dart';

const seedColor = Colors.blueAccent;

const Color black = Colors.black;
const Color white = Colors.white;
const Color redAlert = Color(0xFF950A00);

const FontWeight w7 = FontWeight.w700;
const FontWeight w6 = FontWeight.w600;
const FontWeight w5 = FontWeight.w500;
const FontWeight w4 = FontWeight.w400;

const TextTheme _textTheme = TextTheme(
  displayLarge: TextStyle(fontSize: 48, fontWeight: w7, letterSpacing: -0.5, height: 1.2),
  displayMedium: TextStyle(fontSize: 30, fontWeight: w7, letterSpacing: -0.3, height: 1.3),
  displaySmall: TextStyle(fontSize: 24, fontWeight: w7, letterSpacing: -0.2, height: 1.3),
  headlineLarge: TextStyle(fontSize: 20, fontWeight: w6, letterSpacing: -0.1, height: 1.4),
  headlineMedium: TextStyle(fontSize: 20, fontWeight: w4, letterSpacing: -0.1, height: 1.4),
  headlineSmall: TextStyle(fontSize: 18, fontWeight: w7, letterSpacing: -0.1, height: 1.4),
  titleLarge: TextStyle(fontSize: 18, fontWeight: w4, letterSpacing: 0.0, height: 1.4),
  titleMedium: TextStyle(fontSize: 16, fontWeight: w7, letterSpacing: 0.0, height: 1.5),
  titleSmall: TextStyle(fontSize: 16, fontWeight: w4, letterSpacing: 0.0, height: 1.5),
  bodyMedium: TextStyle(fontSize: 16, fontWeight: w6, letterSpacing: 0.0, height: 1.5),
  bodySmall: TextStyle(fontSize: 14, fontWeight: w6, letterSpacing: 0.0, height: 1.5),
  labelLarge: TextStyle(fontSize: 14, fontWeight: w4, letterSpacing: 0.0, height: 1.5),
  labelMedium: TextStyle(fontSize: 12, fontWeight: w6, letterSpacing: 0.0, height: 1.5),
  labelSmall: TextStyle(fontSize: 12, fontWeight: w4, letterSpacing: 0.0, height: 1.5),
);

class AppTheme {
  final bool isDarkmode;
  AppTheme({required this.isDarkmode});

  ThemeData getTheme() => ThemeData(
        brightness: isDarkmode ? Brightness.dark : Brightness.light,
        colorSchemeSeed: Colors.lightGreen.shade700,
        textTheme: _textTheme,
      );
}

extension UIThemeExtension on BuildContext {
  // * Text style
  TextStyle get s48w7 => Theme.of(this).textTheme.displayLarge!;
  TextStyle get s30w7 => Theme.of(this).textTheme.displayMedium!;
  TextStyle get s24w7 => Theme.of(this).textTheme.displaySmall!;
  TextStyle get s20w6 => Theme.of(this).textTheme.headlineLarge!;
  TextStyle get s20w4 => Theme.of(this).textTheme.headlineMedium!;
  TextStyle get s18w7 => Theme.of(this).textTheme.headlineSmall!;
  TextStyle get s18w4 => Theme.of(this).textTheme.titleLarge!;
  TextStyle get s16w7 => Theme.of(this).textTheme.titleMedium!;
  TextStyle get s16w4 => Theme.of(this).textTheme.titleSmall!;
  TextStyle get s16w6 => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get s14w6 => Theme.of(this).textTheme.bodySmall!;
  TextStyle get s14w4 => Theme.of(this).textTheme.labelLarge!;
  TextStyle get s12w7 => Theme.of(this).textTheme.labelMedium!;
  TextStyle get s12w4 => Theme.of(this).textTheme.labelSmall!;

  // * Colors

  Color get primary => Theme.of(this).colorScheme.primary;
  Color get onPrimary => Theme.of(this).colorScheme.onPrimary;
  Color get primaryContainer => Theme.of(this).colorScheme.primaryContainer;
  Color get onPrimaryContainer => Theme.of(this).colorScheme.onPrimaryContainer;
  Color get secondary => Theme.of(this).colorScheme.secondary;
  Color get onSecondary => Theme.of(this).colorScheme.onSecondary;
  Color get secondaryContainer => Theme.of(this).colorScheme.secondaryContainer;
  Color get onSecondaryContainer => Theme.of(this).colorScheme.onSecondaryContainer;
  Color get tertiary => Theme.of(this).colorScheme.tertiary;
  Color get onTertiary => Theme.of(this).colorScheme.onTertiary;
  Color get tertiaryContainer => Theme.of(this).colorScheme.tertiaryContainer;
  Color get onTertiaryContainer => Theme.of(this).colorScheme.onTertiaryContainer;
  Color get error => Theme.of(this).colorScheme.error;
  Color get onError => Theme.of(this).colorScheme.onError;
  Color get errorContainer => Theme.of(this).colorScheme.errorContainer;
  Color get onErrorContainer => Theme.of(this).colorScheme.onErrorContainer;
  Color get background => Theme.of(this).colorScheme.surface;
  Color get onBackground => Theme.of(this).colorScheme.onSurface;
  Color get surface => Theme.of(this).colorScheme.surface;
  Color get onSurface => Theme.of(this).colorScheme.onSurface;

  // * Size screen
  double get widthMq => MediaQuery.sizeOf(this).width;
  double get heightMq => MediaQuery.sizeOf(this).height;
}
