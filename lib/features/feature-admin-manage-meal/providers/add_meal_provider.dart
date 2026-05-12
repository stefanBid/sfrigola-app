import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Repositories
import 'package:sfrigola/core/providers/repository_provider.dart';

// Project Models
import 'package:sfrigola/core/models/meal.dart';

part 'add_meal_provider.g.dart';

@riverpod
class AddMeal extends _$AddMeal {
  @override
  FutureOr<void> build() {}

  Future<void> submit({required Meal meal}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(adminRepositoryProvider);
      await repo.addMeal(meal);
    });
  }
}
