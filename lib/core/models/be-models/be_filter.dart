/// Comparison operator applied to a single filter condition.
///
/// Extend this enum as new operators are needed on the backend.
enum FilterOperator {
  equals,
  notEquals,
  greaterThan,
  greaterThanOrEquals,
  lessThan,
  lessThanOrEquals,
  contains,
  startsWith,
}

/// A single filter predicate.
///
/// [T] must be an enum that enumerates the filterable fields for a specific
/// resource (e.g. `MealFilterKey.category`, `MealFilterKey.complexity`).
///
/// [value] is typed as [Object?] because the compared value can be a
/// [String], [int], [double], [bool], or [DateTime].
///
/// Example:
/// ```dart
/// FilterCondition(
///   key: MealFilterKey.complexity,
///   comparator: FilterOperator.lessThanOrEquals,
///   value: 3,
/// )
/// ```
class FilterCondition<T extends Enum> {
  final T key;
  final FilterOperator comparator;
  final Object? value;

  const FilterCondition({
    required this.key,
    required this.comparator,
    this.value,
  });

  Map<String, dynamic> toJson() => {
    'key': key.name,
    'comparator': comparator.name,
    if (value != null) 'value': value,
  };
}

/// A group of [FilterCondition]s.
///
/// Implicit semantics (enforced by the backend):
/// - Conditions inside the same group → combined with **OR**
/// - Multiple groups in a [GetRequest] → combined with **AND**
///
/// Example — (category = pasta OR category = riso) AND (complexity <= 3):
/// ```dart
/// [
///   FilterGroup(conditions: [
///     FilterCondition(key: MealFilterKey.category, comparator: FilterOperator.equals, value: 'pasta'),
///     FilterCondition(key: MealFilterKey.category, comparator: FilterOperator.equals, value: 'riso'),
///   ]),
///   FilterGroup(conditions: [
///     FilterCondition(key: MealFilterKey.complexity, comparator: FilterOperator.lessThanOrEquals, value: 3),
///   ]),
/// ]
/// ```
class FilterGroup<T extends Enum> {
  final List<FilterCondition<T>> conditions;

  const FilterGroup({required this.conditions});

  Map<String, dynamic> toJson() => {
    'conditions': conditions.map((c) => c.toJson()).toList(),
  };
}

