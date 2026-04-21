// Project Data
import 'package:sfrigola/core/data/dummy_data.dart';

// Project Models
import 'package:sfrigola/core/models/category.dart';
import 'package:sfrigola/core/models/general_exception.dart';
import 'package:sfrigola/core/models/meal.dart';

// Project Repositories
import 'package:sfrigola/core/repositories/meal/meal_repository.dart';
import 'package:sfrigola/core/repositories/meal/meal_repository_model.dart';

class MealRepositoryImpl implements MealRepository {
  static void _checkSimulation(bool simulateError) {
    if (simulateError) throw GeneralException.generic();
  }

  List<MealPreview> _toPreviewList(
    List<Meal> meals,
    String? searchKey,
    String? categoryId,
    int skip,
    int take,
  ) {
    final filtered = categoryId == null
        ? meals
        : meals.where((m) => m.categories.contains(categoryId)).toList();
    final searched = searchKey == null || searchKey.isEmpty
        ? filtered
        : filtered
              .where(
                (m) => m.title.toLowerCase().contains(searchKey.toLowerCase()),
              )
              .toList();
    return searched
        .skip(skip)
        .take(take)
        .map((m) => MealPreview.fromJson(m.toJson()))
        .toList();
  }

  @override
  Future<List<Category>> getCategories() async {
    // TODO: replace with GET /categories
    await Future.delayed(const Duration(milliseconds: 500));
    _checkSimulation(false);
    return availableCategories;
  }

  @override
  Future<MealRepositoryResponse> getTrending(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /meals/trending
    await Future.delayed(const Duration(milliseconds: 500));
    _checkSimulation(false);
    final sorted = [...availableMeals]
      ..sort((a, b) => b.rate.compareTo(a.rate));
    final meals = _toPreviewList(sorted, null, categoryId, skip, take);
    return MealRepositoryResponse(meals: meals, total: sorted.length);
  }

  @override
  Future<MealRepositoryResponse> getEasy(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /meals?complexity=simple
    await Future.delayed(const Duration(milliseconds: 500));
    _checkSimulation(false);
    final filtered = availableMeals
        .where((m) => m.complexity == Complexity.simple)
        .toList();
    final meals = _toPreviewList(filtered, null, categoryId, skip, take);
    return MealRepositoryResponse(meals: meals, total: filtered.length);
  }

  @override
  Future<MealRepositoryResponse> getChallenge(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /meals?complexity=hard
    await Future.delayed(const Duration(milliseconds: 500));
    _checkSimulation(false);
    final filtered = availableMeals
        .where((m) => m.complexity == Complexity.hard)
        .toList();
    final meals = _toPreviewList(filtered, null, categoryId, skip, take);
    return MealRepositoryResponse(meals: meals, total: filtered.length);
  }

  @override
  Future<MealRepositoryResponse> getBudget(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /meals?affordability=affordable
    await Future.delayed(const Duration(milliseconds: 500));
    _checkSimulation(false);
    final filtered = availableMeals
        .where((m) => m.affordability == Affordability.affordable)
        .toList();
    final meals = _toPreviewList(filtered, null, categoryId, skip, take);
    return MealRepositoryResponse(meals: meals, total: filtered.length);
  }

  @override
  Future<MealRepositoryResponse> getPremium(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /meals?affordability=luxurious
    await Future.delayed(const Duration(milliseconds: 500));
    _checkSimulation(false);
    final filtered = availableMeals
        .where((m) => m.affordability == Affordability.luxurious)
        .toList();
    final meals = _toPreviewList(filtered, null, categoryId, skip, take);
    return MealRepositoryResponse(meals: meals, total: filtered.length);
  }

  @override
  Future<MealRepositoryResponse> getAllMeals(
    String? searchKey, {
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /meals
    await Future.delayed(const Duration(milliseconds: 500));
    _checkSimulation(false);
    final meals = _toPreviewList(availableMeals, searchKey, null, skip, take);
    return MealRepositoryResponse(meals: meals, total: availableMeals.length);
  }

  @override
  Future<Meal> getMealById(String id) async {
    // TODO: replace with GET /meals/{id}
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      return availableMeals.firstWhere((meal) => meal.id == id);
    } on StateError {
      throw MealNotFoundException(id);
    }
  }
}
