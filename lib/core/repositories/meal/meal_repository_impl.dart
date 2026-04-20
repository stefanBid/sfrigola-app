// Project Data
import 'package:sfrigola/core/data/dummy_data.dart';

// Project Helpers
import 'package:sfrigola/core/helpers/app_logger.dart';

// Project Models
import 'package:sfrigola/core/models/category.dart';
import 'package:sfrigola/core/models/general_exception.dart';
import 'package:sfrigola/core/models/meal.dart';

// Project Repositories
import 'package:sfrigola/core/repositories/meal/meal_repository.dart';
import 'package:sfrigola/core/repositories/meal/meal_repository_model.dart';

class MealRepositoryImpl implements MealRepository {
  static void _checkSimulation(bool simulateError) {
    if (simulateError) throw GeneralException.network();
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
  Future<List<MealPreview>> getTrending(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /meals/trending
    AppLogger.debug(
      'getTrending(categoryId: $categoryId, skip: $skip, take: $take)',
      tag: 'MealRepo',
    );
    await Future.delayed(const Duration(milliseconds: 500));
    _checkSimulation(false);
    final sorted = [...availableMeals]
      ..sort((a, b) => b.rate.compareTo(a.rate));
    final result = _toPreviewList(sorted, null, categoryId, skip, take);
    AppLogger.debug('getTrending → ${result.length} items', tag: 'MealRepo');
    return result;
  }

  @override
  Future<List<MealPreview>> getEasy(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /meals?complexity=simple
    AppLogger.debug(
      'getEasy(categoryId: $categoryId, skip: $skip, take: $take)',
      tag: 'MealRepo',
    );
    await Future.delayed(const Duration(milliseconds: 500));
    _checkSimulation(false);
    final filtered = availableMeals
        .where((m) => m.complexity == Complexity.simple)
        .toList();
    final result = _toPreviewList(filtered, null, categoryId, skip, take);
    AppLogger.debug('getEasy → ${result.length} items', tag: 'MealRepo');
    return result;
  }

  @override
  Future<List<MealPreview>> getChallenge(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /meals?complexity=hard
    AppLogger.debug(
      'getChallenge(categoryId: $categoryId, skip: $skip, take: $take)',
      tag: 'MealRepo',
    );
    await Future.delayed(const Duration(milliseconds: 500));
    _checkSimulation(false);
    final filtered = availableMeals
        .where((m) => m.complexity == Complexity.hard)
        .toList();
    final result = _toPreviewList(filtered, null, categoryId, skip, take);
    AppLogger.debug('getChallenge → ${result.length} items', tag: 'MealRepo');
    return result;
  }

  @override
  Future<List<MealPreview>> getBudget(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /meals?affordability=affordable
    AppLogger.debug(
      'getBudget(categoryId: $categoryId, skip: $skip, take: $take)',
      tag: 'MealRepo',
    );
    await Future.delayed(const Duration(milliseconds: 500));
    _checkSimulation(false);
    final filtered = availableMeals
        .where((m) => m.affordability == Affordability.affordable)
        .toList();
    final result = _toPreviewList(filtered, null, categoryId, skip, take);
    AppLogger.debug('getBudget → ${result.length} items', tag: 'MealRepo');
    return result;
  }

  @override
  Future<List<MealPreview>> getPremium(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /meals?affordability=luxurious
    AppLogger.debug(
      'getPremium(categoryId: $categoryId, skip: $skip, take: $take)',
      tag: 'MealRepo',
    );
    await Future.delayed(const Duration(milliseconds: 500));
    _checkSimulation(false);
    final filtered = availableMeals
        .where((m) => m.affordability == Affordability.luxurious)
        .toList();
    final result = _toPreviewList(filtered, null, categoryId, skip, take);
    AppLogger.debug('getPremium → ${result.length} items', tag: 'MealRepo');
    return result;
  }

  @override
  Future<List<MealPreview>> getAllMeals(
    String? searchKey, {
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /meals
    AppLogger.debug(
      'getAll(searchKey: $searchKey, skip: $skip, take: $take)',
      tag: 'MealRepo',
    );
    await Future.delayed(const Duration(milliseconds: 500));
    _checkSimulation(true);
    final result = _toPreviewList(availableMeals, searchKey, null, skip, take);
    AppLogger.debug('getAll → ${result.length} items', tag: 'MealRepo');
    return result;
  }

  @override
  Future<Meal> getMealById(String id) async {
    // TODO: replace with GET /meals/{id}
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      _checkSimulation(false);
      return availableMeals.firstWhere((meal) => meal.id == id);
    } on StateError {
      throw MealNotFoundException(id);
    }
  }
}
