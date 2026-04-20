import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('it')];

  /// Title shown in the home screen app bar
  ///
  /// In it, this message translates to:
  /// **'Che cosa cuciniamo oggi?'**
  String get homeTitle;

  /// Placeholder text in the home search bar
  ///
  /// In it, this message translates to:
  /// **'Cerca una ricetta...'**
  String get homeSearchHint;

  /// Subtitle shown below the app bar on the home screen
  ///
  /// In it, this message translates to:
  /// **'Cosa cuciniamo oggi?'**
  String get homeSubtitle;

  /// Title of the trending recipes section (viral cards)
  ///
  /// In it, this message translates to:
  /// **'In tendenza'**
  String get homeSectionTrending;

  /// Subtitle of the trending recipes section
  ///
  /// In it, this message translates to:
  /// **'Le ricette che stanno spopolando adesso'**
  String get homeSectionTrendingSubtitle;

  /// Title of the easy meals section
  ///
  /// In it, this message translates to:
  /// **'Pronti in un attimo'**
  String get homeSectionEasy;

  /// Subtitle of the easy meals section
  ///
  /// In it, this message translates to:
  /// **'Ricette semplici per le sere di corsa'**
  String get homeSectionEasySubtitle;

  /// Title of the challenge meals section
  ///
  /// In it, this message translates to:
  /// **'Mettiti alla prova'**
  String get homeSectionChallenge;

  /// Subtitle of the challenge meals section
  ///
  /// In it, this message translates to:
  /// **'Per chi vuole crescere ai fornelli'**
  String get homeSectionChallengeSubtitle;

  /// Title of the budget meals section
  ///
  /// In it, this message translates to:
  /// **'Cucina low cost'**
  String get homeSectionBudget;

  /// Subtitle of the budget meals section
  ///
  /// In it, this message translates to:
  /// **'Buono, sano e senza svuotare il portafoglio'**
  String get homeSectionBudgetSubtitle;

  /// Title of the premium meals section
  ///
  /// In it, this message translates to:
  /// **'Esperienze gourmet'**
  String get homeSectionPremium;

  /// Subtitle of the premium meals section
  ///
  /// In it, this message translates to:
  /// **'Ricette da chef per le occasioni speciali'**
  String get homeSectionPremiumSubtitle;

  /// Error message shown in the categories row when categories fail to load
  ///
  /// In it, this message translates to:
  /// **'Impossibile caricare le categorie'**
  String get homeCategoriesLoadError;

  /// Section title for the description in the meal details screen
  ///
  /// In it, this message translates to:
  /// **'Descrizione'**
  String get mealDetailsSectionDescription;

  /// Error message shown in the meal details screen when the meal fails to load
  ///
  /// In it, this message translates to:
  /// **'Impossibile caricare i dettagli della ricetta.'**
  String get mealDetailsLoadError;

  /// Section title for the ingredients list in the meal details screen
  ///
  /// In it, this message translates to:
  /// **'Ingredienti'**
  String get mealDetailsSectionIngredients;

  /// Section title for the steps list in the meal details screen
  ///
  /// In it, this message translates to:
  /// **'Procedimento'**
  String get mealDetailsSectionSteps;

  /// Badge label shown when a meal is gluten-free
  ///
  /// In it, this message translates to:
  /// **'Senza glutine'**
  String get mealDetailsBadgeGlutenFree;

  /// Badge label shown when a meal is lactose-free
  ///
  /// In it, this message translates to:
  /// **'Senza lattosio'**
  String get mealDetailsBadgeLactoseFree;

  /// Badge label shown when a meal is vegan
  ///
  /// In it, this message translates to:
  /// **'Vegano'**
  String get mealDetailsBadgeVegan;

  /// Badge label shown when a meal is vegetarian
  ///
  /// In it, this message translates to:
  /// **'Vegetariano'**
  String get mealDetailsBadgeVegetarian;

  /// Label for Complexity.simple enum value
  ///
  /// In it, this message translates to:
  /// **'Facile'**
  String get complexitySimple;

  /// Label for Complexity.challenging enum value
  ///
  /// In it, this message translates to:
  /// **'Medio'**
  String get complexityChallenging;

  /// Label for Complexity.hard enum value
  ///
  /// In it, this message translates to:
  /// **'Difficile'**
  String get complexityHard;

  /// Label for Affordability.affordable enum value
  ///
  /// In it, this message translates to:
  /// **'Economico'**
  String get affordabilityAffordable;

  /// Label for Affordability.pricey enum value
  ///
  /// In it, this message translates to:
  /// **'Nella media'**
  String get affordabilityPricey;

  /// Label for Affordability.luxurious enum value
  ///
  /// In it, this message translates to:
  /// **'Gourmet'**
  String get affordabilityLuxurious;

  /// Error shown when a network/connectivity failure occurs
  ///
  /// In it, this message translates to:
  /// **'Nessuna connessione. Controlla la tua rete.'**
  String get errorNetwork;

  /// Error shown when a resource is not found (404)
  ///
  /// In it, this message translates to:
  /// **'Il contenuto non è stato trovato.'**
  String get errorNotFound;

  /// Error shown when the user is not authenticated (401)
  ///
  /// In it, this message translates to:
  /// **'Sessione scaduta. Accedi di nuovo.'**
  String get errorUnauthorized;

  /// Error shown when the user is not authorized (403)
  ///
  /// In it, this message translates to:
  /// **'Non hai i permessi per eseguire questa operazione.'**
  String get errorForbidden;

  /// Error shown for generic server errors (5xx)
  ///
  /// In it, this message translates to:
  /// **'Si è verificato un errore sul server. Riprova più tardi.'**
  String get errorServerError;

  /// Fallback error shown for unknown errors
  ///
  /// In it, this message translates to:
  /// **'Si è verificato un errore. Riprova.'**
  String get errorGeneric;

  /// Error shown when a specific meal is not found
  ///
  /// In it, this message translates to:
  /// **'Ricetta non trovata.'**
  String get mealNotFoundError;

  /// Generic retry button label
  ///
  /// In it, this message translates to:
  /// **'Riprova'**
  String get retry;

  /// Error message shown in the home screen when all meal sections fail to load
  ///
  /// In it, this message translates to:
  /// **'Impossibile caricare le ricette. Riprova.'**
  String get homeErrorLoadMeals;

  /// Warning snackbar shown when only some meal sections fail to load
  ///
  /// In it, this message translates to:
  /// **'Alcune sezioni non sono state caricate.'**
  String get homeErrorSomeSections;

  /// Empty state message shown when a category has no meals
  ///
  /// In it, this message translates to:
  /// **'Nessuna ricetta trovata per la categoria selezionata.'**
  String get homeEmptyCategory;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
