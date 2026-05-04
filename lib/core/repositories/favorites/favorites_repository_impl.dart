// Project Models
import 'package:sfrigola/core/models/general_exception.dart';
import 'package:sfrigola/core/models/meal.dart';
import 'package:sfrigola/core/models/be-models/be_error.dart';
import 'package:sfrigola/core/models/be-models/be_filters.dart';
import 'package:sfrigola/core/models/be-models/get_response.dart';
import 'package:sfrigola/core/models/be-models/mutation_response.dart';

// Project Repositories
import 'package:sfrigola/core/repositories/favorites/favorites_repository.dart';

// Project Utils
import 'package:sfrigola/core/utils/be_simulators.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  static void _checkResponse(BeError? error) {
    if (error != null) throw GeneralException.generic();
  }

  @override
  Future<GetListDataResponse<MealPreview>> getFavorites({
    Complexity? complexity,
    Affordability? affordability,
    double? minRate,
    double? maxRate,
    SortOrder? sortOrder,
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /favorites (auth via Dio interceptor)
    final response = await BeSimulators.getFavorites(
      complexity: complexity,
      affordability: affordability,
      minRate: minRate,
      maxRate: maxRate,
      sortOrder: sortOrder,
      skip: skip,
      take: take,
      simulateError: false,
    );
    _checkResponse(response.error);
    return response;
  }

  @override
  Future<MutationResponse> addFavorite(String mealId) async {
    // TODO: replace with POST /favorites/{mealId}
    final response = await BeSimulators.addFavorite(mealId: mealId, simulateError: false);
    if (response.error != null) throw MealFavoriteException(mealId, true);
    return response;
  }

  @override
  Future<MutationResponse> removeFavorite(String mealId) async {
    // TODO: replace with DELETE /favorites/{mealId}
    final response = await BeSimulators.removeFavorite(mealId: mealId, simulateError: false);
    if (response.error != null) throw MealFavoriteException(mealId, false);
    return response;
  }
}
