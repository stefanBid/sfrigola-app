class ListProviderState<T> {
  final List<T> items;
  final bool hasMore;

  ListProviderState({required this.items, required this.hasMore});

  ListProviderState<T> copyWith({List<T>? items, bool? hasMore}) {
    return ListProviderState<T>(
      items: items ?? this.items,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
