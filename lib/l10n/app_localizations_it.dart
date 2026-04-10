// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get homeTitle => 'Che cosa cuciniamo oggi?';

  @override
  String get homeSearchHint => 'Cerca una ricetta...';

  @override
  String get homeSubtitle => 'Cosa cuciniamo oggi?';

  @override
  String get homeSectionTrending => 'In tendenza';

  @override
  String get homeSectionTrendingSubtitle =>
      'Le ricette che stanno spopolando adesso';

  @override
  String get homeSectionEasy => 'Pronti in un attimo';

  @override
  String get homeSectionEasySubtitle => 'Ricette semplici per le sere di corsa';

  @override
  String get homeSectionChallenge => 'Mettiti alla prova';

  @override
  String get homeSectionChallengeSubtitle =>
      'Per chi vuole crescere ai fornelli';

  @override
  String get homeSectionBudget => 'Cucina low cost';

  @override
  String get homeSectionBudgetSubtitle =>
      'Buono, sano e senza svuotare il portafoglio';

  @override
  String get homeSectionPremium => 'Esperienze gourmet';

  @override
  String get homeSectionPremiumSubtitle =>
      'Ricette da chef per le occasioni speciali';

  @override
  String get homeCategoriesLoadError => 'Impossibile caricare le categorie';
}
