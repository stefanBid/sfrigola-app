// Project Data
import 'package:sfrigola/data/dummy_data.dart';

// Project Models
import 'package:sfrigola/models/category.dart';
import 'package:sfrigola/models/meal.dart';

// Project Repositories
import 'package:sfrigola/repositories/meal/meal_repository.dart';
import 'package:sfrigola/repositories/meal/meal_repository_model.dart';

class MealRepositoryImpl implements MealRepository {
  List<MealPreview> _toPreviewList(
    List<Meal> meals,
    String? categoryId,
    int skip,
    int take,
  ) {
    final filtered = categoryId == null
        ? meals
        : meals.where((m) => m.categories.contains(categoryId)).toList();
    return filtered
        .skip(skip)
        .take(take)
        .map((m) => MealPreview.fromJson(m.toJson()))
        .toList();
  }

  @override
  Future<List<Category>> getCategories() async {
    // TODO: replace with GET /categories
    await Future.delayed(const Duration(seconds: 2));
    return availableCategories;
  }

  @override
  Future<List<MealPreview>> getTrending(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /meals/trending
    await Future.delayed(const Duration(seconds: 2));
    final sorted = [...availableMeals]
      ..sort((a, b) => b.rate.compareTo(a.rate));
    return _toPreviewList(sorted, categoryId, skip, take);
  }

  @override
  Future<List<MealPreview>> getEasy(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /meals?complexity=simple
    await Future.delayed(const Duration(seconds: 2));
    final filtered = availableMeals
        .where((m) => m.complexity == Complexity.simple)
        .toList();
    return _toPreviewList(filtered, categoryId, skip, take);
  }

  @override
  Future<List<MealPreview>> getChallenge(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /meals?complexity=hard
    await Future.delayed(const Duration(seconds: 2));
    final filtered = availableMeals
        .where((m) => m.complexity == Complexity.hard)
        .toList();
    return _toPreviewList(filtered, categoryId, skip, take);
  }

  @override
  Future<List<MealPreview>> getBudget(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /meals?affordability=affordable
    await Future.delayed(const Duration(seconds: 2));
    final filtered = availableMeals
        .where((m) => m.affordability == Affordability.affordable)
        .toList();
    return _toPreviewList(filtered, categoryId, skip, take);
  }

  @override
  Future<List<MealPreview>> getPremium(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /meals?affordability=luxurious
    await Future.delayed(const Duration(seconds: 2));
    final filtered = availableMeals
        .where((m) => m.affordability == Affordability.luxurious)
        .toList();
    return _toPreviewList(filtered, categoryId, skip, take);
  }

  @override
  Future<Meal> getMealById(String id) async {
    // TODO: replace with GET /meals/{id}
    await Future.delayed(const Duration(seconds: 2));
    throw MealNotFoundException(id);
    // try {
    //   return availableMeals.firstWhere((meal) => meal.id == id);
    // } on StateError {
    //   throw MealNotFoundException(id);
    // }
  }
}
