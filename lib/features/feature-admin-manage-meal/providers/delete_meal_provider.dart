import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Repositories
import 'package:sfrigola/core/providers/repository_provider.dart';

part 'delete_meal_provider.g.dart';

@riverpod
class DeleteMeal extends _$DeleteMeal {
  @override
  FutureOr<void> build() {}

  Future<void> submit(String mealId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(adminRepositoryProvider);
      await repo.deleteMeal(mealId);
    });
  }
}

