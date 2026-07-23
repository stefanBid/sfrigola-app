// Project Models
import 'package:sfrigola/core/models/category.dart';
import 'package:sfrigola/core/models/general_exception.dart';
import 'package:sfrigola/core/models/meal.dart';
import 'package:sfrigola/core/models/be-models/be_error.dart';
import 'package:sfrigola/core/models/be-models/get_response.dart';
import 'package:sfrigola/core/models/be-models/get_request.dart';
import 'package:sfrigola/core/models/be-models/mutation_response.dart';

// Project Repositories
import 'package:sfrigola/core/repositories/meal/meal_repository.dart';

// Project Utils
import 'package:sfrigola/core/utils/be_simulators.dart';

class MealRepositoryImpl implements MealRepository {
  static void _checkResponse(BeError? error) {
    if (error != null) throw GeneralException.generic();
  }

  @override
  Future<GetListDataResponse<Category>> getCategories() async {
    // TODO: replace with GET /categories
    final response = await BeSimulators.getCategories(simulateError: false);
    _checkResponse(response.error);
    return response;
  }

  @override
  Future<GetListDataResponse<MealPreview>> getTrending(
    GetRequest<MealFilterKey, MealSortKey> request,
  ) async {
    // TODO: replace with GET /meals/trending
    final response = await BeSimulators.getTrending(
      request,
      simulateError: false,
    );
    _checkResponse(response.error);
    return response;
  }

  @override
  Future<GetListDataResponse<MealPreview>> getEasy(
    GetRequest<MealFilterKey, MealSortKey> request,
  ) async {
    // TODO: replace with GET /meals?complexity=simple
    final response = await BeSimulators.getEasy(request, simulateError: false);
    _checkResponse(response.error);
    return response;
  }

  @override
  Future<GetListDataResponse<MealPreview>> getChallenge(
    GetRequest<MealFilterKey, MealSortKey> request,
  ) async {
    // TODO: replace with GET /meals?complexity=hard
    final response = await BeSimulators.getChallenge(
      request,
      simulateError: false,
    );
    _checkResponse(response.error);
    return response;
  }

  @override
  Future<GetListDataResponse<MealPreview>> getBudget(
    GetRequest<MealFilterKey, MealSortKey> request,
  ) async {
    // TODO: replace with GET /meals?affordability=affordable
    final response = await BeSimulators.getBudget(
      request,
      simulateError: false,
    );
    _checkResponse(response.error);
    return response;
  }

  @override
  Future<GetListDataResponse<MealPreview>> getPremium(
    GetRequest<MealFilterKey, MealSortKey> request,
  ) async {
    // TODO: replace with GET /meals?affordability=luxurious
    final response = await BeSimulators.getPremium(
      request,
      simulateError: false,
    );
    _checkResponse(response.error);
    return response;
  }

  @override
  Future<GetListDataResponse<MealPreview>> getAllMeals(
    GetRequest<MealFilterKey, MealSortKey> request,
  ) async {
    // TODO: replace with GET /meals
    final response = await BeSimulators.getAllMeals(
      request,
      simulateError: false,
    );
    _checkResponse(response.error);
    return response;
  }

  @override
  Future<GetDataResponse<Meal>> getMealById(String id) async {
    // TODO: replace with GET /meals/{id}
    try {
      final response = await BeSimulators.getMealById(id, simulateError: false);
      if (response.error != null) throw MealNotFoundException(id);
      return response;
    } on StateError {
      throw MealNotFoundException(id);
    }
  }

  @override
  Future<MutationResponse> updateMealRating(
    String mealId,
    double newRating,
  ) async {
    // TODO: replace with PATCH /meals/{id}/rating
    final response = await BeSimulators.updateMealRating(
      mealId: mealId,
      newRating: newRating,
      simulateError: false,
    );
    if (response.error != null) throw MealRateExeption(mealId);
    return response;
  }
}

