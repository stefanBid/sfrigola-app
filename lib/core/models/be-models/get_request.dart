// Project Models
import 'package:sfrigola/core/models/be-models/be_filter.dart';
import 'package:sfrigola/core/models/be-models/be_sort.dart';

/// Standard envelope for every paginated / filtered GET request sent to the
/// backend.
///
/// [TFilter] — enum that enumerates the filterable fields for the resource.
/// [TSort]   — enum that enumerates the sortable fields for the resource.
///
/// [skip] and [take] drive offset pagination. Defaults: skip = 0, take = 20.
/// All other properties are optional: an empty [GetRequest] fetches the first
/// page with no filtering or sorting.
///
/// Example:
/// ```dart
/// GetRequest<MealFilterKey, MealSortKey>(
///   searchKey: 'pasta',
///   skip: 0,
///   take: 20,
///   filters: [
///     FilterGroup(conditions: [
///       FilterCondition(key: MealFilterKey.category, comparator: FilterOperator.equals, value: 'pasta'),
///       FilterCondition(key: MealFilterKey.category, comparator: FilterOperator.equals, value: 'riso'),
///     ]),
///   ],
///   sort: SortParam(key: MealSortKey.name, direction: SortDirection.asc),
/// )
/// ```
class GetRequest<TFilter extends Enum, TSort extends Enum> {
  final String? searchKey;
  final int skip;
  final int take;
  final List<FilterGroup<TFilter>> filters;
  final SortParam<TSort>? sort;

  const GetRequest({
    this.searchKey,
    this.skip = 0,
    this.take = 20,
    this.filters = const [],
    this.sort,
  });

  GetRequest<TFilter, TSort> copyWith({
    String? searchKey,
    int? skip,
    int? take,
    List<FilterGroup<TFilter>>? filters,
    SortParam<TSort>? sort,
  }) {
    return GetRequest(
      searchKey: searchKey ?? this.searchKey,
      skip: skip ?? this.skip,
      take: take ?? this.take,
      filters: filters ?? this.filters,
      sort: sort ?? this.sort,
    );
  }

  Map<String, dynamic> toJson() => {
    if (searchKey != null) 'searchKey': searchKey,
    'skip': skip,
    'take': take,
    if (filters.isNotEmpty) 'filters': filters.map((f) => f.toJson()).toList(),
    if (sort != null) 'sort': sort!.toJson(),
  };
}
