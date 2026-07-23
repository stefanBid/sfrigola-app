import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Project l10n
import 'package:sfrigola/core/l10n/app_localizations.dart';

// Project Models
import 'package:sfrigola/core/models/general_exception.dart';

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

  static String errorFor(BuildContext context, Object error) {
    final l = getLabels(context);
    return error is AppException ? error.localizedMessage(l) : l.errorGeneric;
  }
}
