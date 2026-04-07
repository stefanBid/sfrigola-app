// Project Models
import 'package:sfrigola/models/json_serializable.dart';

enum Complexity { simple, challenging, hard }

enum Affordability { affordable, pricey, luxurious }

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
    };
  }
}
