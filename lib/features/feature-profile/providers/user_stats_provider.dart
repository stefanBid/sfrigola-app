import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Providers
import 'package:sfrigola/core/providers/repository_provider.dart';

part 'user_stats_provider.g.dart';

class UserStatsProviderState {
  final int favouritesCount;
  final int recipesCount;

  const UserStatsProviderState({
    required this.favouritesCount,
    required this.recipesCount,
  });
}

@riverpod
Future<UserStatsProviderState> userStats(Ref ref) async {
  final repo = ref.watch(userRepositoryProvider);
  final favourites = await repo.getFavouritesCount();
  final recipes = await repo.getRecipesCount();
  return UserStatsProviderState(
    favouritesCount: favourites.data,
    recipesCount: recipes.data,
  );
}
