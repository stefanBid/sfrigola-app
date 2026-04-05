import 'package:flutter/material.dart';
import 'router.dart';

// Project Helpers
import 'package:sfrigola/helpers/app_locale.dart';
import 'package:sfrigola/helpers/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Sfrigola',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
      localizationsDelegates: AppLocale.localizationsDelegates,
      supportedLocales: AppLocale.supportedLocales,
    );
  }
}
