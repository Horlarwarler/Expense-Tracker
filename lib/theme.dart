import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseTrackerTheme {
  final kColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 96, 59, 181),
  );
  final kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 99, 125),
  );
  final titleLarge = GoogleFonts.lato(fontSize: 16);

  final cardTheme = const CardTheme().copyWith(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8));

  final lightTheme = ThemeData().copyWith(
    useMaterial3: true,
    colorScheme: ExpenseTrackerTheme().kColorScheme,
    textTheme: TextTheme().copyWith(
      titleLarge: ExpenseTrackerTheme().titleLarge,
    ),
    cardTheme: const CardTheme().copyWith(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    ),
  );
}
