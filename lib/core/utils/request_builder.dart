// Project Models
import 'package:sfrigola/core/models/be-models/be_filter.dart';
import 'package:sfrigola/core/models/be-models/be_sort.dart';
import 'package:sfrigola/core/models/be-models/get_request.dart';

/// Fluent builder for [GetRequest].
///
/// Decouples providers from the internal construction details of
/// [GetRequest], [FilterGroup] and [FilterCondition].
///
/// Usage:
/// ```dart
/// RequestBuilder<MealFilterKey, MealSortKey>()
///     .setTake(10)
///     .addFilter(MealFilterKey.category, FilterOperator.equals, categoryId)
///     .setSort(MealSortKey.rating, SortDirection.desc)
///     .build();
/// ```
class RequestBuilder<TFilter extends Enum, TSort extends Enum> {
  String? _searchKey;
  int _skip = 0;
  int _take = 20;
  final List<FilterGroup<TFilter>> _filters = [];
  SortParam<TSort>? _sort;

  RequestBuilder<TFilter, TSort> setSearchKey(String? value) {
    _searchKey = value;
    return this;
  }

  RequestBuilder<TFilter, TSort> setSkip(int value) {
    _skip = value;
    return this;
  }

  RequestBuilder<TFilter, TSort> setTake(int value) {
    _take = value;
    return this;
  }

  /// Adds a single-condition [FilterGroup].
  /// Multiple calls = multiple groups = AND semantics between groups.
  RequestBuilder<TFilter, TSort> addFilter(
    TFilter key,
    FilterOperator comparator,
    Object value,
  ) {
    _filters.add(
      FilterGroup(conditions: [
        FilterCondition(key: key, comparator: comparator, value: value),
      ]),
    );
    return this;
  }

  /// Like [addFilter] but skips silently when [value] is null.
  /// Keeps the call chain fluent for optional filters.
  RequestBuilder<TFilter, TSort> addFilterIfNotNull(
    TFilter key,
    FilterOperator comparator,
    Object? value,
  ) {
    if (value != null) addFilter(key, comparator, value);
    return this;
  }

  /// Adds a pre-built [FilterGroup] for multi-condition OR groups.
  RequestBuilder<TFilter, TSort> addFilterGroup(FilterGroup<TFilter> group) {
    _filters.add(group);
    return this;
  }

  /// Removes all filter groups that contain at least one condition with [key].
  RequestBuilder<TFilter, TSort> removeFilter(TFilter key) {
    _filters.removeWhere(
      (group) => group.conditions.any((c) => c.key == key),
    );
    return this;
  }

  RequestBuilder<TFilter, TSort> setSort(TSort key, SortDirection direction) {
    _sort = SortParam(key: key, direction: direction);
    return this;
  }

  /// Like [setSort] but skips silently when [param] is null.
  /// Keeps the call chain fluent for optional sort params.
  RequestBuilder<TFilter, TSort> setSortIfNotNull(SortParam<TSort>? param) {
    if (param != null) _sort = param;
    return this;
  }

  RequestBuilder<TFilter, TSort> clearSort() {
    _sort = null;
    return this;
  }

  GetRequest<TFilter, TSort> build() => GetRequest(
    searchKey: _searchKey,
    skip: _skip,
    take: _take,
    filters: List.unmodifiable(_filters),
    sort: _sort,
  );
}


