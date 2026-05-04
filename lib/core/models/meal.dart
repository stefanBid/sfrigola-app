import 'package:flutter/material.dart';

// Project l10n
import 'package:sfrigola/core/l10n/app_localizations.dart';

// Project Models
import 'package:sfrigola/core/models/general_exception.dart';
import 'package:sfrigola/core/models/json_serializable.dart';

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
  final bool isFavourite;

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
    };
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
