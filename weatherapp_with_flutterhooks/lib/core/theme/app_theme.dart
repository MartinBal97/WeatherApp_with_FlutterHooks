import 'package:flutter/material.dart';

const Color green700 = Color(0xFF183028);
const Color green600 = Color(0xFF3A4A49);
const Color green500 = Color(0xFF516665);
const Color green400 = Color(0xFFA1ACAC);
const Color green200 = Color(0xFFC2DCDB);
const Color green100 = Color(0xFFE6F0ED);
const Color green50 = Color(0xFFF7FAF9);

const Color purple500 = Color(0xFF7b147b);
const Color purple200 = Color(0xFFb981b8);
const Color purple100 = Color(0xFFF7FEE7);

const Color gray700 = Color(0xFF374151); //superdarkgrey
const Color gray500 = Color(0xFF6B7280); //darkgrey
const Color gray400 = Color(0xFF9CA3AF); //grey
const Color gray200 = Color(0xFFE5E7EB); //lightgrey
const Color gray100 = Color(0xFFF3F4F6); //superlightgrey
const Color gray50 = Color(0xFFF9FAFB); //ultrawhite

const seedColor = purple500;

const Color black = Colors.black;
const Color white = Colors.white;
const Color redAlert = Color(0xFF950A00);

const FontWeight w7 = FontWeight.w700;
const FontWeight w6 = FontWeight.w600;
const FontWeight w5 = FontWeight.w500;
const FontWeight w4 = FontWeight.w400;

const TextTheme _textTheme = TextTheme(
  displayLarge: TextStyle(fontSize: 48, fontWeight: w7),
  displayMedium: TextStyle(fontSize: 30, fontWeight: w7),
  displaySmall: TextStyle(fontSize: 24, fontWeight: w7),
  headlineLarge: TextStyle(fontSize: 20, fontWeight: w6),
  headlineMedium: TextStyle(fontSize: 20, fontWeight: w4),
  headlineSmall: TextStyle(fontSize: 18, fontWeight: w7),
  titleLarge: TextStyle(fontSize: 18, fontWeight: w4),
  titleMedium: TextStyle(fontSize: 16, fontWeight: w7),
  titleSmall: TextStyle(fontSize: 16, fontWeight: w4),
  //bodyLarge: TextStyle(fontSize: 16, fontWeight: w7),
  bodyMedium: TextStyle(fontSize: 16, fontWeight: w6),
  bodySmall: TextStyle(fontSize: 14, fontWeight: w6),
  labelLarge: TextStyle(fontSize: 14, fontWeight: w4),
  labelMedium: TextStyle(fontSize: 12, fontWeight: w6),
  labelSmall: TextStyle(fontSize: 12, fontWeight: w4),
);

class AppTheme {
  final bool isDarkmode;
  AppTheme({required this.isDarkmode});

  ThemeData getTheme() => ThemeData(
        brightness: isDarkmode ? Brightness.dark : Brightness.light,
        colorSchemeSeed: Colors.purple,
        fontFamily: 'Geist',
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
  //TextStyle get s16w7 => Theme.of(this).textTheme.bodyLarge!;
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
