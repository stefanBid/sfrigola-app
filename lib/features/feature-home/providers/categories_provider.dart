import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Models
import 'package:sfrigola/core/models/category.dart';

// Project Providers
import 'package:sfrigola/core/providers/repository_provider.dart';

part 'categories_provider.g.dart';

@riverpod
Future<List<Category>> categories(Ref ref) async {
  final repo = ref.watch(mealRepositoryProvider);
  return repo.getCategories();
}
