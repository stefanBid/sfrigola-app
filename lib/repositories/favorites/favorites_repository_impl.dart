// Project Data
import 'package:sfrigola/data/dummy_data.dart';

// Project Models
import 'package:sfrigola/models/meal.dart';

// Project Repositories
import 'package:sfrigola/repositories/favorites/favorites_repository.dart';
import 'package:sfrigola/repositories/meal/meal_repository_model.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  /// In-memory favorite IDs — replace with server-side user data.
  final List<String> _favoriteIds = ['m1', 'm5', 'm12', 'm20', 'm28'];

  List<Meal> _applyFilter(List<Meal> meals, MealRepositoryFilter filter) {
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
  Future<List<Meal>> getFavorites(MealRepositoryFilter filter) async {
    // TODO: replace with GET /favorites (auth via Dio interceptor)
    final favorites = availableMeals
        .where((meal) => _favoriteIds.contains(meal.id))
        .toList();
    return _applyFilter(favorites, filter);
  }

  @override
  Future<void> addFavorite(String mealId) async {
    // TODO: replace with POST /favorites/{mealId}
    if (!_favoriteIds.contains(mealId)) {
      _favoriteIds.add(mealId);
    }
  }

  @override
  Future<void> removeFavorite(String mealId) async {
    // TODO: replace with DELETE /favorites/{mealId}
    _favoriteIds.remove(mealId);
  }

  @override
  bool isFavorite(String mealId, List<String> cachedIds) {
    return cachedIds.contains(mealId);
  }
}
