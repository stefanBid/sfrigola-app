// Project Data
import 'package:sfrigola/core/data/dummy_data.dart';

// Project Models
import 'package:sfrigola/core/models/general_exception.dart';
import 'package:sfrigola/core/models/meal.dart';
import 'package:sfrigola/core/models/be-models/be_error.dart';

// Project Repositories
import 'package:sfrigola/core/repositories/favorites/favorites_repository.dart';

// Project Utils
import 'package:sfrigola/core/utils/be_simulators.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  /// In-memory favorite IDs — replace with server-side user data.
  final List<String> _favoriteIds = [];

  static void _checkResponse(BeError? error) {
    if (error != null) throw GeneralException.generic();
  }

  @override
  Future<List<Meal>> getFavorites(String? categoryId) async {
    // TODO: replace with GET /favorites (auth via Dio interceptor)
    final favorites = availableMeals
        .where((meal) => _favoriteIds.contains(meal.id))
        .toList();
    final filtered = categoryId == null
        ? favorites
        : favorites
              .where((meal) => meal.categories.contains(categoryId))
              .toList();
    final response = await BeSimulators.getList(
      data: filtered,
      total: filtered.length,
      delay: const Duration(milliseconds: 300),
      simulateError: false,
    );
    _checkResponse(response.error);
    return response.data;
  }

  @override
  Future<void> addFavorite(String mealId) async {
    // TODO: replace with POST /favorites/{mealId}
    final error = await BeSimulators.voidCall(simulateError: false);
    _checkResponse(error);
    if (!_favoriteIds.contains(mealId)) {
      _favoriteIds.add(mealId);
    }
  }

  @override
  Future<void> removeFavorite(String mealId) async {
    // TODO: replace with DELETE /favorites/{mealId}
    final error = await BeSimulators.voidCall(simulateError: false);
    _checkResponse(error);
    _favoriteIds.remove(mealId);
  }

  @override
  bool isFavorite(String mealId, List<String> cachedIds) {
    return cachedIds.contains(mealId);
  }
}
