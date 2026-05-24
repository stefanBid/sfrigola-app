// Project Models
import 'package:sfrigola/core/models/json_serializable.dart';

enum UserType { admin, chef, consumer }

class User implements JsonSerializable {
  final String id;
  final String name;
  final String? surname;
  final String email;
  final UserType type;

  User({
    required this.id,
    required this.name,
    this.surname,
    required this.email,
    required this.type,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      type: UserType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'email': email,
      'type': type.toString().split('.').last,
    };
  }

  UserType get userType => type;
}
