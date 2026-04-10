import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Models
import 'package:sfrigola/models/meal.dart';

// Project Providers
import 'package:sfrigola/providers/repository_provider.dart';

part 'meals_provider.g.dart';

/// Trending meals — highest rated, currently popular.
@riverpod
Future<List<Meal>> trendingMeals(Ref ref) async {
  final repo = ref.watch(mealRepositoryProvider);
  return repo.getTrending(null);
}

/// Recently added meals.
@riverpod
Future<List<Meal>> recentMeals(Ref ref) async {
  final repo = ref.watch(mealRepositoryProvider);
  return repo.getRecent(null);
}

/// Most popular meals (community rating).
@riverpod
Future<List<Meal>> popularMeals(Ref ref) async {
  final repo = ref.watch(mealRepositoryProvider);
  return repo.getPopular(null);
}
