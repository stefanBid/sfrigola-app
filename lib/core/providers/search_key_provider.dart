import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_key_provider.g.dart';

/// Centralised search scope identifiers.
/// Add a new constant here every time a new search bar is introduced.
/// Use these constants everywhere instead of raw strings.
abstract final class SearchScope {
  static const String search = 'search';
  static const String adminCookbook = 'admin-cookbook';
}

/// Generic search key provider — one instance per [scope].
/// Each search bar in the app uses its own isolated state:
///
///   ref.watch(searchKeyProvider(SearchScope.search))
///   ref.watch(searchKeyProvider(SearchScope.adminCookbook))
@riverpod
class SearchKey extends _$SearchKey {
  @override
  String? build(String scopeId) {
    return null; // No search key by default
  }

  void change(String? newKey) {
    state = newKey;
  }

  void clear() {
    state = null;
  }
}
