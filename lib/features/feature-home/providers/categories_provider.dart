import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Models
import 'package:sfrigola/core/models/category.dart';

// Project Providers
import 'package:sfrigola/core/providers/repository_provider.dart';

part 'categories_provider.g.dart';

class CategoriesProviderState {
  final List<Category> categories;

  CategoriesProviderState({required this.categories});
}

@riverpod
Future<CategoriesProviderState> categories(Ref ref) async {
  final repo = ref.watch(mealRepositoryProvider);
  final response = await repo.getCategories();
  return CategoriesProviderState(categories: response.data);
}
