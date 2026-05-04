// Project Models
import 'package:sfrigola/core/models/category.dart';
import 'package:sfrigola/core/models/general_exception.dart';
import 'package:sfrigola/core/models/meal.dart';
import 'package:sfrigola/core/models/be-models/be_error.dart';
import 'package:sfrigola/core/models/be-models/get_response.dart';
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
    String? categoryId, {
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /meals/trending
    final response = await BeSimulators.getTrending(
      categoryId: categoryId,
      skip: skip,
      take: take,
      simulateError: false,
    );
    _checkResponse(response.error);
    return response;
  }

  @override
  Future<GetListDataResponse<MealPreview>> getEasy(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /meals?complexity=simple
    final response = await BeSimulators.getEasy(
      categoryId: categoryId,
      skip: skip,
      take: take,
      simulateError: false,
    );
    _checkResponse(response.error);
    return response;
  }

  @override
  Future<GetListDataResponse<MealPreview>> getChallenge(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /meals?complexity=hard
    final response = await BeSimulators.getChallenge(
      categoryId: categoryId,
      skip: skip,
      take: take,
      simulateError: false,
    );
    _checkResponse(response.error);
    return response;
  }

  @override
  Future<GetListDataResponse<MealPreview>> getBudget(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /meals?affordability=affordable
    final response = await BeSimulators.getBudget(
      categoryId: categoryId,
      skip: skip,
      take: take,
      simulateError: false,
    );
    _checkResponse(response.error);
    return response;
  }

  @override
  Future<GetListDataResponse<MealPreview>> getPremium(
    String? categoryId, {
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /meals?affordability=luxurious
    final response = await BeSimulators.getPremium(
      categoryId: categoryId,
      skip: skip,
      take: take,
      simulateError: false,
    );
    _checkResponse(response.error);
    return response;
  }

  @override
  Future<GetListDataResponse<MealPreview>> getAllMeals(
    String? searchKey, {
    int skip = 0,
    int take = 10,
  }) async {
    // TODO: replace with GET /meals
    final response = await BeSimulators.getAllMeals(
      searchKey: searchKey,
      skip: skip,
      take: take,
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
