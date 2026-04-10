import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Models
import 'package:sfrigola/models/category.dart';
import 'package:sfrigola/models/meal.dart';

// Project Providers
import 'package:sfrigola/providers/repository_provider.dart';
import 'package:sfrigola/providers/meal_filter_provider.dart';

part 'meal_provider.g.dart';

/// All available categories. Used for the filter row on the Home screen.
@riverpod
Future<List<Category>> categories(Ref ref) async {
  final repo = ref.watch(mealRepositoryProvider);
  return repo.getCategories();
}

/// Trending meals — highest rated, currently popular.
@riverpod
Future<List<Meal>> trendingMeals(Ref ref) async {
  final repo = ref.watch(mealRepositoryProvider);
  final filter = ref.watch(mealFilterProvider);
  return repo.getTrending(filter);
}

/// Recently added meals.
@riverpod
Future<List<Meal>> recentMeals(Ref ref) async {
  final repo = ref.watch(mealRepositoryProvider);
  final filter = ref.watch(mealFilterProvider);
  return repo.getRecent(filter);
}

/// Most popular meals (community rating).
@riverpod
Future<List<Meal>> popularMeals(Ref ref) async {
  final repo = ref.watch(mealRepositoryProvider);
  final filter = ref.watch(mealFilterProvider);
  return repo.getPopular(filter);
}
