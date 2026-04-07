// Project Data
import 'package:sfrigola/data/dummy_data.dart';

// Project Models
import 'package:sfrigola/models/category.dart';
import 'package:sfrigola/models/meal.dart';

// Project Repositories
import 'package:sfrigola/repositories/meal/meal_repository.dart';
import 'package:sfrigola/repositories/meal/meal_repository_model.dart';

class MealRepositoryImpl implements MealRepository {
  List<Meal> _applyFilter(List<Meal> meals, MealFilter filter) {
    return meals
        .where((meal) {
          final matchesCategory =
              filter.categoryId == null ||
              meal.categories.contains(filter.categoryId);
          final matchesQuery =
              filter.query.isEmpty ||
              meal.title.toLowerCase().contains(filter.query.toLowerCase()) ||
              meal.subtitle.toLowerCase().contains(filter.query.toLowerCase());
          return matchesCategory && matchesQuery;
        })
        .skip(filter.skip)
        .take(filter.take)
        .toList();
  }

  @override
  Future<List<Category>> getCategories() async {
    // TODO: replace with GET /categories
    return availableCategories;
  }

  @override
  Future<List<Meal>> getTrending(MealFilter filter) async {
    // TODO: replace with GET /meals/trending
    final sorted = [...availableMeals]
      ..sort((a, b) => b.rate.compareTo(a.rate));
    return _applyFilter(sorted, filter);
  }

  @override
  Future<List<Meal>> getRecent(MealFilter filter) async {
    // TODO: replace with GET /meals/recent
    final recent = availableMeals.reversed.toList();
    return _applyFilter(recent, filter);
  }

  @override
  Future<List<Meal>> getPopular(MealFilter filter) async {
    // TODO: replace with GET /meals/popular (dedicated endpoint on BE).
    // On the dummy dataset, popular = highest-rated affordable meals.
    final sorted = [...availableMeals]
      ..sort((a, b) {
        // Primary: affordability (affordable first), secondary: rate desc.
        final aScore = a.affordability == Affordability.affordable ? 1 : 0;
        final bScore = b.affordability == Affordability.affordable ? 1 : 0;
        if (bScore != aScore) return bScore.compareTo(aScore);
        return b.rate.compareTo(a.rate);
      });
    return _applyFilter(sorted, filter);
  }

  @override
  Future<Meal> getMealById(String id) async {
    // TODO: replace with GET /meals/{id}
    try {
      return availableMeals.firstWhere((meal) => meal.id == id);
    } on StateError {
      throw MealNotFoundException(id);
    }
  }
}
