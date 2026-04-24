// Project Models
import 'package:sfrigola/core/models/general_exception.dart';
import 'package:sfrigola/core/models/meal.dart';
import 'package:sfrigola/core/models/be-models/be_error.dart';
import 'package:sfrigola/core/models/be-models/get_response.dart';
import 'package:sfrigola/core/models/be-models/mutation_response.dart';

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
  Future<GetListDataResponse<Meal>> getFavorites(String? categoryId) async {
    // TODO: replace with GET /favorites (auth via Dio interceptor)
    final response = await BeSimulators.getFavorites(
      _favoriteIds,
      categoryId: categoryId,
      simulateError: false,
    );
    _checkResponse(response.error);
    return response;
  }

  @override
  Future<MutationResponse> addFavorite(String mealId) async {
    // TODO: replace with POST /favorites/{mealId}
    final response = await BeSimulators.addFavorite(simulateError: false);
    _checkResponse(response.error);
    if (!_favoriteIds.contains(mealId)) {
      _favoriteIds.add(mealId);
    }
    return response;
  }

  @override
  Future<MutationResponse> removeFavorite(String mealId) async {
    // TODO: replace with DELETE /favorites/{mealId}
    final response = await BeSimulators.removeFavorite(simulateError: false);
    _checkResponse(response.error);
    _favoriteIds.remove(mealId);
    return response;
  }

  @override
  bool isFavorite(String mealId, List<String> cachedIds) {
    return cachedIds.contains(mealId);
  }
}
