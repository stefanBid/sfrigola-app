import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Project l10n
import 'package:sfrigola/l10n/app_localizations.dart';

class AppLocale {
  const AppLocale._();

  static const supportedLocales = [
    Locale('it'), // Italian (default)
  ];

  static const localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static AppLocalizations getLabels(BuildContext context) {
    return AppLocalizations.of(context)!;
  }
}
