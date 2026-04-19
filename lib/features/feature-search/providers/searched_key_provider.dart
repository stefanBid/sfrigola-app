import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'searched_key_provider.g.dart';

@riverpod
class SearchedKey extends _$SearchedKey {
  @override
  String? build() {
    return null; // No search key by default
  }

  void change(String? newKey) {
    state = newKey;
  }
}
