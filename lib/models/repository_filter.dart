abstract class RepositoryFilter {
  const RepositoryFilter({this.skip = 0, this.take = 10});

  /// Number of items to skip (offset-based pagination).
  final int skip;

  /// Maximum number of items to return.
  final int take;
}
