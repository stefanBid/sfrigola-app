// Project Models
import 'package:sfrigola/core/models/meal.dart';
import 'package:sfrigola/core/models/be-models/mutation_response.dart';

// Project Repositories
import 'package:sfrigola/core/repositories/admin/admin_repository.dart';

// Project Utils
import 'package:sfrigola/core/utils/be_simulators.dart';

class AdminRepositoryImpl implements AdminRepository {
  @override
  Future<MutationResponse> addMeal(Meal meal) async {
    // TODO: replace with POST /admin/meals
    final response = await BeSimulators.addMeal(
      meal: meal,
      simulateError: false,
    );
    if (response.error != null) {
      throw const MealMutationException(MealMutationType.add);
    }
    return response;
  }

  @override
  Future<MutationResponse> updateMeal(Meal meal) async {
    // TODO: replace with PUT /admin/meals/{mealId}
    final response = await BeSimulators.updateMeal(
      meal: meal,
      simulateError: false,
    );
    if (response.error != null) {
      throw const MealMutationException(MealMutationType.update);
    }
    return response;
  }

  @override
  Future<MutationResponse> deleteMeal(String mealId) async {
    // TODO: replace with DELETE /admin/meals/{mealId}
    final response = await BeSimulators.deleteMeal(
      mealId: mealId,
      simulateError: false,
    );
    if (response.error != null) {
      throw const MealMutationException(MealMutationType.delete);
    }
    return response;
  }
}
