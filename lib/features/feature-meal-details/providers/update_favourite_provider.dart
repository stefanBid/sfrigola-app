import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Repositories
import 'package:sfrigola/core/providers/repository_provider.dart';

part 'update_favourite_provider.g.dart';

@riverpod
class UpdateFavourite extends _$UpdateFavourite {
  @override
  FutureOr<void> build() {}

  Future<void> toggle(bool isFavourite, String mealId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(favoritesRepositoryProvider);
      if (isFavourite) {
        await repo.removeFavorite(mealId);
      } else {
        await repo.addFavorite(mealId);
      }
    });
  }
}
