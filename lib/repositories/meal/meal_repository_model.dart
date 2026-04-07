import 'package:sfrigola/models/repository_filter.dart';

// ---------------------------------------------------------------------------
// Meal domain
// ---------------------------------------------------------------------------

class MealFilter extends RepositoryFilter {
  const MealFilter({super.skip, super.take, this.categoryId, this.query = ''});

  /// When null, no category filter is applied.
  final String? categoryId;

  /// Generic search key — BE matches against title and subtitle.
  /// When empty, no text filter is applied.
  final String query;
}

class MealNotFoundException implements Exception {
  const MealNotFoundException(this.id);
  final String id;

  @override
  String toString() => 'MealNotFoundException: no meal found with id "$id"';
}
