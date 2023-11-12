import 'package:expense_tracker/expenses_tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

final kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);
final kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);
final titleLarge = GoogleFonts.lato(fontSize: 16);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        textTheme: const TextTheme().copyWith(
          titleLarge: titleLarge,
          labelSmall: GoogleFonts.roboto(
              fontSize: 12, color: kColorScheme.onBackground, letterSpacing: 1),
          bodyMedium: GoogleFonts.lato(
            fontSize: 16,
            color: kColorScheme.onBackground,
            fontWeight: FontWeight.normal,
          ),
          bodySmall: GoogleFonts.lato(
            fontSize: 14,
            color: kColorScheme.onBackground,
            fontWeight: FontWeight.normal,
          ),
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ),
        appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer),
        ),
        dialogBackgroundColor: kColorScheme.secondaryContainer,
      ),
      home: ExpensesTracker(),
      darkTheme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        textTheme: TextTheme().copyWith(
          titleLarge: titleLarge,
          labelSmall: GoogleFonts.roboto(
              fontSize: 12,
              color: kDarkColorScheme.onBackground,
              letterSpacing: 1),
          bodyMedium: GoogleFonts.lato(
            fontSize: 16,
            color: kDarkColorScheme.onBackground,
            fontWeight: FontWeight.normal,
          ),
          bodySmall: GoogleFonts.lato(
            fontSize: 14,
            color: kDarkColorScheme.onBackground,
            fontWeight: FontWeight.normal,
          ),
        ),
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ),
        appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kDarkColorScheme.onPrimaryContainer,
            foregroundColor: kDarkColorScheme.primaryContainer),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.primaryContainer),
        ),
        canvasColor: kDarkColorScheme.secondaryContainer,
        dialogBackgroundColor: kDarkColorScheme.secondaryContainer,
      ),
      themeMode: ThemeMode.system,
    );
  }
}
