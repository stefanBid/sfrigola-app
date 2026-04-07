import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Helpers
import 'package:sfrigola/helpers/app_logger.dart';

// Project Models
import 'package:sfrigola/models/category.dart';
import 'package:sfrigola/models/meal.dart';

// Project Repositories
import 'package:sfrigola/repositories/meal/meal_repository_model.dart';

// Project Providers
import 'package:sfrigola/providers/repository_provider.dart';

part 'meal_provider.g.dart';

/// All available categories. Used for the filter row on the Home screen.
@riverpod
Future<List<Category>> categories(Ref ref) async {
  AppLogger.debug('categories → loading', tag: 'MealProvider');
  final repo = ref.watch(mealRepositoryProvider);
  final result = await repo.getCategories();
  AppLogger.debug(
    'categories → data (${result.length} items)',
    tag: 'MealProvider',
  );
  return result;
}

/// Trending meals — highest rated, currently popular.
@riverpod
Future<List<Meal>> trendingMeals(Ref ref) async {
  AppLogger.debug('trendingMeals → loading', tag: 'MealProvider');
  final repo = ref.watch(mealRepositoryProvider);
  final result = await repo.getTrending(const MealFilter());
  AppLogger.debug(
    'trendingMeals → data (${result.length} items)',
    tag: 'MealProvider',
  );
  return result;
}

/// Recently added meals.
@riverpod
Future<List<Meal>> recentMeals(Ref ref) async {
  AppLogger.debug('recentMeals → loading', tag: 'MealProvider');
  final repo = ref.watch(mealRepositoryProvider);
  final result = await repo.getRecent(const MealFilter());
  AppLogger.debug(
    'recentMeals → data (${result.length} items)',
    tag: 'MealProvider',
  );
  return result;
}

/// Most popular meals (community rating).
@riverpod
Future<List<Meal>> popularMeals(Ref ref) async {
  AppLogger.debug('popularMeals → loading', tag: 'MealProvider');
  final repo = ref.watch(mealRepositoryProvider);
  final result = await repo.getPopular(const MealFilter());
  AppLogger.debug(
    'popularMeals → data (${result.length} items)',
    tag: 'MealProvider',
  );
  return result;
}
