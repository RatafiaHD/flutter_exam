import 'package:flutter/material.dart';
import 'package:green_track/l10n/app_localizations.dart';
import 'package:green_track/pages/results_page/results_page.dart';
import 'package:green_track/pages/wizard_page/wizard_page.dart';
import 'package:green_track/res/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green track',
      theme: ThemeData(
        fontFamily: 'PlusJakartaSans',
        colorScheme: .fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          tertiary: AppColors.tertiary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.primary,
          centerTitle: false,
        ),
        sliderTheme: SliderThemeData(year2023: false),
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const ResultsPage(),
    );
  }
}
