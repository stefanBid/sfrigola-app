// Project Data
import 'package:sfrigola/data/dummy_data.dart';

// Project Models
import 'package:sfrigola/models/category.dart';
import 'package:sfrigola/models/meal.dart';

// Project Repositories
import 'package:sfrigola/repositories/meal/meal_repository.dart';
import 'package:sfrigola/repositories/meal/meal_repository_model.dart';

class MealRepositoryImpl implements MealRepository {
  List<Meal> _applyCategory(
    List<Meal> meals,
    String? categoryId,
    int skip,
    int take,
  ) {
    if (categoryId == null) return meals;
    return meals
        .where((meal) => meal.categories.contains(categoryId))
        .skip(skip)
        .take(take)
        .toList();
  }

  @override
  Future<List<Category>> getCategories() async {
    // TODO: replace with GET /categories
    await Future.delayed(const Duration(seconds: 2));
    return availableCategories;
  }

  @override
  Future<List<Meal>> getTrending(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /meals/trending
    await Future.delayed(const Duration(seconds: 2));
    final sorted = [...availableMeals]
      ..sort((a, b) => b.rate.compareTo(a.rate));
    return _applyCategory(sorted, categoryId, skip, take);
  }

  @override
  Future<List<Meal>> getRecent(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /meals/recent
    await Future.delayed(const Duration(seconds: 2));
    final recent = availableMeals.reversed.toList();
    return _applyCategory(recent, categoryId, skip, take);
  }

  @override
  Future<List<Meal>> getPopular(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /meals/popular (dedicated endpoint on BE).
    // On the dummy dataset, popular = highest-rated affordable meals.
    await Future.delayed(const Duration(seconds: 2));
    final sorted = [...availableMeals]
      ..sort((a, b) {
        // Primary: affordability (affordable first), secondary: rate desc.
        final aScore = a.affordability == Affordability.affordable ? 1 : 0;
        final bScore = b.affordability == Affordability.affordable ? 1 : 0;
        if (bScore != aScore) return bScore.compareTo(aScore);
        return b.rate.compareTo(a.rate);
      });
    return _applyCategory(sorted, categoryId, skip, take);
  }

  @override
  Future<Meal> getMealById(String id) async {
    // TODO: replace with GET /meals/{id}
    await Future.delayed(const Duration(seconds: 2));
    try {
      return availableMeals.firstWhere((meal) => meal.id == id);
    } on StateError {
      throw MealNotFoundException(id);
    }
  }
}
