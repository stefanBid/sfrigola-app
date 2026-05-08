/// Direction of a sort clause sent to the backend.
enum SortDirection { asc, desc }

/// Generic sort parameter.
///
/// [T] must be an enum that enumerates the sortable fields for a specific
/// resource (e.g. `MealSortKey.name`, `MealSortKey.rating`).
///
/// Example:
/// ```dart
/// SortParam(key: MealSortKey.name, direction: SortDirection.asc)
/// ```
class SortParam<T extends Enum> {
  final T key;
  final SortDirection direction;

  const SortParam({required this.key, required this.direction});

  SortParam<T> copyWith({T? key, SortDirection? direction}) {
    return SortParam(
      key: key ?? this.key,
      direction: direction ?? this.direction,
    );
  }

  Map<String, dynamic> toJson() => {
    'key': key.name,
    'direction': direction.name,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SortParam<T> &&
          key == other.key &&
          direction == other.direction;

  @override
  int get hashCode => key.hashCode ^ direction.hashCode;
}
