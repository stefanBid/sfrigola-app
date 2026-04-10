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
  String get homeSectionRecent => 'Aggiunte di recente';

  @override
  String get homeSectionRecentSubtitle =>
      'Le ultime ricette aggiunte alla raccolta';

  @override
  String get homeSectionFavorites => 'I tuoi preferiti';

  @override
  String get homeSectionFavoritesSubtitle => 'Le ricette che hai salvato';

  @override
  String get homeSectionPopular => 'Ricette popolari';

  @override
  String get homeSectionPopularSubtitle =>
      'Le ricette più apprezzate dalla community';

  @override
  String get homeCategoriesLoadError => 'Impossibile caricare le categorie';
}
