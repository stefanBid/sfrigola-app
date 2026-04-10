import 'package:sfrigola/models/repository_filter.dart';

// ---------------------------------------------------------------------------
// Meal domain
// ---------------------------------------------------------------------------

/// Sentinel value to distinguish between "not passed" and explicit null.
const Object _sentinel = Object();

class MealRepositoryFilter extends RepositoryFilter {
  const MealRepositoryFilter({
    super.skip,
    super.take,
    this.categoryId,
    this.query = '',
  });

  /// When null, no category filter is applied.
  final String? categoryId;

  /// When empty, no text filter is applied.
  final String query;

  MealRepositoryFilter copyWith({
    Object? categoryId = _sentinel,
    String? query,
    int? skip,
    int? take,
  }) {
    return MealRepositoryFilter(
      categoryId: categoryId == _sentinel
          ? this.categoryId
          : categoryId as String?,
      query: query ?? this.query,
      skip: skip ?? this.skip,
      take: take ?? this.take,
    );
  }
}

class MealNotFoundException implements Exception {
  const MealNotFoundException(this.id);
  final String id;

  @override
  String toString() => 'MealNotFoundException: no meal found with id "$id"';
}
