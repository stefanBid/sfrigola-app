// Project Data
import 'package:sfrigola/core/data/dummy_data.dart';

// Project Models
import 'package:sfrigola/core/models/meal.dart';

// Project Repositories
import 'package:sfrigola/core/repositories/favorites/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  /// In-memory favorite IDs — replace with server-side user data.
  final List<String> _favoriteIds = ['m1', 'm5', 'm12', 'm20', 'm28'];

  @override
  Future<List<Meal>> getFavorites(String? categoryId) async {
    // TODO: replace with GET /favorites (auth via Dio interceptor)
    final favorites = availableMeals
        .where((meal) => _favoriteIds.contains(meal.id))
        .toList();
    if (categoryId == null) return favorites;
    return favorites
        .where((meal) => meal.categories.contains(categoryId))
        .toList();
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
