import 'package:flutter/material.dart';

// Project l10n
import 'package:sfrigola/core/l10n/app_localizations.dart';

// Project Models
import 'package:sfrigola/core/models/general_exception.dart';
import 'package:sfrigola/core/models/json_serializable.dart';

// Project BE Models
import 'package:sfrigola/core/models/be-models/be_sort.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_locale.dart';

enum Complexity { simple, challenging, hard }

enum Affordability { affordable, pricey, luxurious }

class MealPreview implements JsonSerializable {
  const MealPreview({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.rate,
  });

  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;

  /// Estimated total preparation + cooking time in minutes.
  final int duration;

  final Complexity complexity;
  final Affordability affordability;
  final double rate;

  factory MealPreview.fromJson(Map<String, dynamic> json) {
    return MealPreview(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      imageUrl: json['imageUrl'] as String,
      duration: json['duration'] as int,
      complexity: Complexity.values.firstWhere(
        (e) => e.name == json['complexity'],
        orElse: () => Complexity.simple,
      ),
      affordability: Affordability.values.firstWhere(
        (e) => e.name == json['affordability'],
        orElse: () => Affordability.affordable,
      ),
      rate: (json['rate'] as num).toDouble(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'imageUrl': imageUrl,
      'duration': duration,
      'complexity': complexity.name,
      'affordability': affordability.name,
      'rate': rate,
    };
  }
}

class Meal implements JsonSerializable {
  const Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.servings,
    required this.complexity,
    required this.affordability,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
    required this.rate,
    this.isFavourite = false,
    this.userRate,
  });

  final String id;
  final List<String> categories;
  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;

  /// Estimated total preparation + cooking time in minutes.
  final int duration;

  /// Number of servings the recipe is designed for.
  final int servings;

  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;
  final double rate;
  // User fields
  final bool isFavourite;
  final double? userRate;

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'] as String,
      categories: List<String>.from(json['categories'] as List),
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      ingredients: List<String>.from(json['ingredients'] as List),
      steps: List<String>.from(json['steps'] as List),
      duration: json['duration'] as int,
      servings: json['servings'] as int,
      complexity: Complexity.values.firstWhere(
        (e) => e.name == json['complexity'],
        orElse: () => Complexity.simple,
      ),
      affordability: Affordability.values.firstWhere(
        (e) => e.name == json['affordability'],
        orElse: () => Affordability.affordable,
      ),
      isGlutenFree: json['isGlutenFree'] as bool,
      isLactoseFree: json['isLactoseFree'] as bool,
      isVegan: json['isVegan'] as bool,
      isVegetarian: json['isVegetarian'] as bool,
      rate: (json['rate'] as num).toDouble(),
      isFavourite: json['isFavourite'] as bool? ?? false,
      userRate: (json['userRate'] as num?)?.toDouble(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categories': categories,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'imageUrl': imageUrl,
      'ingredients': ingredients,
      'steps': steps,
      'duration': duration,
      'servings': servings,
      'complexity': complexity.name,
      'affordability': affordability.name,
      'isGlutenFree': isGlutenFree,
      'isLactoseFree': isLactoseFree,
      'isVegan': isVegan,
      'isVegetarian': isVegetarian,
      'rate': rate,
      'isFavourite': isFavourite,
      'userRate': userRate,
    };
  }

  Meal copyWith({bool? isFavourite, double? userRate}) {
    return Meal(
      id: id,
      categories: categories,
      title: title,
      subtitle: subtitle,
      description: description,
      imageUrl: imageUrl,
      ingredients: ingredients,
      steps: steps,
      duration: duration,
      servings: servings,
      complexity: complexity,
      affordability: affordability,
      isGlutenFree: isGlutenFree,
      isLactoseFree: isLactoseFree,
      isVegan: isVegan,
      isVegetarian: isVegetarian,
      rate: rate,
      isFavourite: isFavourite ?? this.isFavourite,
      userRate: userRate ?? this.userRate,
    );
  }
}

// ---------------------------------------------------------------------------
// Display extensions
// ---------------------------------------------------------------------------

extension ComplexityDisplay on Complexity {
  String label(BuildContext context) => switch (this) {
    Complexity.simple => AppLocale.getLabels(context).complexitySimple,
    Complexity.challenging => AppLocale.getLabels(
      context,
    ).complexityChallenging,
    Complexity.hard => AppLocale.getLabels(context).complexityHard,
  };

  ({Color color, Color foreground}) get badgeColors => switch (this) {
    Complexity.simple => (
      color: const Color(0xFFD4EDDA),
      foreground: const Color(0xFF155724),
    ),
    Complexity.challenging => (
      color: const Color(0xFFFFF3CD),
      foreground: const Color(0xFF856404),
    ),
    Complexity.hard => (
      color: const Color(0xFFFFDAD6),
      foreground: const Color(0xFFB3261E),
    ),
  };
}

extension AffordabilityDisplay on Affordability {
  String label(BuildContext context) => switch (this) {
    Affordability.affordable => AppLocale.getLabels(
      context,
    ).affordabilityAffordable,
    Affordability.pricey => AppLocale.getLabels(context).affordabilityPricey,
    Affordability.luxurious => AppLocale.getLabels(
      context,
    ).affordabilityLuxurious,
  };

  ({Color color, Color foreground}) get badgeColors => switch (this) {
    Affordability.affordable => (
      color: const Color(0xFFD4EDDA),
      foreground: const Color(0xFF155724),
    ),
    Affordability.pricey => (
      color: const Color(0xFFFFF3CD),
      foreground: const Color(0xFF856404),
    ),
    Affordability.luxurious => (
      color: const Color(0xFFF3E5F5),
      foreground: const Color(0xFF6A1B9A),
    ),
  };
}

// ---------------------------------------------------------------------------
// Meal query keys — filter and sort fields for meal endpoints
// ---------------------------------------------------------------------------

/// Filterable fields for meal list endpoints.
enum MealFilterKey { category, complexity, affordability, rating }

/// Sortable fields for meal list endpoints.
enum MealSortKey { name, rating, complexity, affordability }

extension MealSortParamLabel on SortParam<MealSortKey> {
  String label(BuildContext context) {
    final l = AppLocale.getLabels(context);
    return switch ((key, direction)) {
      (MealSortKey.name, SortDirection.asc) => l.sortOrderAlphabeticalAscending,
      (MealSortKey.name, SortDirection.desc) =>
        l.sortOrderAlphabeticalDescending,
      (MealSortKey.rating, SortDirection.asc) => l.sortOrderRateAscending,
      (MealSortKey.rating, SortDirection.desc) => l.sortOrderRateDescending,
      (MealSortKey.complexity, SortDirection.asc) =>
        l.sortOrderComplexityAscending,
      (MealSortKey.complexity, SortDirection.desc) =>
        l.sortOrderComplexityDescending,
      (MealSortKey.affordability, SortDirection.asc) =>
        l.sortOrderAffordabilityAscending,
      (MealSortKey.affordability, SortDirection.desc) =>
        l.sortOrderAffordabilityDescending,
    };
  }
}

// ---------------------------------------------------------------------------
// Rate range — value object for min/max rate filter
// ---------------------------------------------------------------------------

class MealsRateRange {
  final double min;
  final double max;

  const MealsRateRange({required this.min, required this.max});
}

// ---------------------------------------------------------------------------
// Exeptions
// ---------------------------------------------------------------------------

class MealNotFoundException implements AppException {
  const MealNotFoundException(this.id);
  final String id;

  @override
  bool get isRetryable => false;

  @override
  String localizedMessage(AppLocalizations l) => l.mealNotFoundError;

  @override
  String toString() => 'MealNotFoundException: no meal found with id "$id"';
}

class MealRateExeption implements AppException {
  const MealRateExeption(this.id);
  final String id;

  @override
  bool get isRetryable => false;

  @override
  String localizedMessage(AppLocalizations l) => l.mealRateError;

  @override
  String toString() => 'MealRateExeption: failed to rate meal with id "$id"';
}

class MealFavoriteException implements AppException {
  const MealFavoriteException(this.id, this.isAdding);
  final String id;
  final bool isAdding;

  @override
  bool get isRetryable => true;

  @override
  String localizedMessage(AppLocalizations l) =>
      isAdding ? l.favouriteAddError : l.favouriteRemoveError;

  @override
  String toString() =>
      'MealFavoriteException: failed to ${isAdding ? 'add' : 'remove'} meal with id "$id" ${isAdding ? 'to' : 'from'} favourites';
}

enum MealMutationType { add, update, delete }

class MealMutationException implements AppException {
  const MealMutationException(this.opType);
  final MealMutationType opType;

  @override
  bool get isRetryable => true;

  @override
  String localizedMessage(AppLocalizations l) {
    switch (opType) {
      case MealMutationType.add:
        return l.mealAddError;
      case MealMutationType.update:
        return l.mealUpdateError;
      case MealMutationType.delete:
        return l.mealDeleteError;
    }
  }

  @override
  String toString() =>
      'MealMutationException: failed to perform ${opType.name} operation on meal';
}
