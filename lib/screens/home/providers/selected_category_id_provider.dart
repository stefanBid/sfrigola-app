import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_category_id_provider.g.dart';

@riverpod
class SelectedCategoryId extends _$SelectedCategoryId {
  @override
  String? build() {
    return null; // No category selected by default
  }

  void select(String? categoryId) {
    state = categoryId;
  }
}
