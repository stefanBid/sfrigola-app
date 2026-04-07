// Project Models
import 'package:sfrigola/models/json_serializable.dart';

class Category implements JsonSerializable {
  const Category({required this.id, required this.title, this.icon});

  final String id;
  final String title;

  /// Emoji icon displayed next to the category title.
  final String? icon;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      title: json['title'] as String,
      icon: json['icon'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'icon': icon};
  }
}
