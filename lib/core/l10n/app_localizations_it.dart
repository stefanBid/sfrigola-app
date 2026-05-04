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

  @override
  String get mealDetailsSectionDescription => 'Descrizione';

  @override
  String get mealDetailsLoadError =>
      'Impossibile caricare i dettagli della ricetta.';

  @override
  String get mealDetailsSectionIngredients => 'Ingredienti';

  @override
  String get mealDetailsSectionSteps => 'Procedimento';

  @override
  String get mealDetailsBadgeGlutenFree => 'Senza glutine';

  @override
  String get mealDetailsBadgeLactoseFree => 'Senza lattosio';

  @override
  String get mealDetailsBadgeVegan => 'Vegano';

  @override
  String get mealDetailsBadgeVegetarian => 'Vegetariano';

  @override
  String get complexitySimple => 'Facile';

  @override
  String get complexityChallenging => 'Medio';

  @override
  String get complexityHard => 'Difficile';

  @override
  String get affordabilityAffordable => 'Economico';

  @override
  String get affordabilityPricey => 'Nella media';

  @override
  String get affordabilityLuxurious => 'Gourmet';

  @override
  String get errorNetwork => 'Nessuna connessione. Controlla la tua rete.';

  @override
  String get errorNotFound => 'Il contenuto non è stato trovato.';

  @override
  String get errorUnauthorized => 'Sessione scaduta. Accedi di nuovo.';

  @override
  String get errorForbidden =>
      'Non hai i permessi per eseguire questa operazione.';

  @override
  String get errorServerError =>
      'Si è verificato un errore sul server. Riprova più tardi.';

  @override
  String get errorGeneric => 'Si è verificato un errore. Riprova.';

  @override
  String get mealNotFoundError => 'Ricetta non trovata.';

  @override
  String get mealRateError => 'Impossibile salvare la valutazione.';

  @override
  String get retry => 'Riprova';

  @override
  String get homeErrorLoadMeals => 'Impossibile caricare le ricette. Riprova.';

  @override
  String get homeErrorSomeSections => 'Alcune sezioni non sono state caricate.';

  @override
  String get homeEmptyCategory =>
      'Nessuna ricetta trovata per la categoria selezionata.';

  @override
  String get searchErrorLoadMeals =>
      'Impossibile caricare le ricette. Riprova.';

  @override
  String get searchEmptyResults =>
      'Nessun risultato per la ricerca effettuata.';

  @override
  String get searchEmptyHint => 'Cerca una ricetta per vedere i risultati.';

  @override
  String get favouritesTitle => 'I miei preferiti';

  @override
  String get favouritesErrorLoad => 'Impossibile caricare i preferiti.';

  @override
  String get favouritesEmptyFiltered =>
      'Nessun preferito corrisponde ai filtri selezionati.';

  @override
  String get favouritesEmpty => 'Ancora nessun preferito.';

  @override
  String get favouritesFilterComplexityLabel => 'Complessità';

  @override
  String get favouritesFilterComplexityAll => 'Tutte';

  @override
  String get favouritesFilterAffordabilityLabel => 'Prezzo';

  @override
  String get favouritesFilterAffordabilityAll => 'Tutti';

  @override
  String get favouritesFilterSortOrderLabel => 'Ordina per';

  @override
  String get favouritesFilterSortOrderNone => 'Nessun ordine';

  @override
  String get favouritesFilterRateLabel => 'Valutazione';

  @override
  String get favouritesFilterApply => 'Applica filtri';

  @override
  String get favouritesFilterReset => 'Reimposta';

  @override
  String get favouriteAdded => 'Aggiunto ai preferiti.';

  @override
  String get favouriteRemoved => 'Rimosso dai preferiti.';

  @override
  String get favouriteAddError => 'Impossibile aggiungere ai preferiti.';

  @override
  String get favouriteRemoveError => 'Impossibile rimuovere dai preferiti.';

  @override
  String get sortOrderAlphabeticalAscending => 'A → Z';

  @override
  String get sortOrderAlphabeticalDescending => 'Z → A';

  @override
  String get sortOrderRateAscending => 'Valutazione crescente';

  @override
  String get sortOrderRateDescending => 'Valutazione decrescente';

  @override
  String get sortOrderComplexityAscending => 'Complessità crescente';

  @override
  String get sortOrderComplexityDescending => 'Complessità decrescente';

  @override
  String get sortOrderAffordabilityAscending => 'Prezzo crescente';

  @override
  String get sortOrderAffordabilityDescending => 'Prezzo decrescente';
}
