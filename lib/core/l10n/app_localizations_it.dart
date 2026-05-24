// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get globalConfirm => 'Conferma';

  @override
  String get globalCancel => 'Annulla';

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
  String get mealAddError => 'Impossibile aggiungere la ricetta. Riprova.';

  @override
  String get mealUpdateError => 'Impossibile aggiornare la ricetta. Riprova.';

  @override
  String get mealDeleteError => 'Impossibile eliminare la ricetta. Riprova.';

  @override
  String get rateMealSuccess => 'Valutazione salvata.';

  @override
  String get rateMealLabel => 'La tua valutazione';

  @override
  String get rateMealDescription =>
      'Tocca una stella o scorri per assegnare un voto.';

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

  @override
  String get tooltipBack => 'Indietro';

  @override
  String get tooltipFilterMeals => 'Filtra ricette';

  @override
  String get tooltipAddMeal => 'Aggiungi ricetta';

  @override
  String get tooltipAddToFavourites => 'Aggiungi ai preferiti';

  @override
  String get tooltipRemoveFromFavourites => 'Rimuovi dai preferiti';

  @override
  String get cookbookSearchHint => 'Cerca per nome o descrizione...';

  @override
  String get cookbookTitle => 'Ricettario';

  @override
  String get manageMealFormSectionGeneralInfo => 'Informazioni generali';

  @override
  String get manageMealFormSectionRecipeDetails => 'Dettagli ricetta';

  @override
  String get manageMealFormSectionDietaryInfo => 'Info dietetiche';

  @override
  String get manageMealFormSectionDietaryInfoSubtitle =>
      'Seleziona tutte le proprietà dietetiche applicabili a questa ricetta.';

  @override
  String get manageMealFormFieldTitleLabel => 'Titolo ricetta';

  @override
  String get manageMealFormFieldTitleHint => 'Es. Pasta alla carbonara';

  @override
  String get manageMealFormFieldSubtitleLabel => 'Sottotitolo ricetta';

  @override
  String get manageMealFormFieldSubtitleHint =>
      'Es. Il classico romano rivisitato';

  @override
  String get manageMealFormFieldDescriptionLabel => 'Descrizione ricetta';

  @override
  String get manageMealFormFieldDescriptionHint =>
      'Descrivi la ricetta, il suo sapore e le occasioni in cui prepararla...';

  @override
  String get manageMealFormFieldCategoryLabel => 'Categoria';

  @override
  String get manageMealFormFieldCategoryHint => 'Seleziona una categoria';

  @override
  String get manageMealFormFieldComplexityHint => 'Seleziona la complessità';

  @override
  String get manageMealFormFieldAffordabilityHint => 'Seleziona il prezzo';

  @override
  String get manageMealFormFieldDurationLabel =>
      'Tempo totale (preparazione + cottura)';

  @override
  String get manageMealFormSave => 'Salva';

  @override
  String get manageMealFormCancel => 'Annulla';

  @override
  String get manageMealFormAddSuccessMessage =>
      'Ricetta aggiunta con successo!';

  @override
  String get manageMealFormEditSuccessMessage =>
      'Ricetta aggiornata con successo!';

  @override
  String get manageMealFormDeleteSuccessMessage =>
      'Ricetta eliminata con successo!';

  @override
  String get manageMealFormDelete => 'Elimina';

  @override
  String get manageMealFormTitleAdd => 'Nuova ricetta';

  @override
  String get manageMealFormTitleEdit => 'Modifica ricetta';

  @override
  String get manageMealFormTooltipBack => 'Indietro';

  @override
  String get manageMealFormTooltipDelete => 'Elimina ricetta';

  @override
  String get manageMealFormFieldTitleRequired => 'Il titolo è obbligatorio';

  @override
  String get manageMealFormFieldSubtitleRequired =>
      'Il sottotitolo è obbligatorio';

  @override
  String get manageMealFormFieldDescriptionRequired =>
      'La descrizione è obbligatoria';

  @override
  String get manageMealFormFieldCategoryRequired =>
      'Seleziona almeno una categoria';

  @override
  String get manageMealFormFieldComplexityRequired =>
      'Seleziona la complessità';

  @override
  String get manageMealFormFieldAffordabilityRequired => 'Seleziona il costo';

  @override
  String get manageMealFormFieldServingsLabel => 'Porzioni';

  @override
  String get manageMealFormSectionIngredients => 'Ingredienti';

  @override
  String get manageMealFormFieldIngredientsHint => 'Es. 200g farina 00';

  @override
  String get manageMealFormFieldIngredientsEmpty =>
      'Aggiungi almeno un ingrediente';

  @override
  String get manageMealFormSectionSteps => 'Preparazione';

  @override
  String get manageMealFormFieldStepsHint =>
      'Es. Porta a bollore l\'acqua salata...';

  @override
  String get manageMealFormFieldStepsEmpty =>
      'Aggiungi almeno uno step di preparazione';

  @override
  String get imagePickerSheetTitle => 'Immagine ricetta';

  @override
  String get imagePickerLabelAdd => 'Tocca per aggiungere un\'immagine';

  @override
  String get imagePickerGallery => 'Scegli dalla galleria';

  @override
  String get imagePickerCamera => 'Scatta una foto';

  @override
  String get imagePickerRemove => 'Rimuovi immagine';

  @override
  String get loginEmailLabel => 'Email';

  @override
  String get loginEmailHint => 'Inserisci la tua email';

  @override
  String get loginEmailRequired => 'L\'email è obbligatoria';

  @override
  String get loginEmailInvalid => 'Email non valida';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginPasswordHint => 'Inserisci la tua password';

  @override
  String get loginPasswordRequired => 'La password è obbligatoria';

  @override
  String get loginButton => 'Accedi';

  @override
  String get loginRegisterPrompt => 'Non sei ancora registrato?';

  @override
  String get loginRegisterAction => 'Registrati';

  @override
  String get authErrorInvalidCredentials => 'Email o password non corretti';

  @override
  String get authErrorUserNotFound =>
      'Nessun account trovato con questa email';

  @override
  String get authErrorEmailAlreadyInUse =>
      'Questa email è già associata a un account';

  @override
  String get authErrorWeakPassword =>
      'La password deve contenere almeno 8 caratteri, una maiuscola e un numero';

  @override
  String get authErrorWrongCurrentPassword =>
      'La password attuale non è corretta';
}
