import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Providers
import 'package:sfrigola/core/providers/repository_provider.dart';

part 'update_rating_provider.g.dart';

@riverpod
class UpdateRating extends _$UpdateRating {
  @override
  FutureOr<void> build(String mealId) {}

  Future<void> rate(double newRating) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(mealRepositoryProvider)
          .updateMealRating(mealId, newRating);
    });
  }
}

