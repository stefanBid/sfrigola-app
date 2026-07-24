// Project Models
import 'package:sfrigola/core/models/app_exception.dart';
import 'package:sfrigola/core/models/meal.dart';
import 'package:sfrigola/core/models/be-models/be_error.dart';
import 'package:sfrigola/core/models/be-models/get_request.dart';
import 'package:sfrigola/core/models/be-models/get_response.dart';
import 'package:sfrigola/core/models/be-models/mutation_response.dart';

// Project Repositories
import 'package:sfrigola/core/repositories/favorites/favorites_repository.dart';

// Project Utils
import 'package:sfrigola/core/utils/be_simulators.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  static void _checkResponse(BeError? error) {
    if (error != null) throw AppException.unmapped();
  }

  @override
  Future<GetListDataResponse<MealPreview>> getFavorites(
    GetRequest<MealFilterKey, MealSortKey> request,
  ) async {
    // TODO: replace with GET /favorites (auth via Dio interceptor)
    final response = await BeSimulators.getFavorites(
      request,
      simulateError: false,
    );
    _checkResponse(response.error);
    return response;
  }

  @override
  Future<MutationResponse> addFavorite(String mealId) async {
    // TODO: replace with POST /favorites/{mealId}
    final response = await BeSimulators.addFavorite(
      mealId: mealId,
      simulateError: false,
    );
    if (response.error != null) throw MealFavoriteException(mealId, true);
    return response;
  }

  @override
  Future<MutationResponse> removeFavorite(String mealId) async {
    // TODO: replace with DELETE /favorites/{mealId}
    final response = await BeSimulators.removeFavorite(
      mealId: mealId,
      simulateError: false,
    );
    if (response.error != null) throw MealFavoriteException(mealId, false);
    return response;
  }
}
