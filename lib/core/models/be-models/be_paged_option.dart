/// Mirrors the backend's `SCPagedOptionDto` record:
/// ```java
/// public record SCPagedOptionDto(
///     Integer currentPage,      // Current page number (1-based)
///     Integer pageSize,         // Number of items per page
///     Long totalElements,       // Total number of elements across all pages
///     Integer totalPages,       // Total number of pages
///     Boolean hasMore           // Whether there are more pages available
/// ) implements Serializable {
///     public static SCPagedOptionDto of(Integer currentPage, Integer pageSize, Long totalElements, Integer totalPages, Boolean hasMore) {
///         return new SCPagedOptionDto(currentPage, pageSize, totalElements, totalPages, hasMore);
///     }
///
///     public static SCPagedOptionDto noItems(){
///         return new SCPagedOptionDto(0, 0, 0L, 0, false);
///     }
/// }
/// ```
class BePagedOption {
  final int currentPage;
  final int pageSize;
  final int totalElements;
  final int totalPages;
  final bool hasMore;

  const BePagedOption({
    required this.currentPage,
    required this.pageSize,
    required this.totalElements,
    required this.totalPages,
    required this.hasMore,
  });

  factory BePagedOption.fromJson(Map<String, dynamic> json) => BePagedOption(
    currentPage: json['currentPage'] as int,
    pageSize: json['pageSize'] as int,
    totalElements: json['totalElements'] as int,
    totalPages: json['totalPages'] as int,
    hasMore: json['hasMore'] as bool,
  );
}
