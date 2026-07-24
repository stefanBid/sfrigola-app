// Project Models
import 'package:sfrigola/core/models/json_serializable.dart';

// Project l10n
import 'package:sfrigola/core/l10n/app_localizations.dart';

// Project Models
import 'package:sfrigola/core/models/app_exception.dart';

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

class UserWithToken extends User {
  final String token;

  UserWithToken({
    required super.id,
    required super.name,
    super.surname,
    required super.email,
    required super.type,
    required this.token,
  });
}

// ---------------------------------------------------------------------------
// Auth exceptions
// ---------------------------------------------------------------------------

/// Wrong email / password combination during login.
class InvalidCredentialsException extends AppException {
  const InvalidCredentialsException() : super(AppErrorCode.unmapped);

  @override
  String localizedMessage(AppLocalizations l) => l.authErrorInvalidCredentials;
}

/// No account found for the provided email.
class UserNotFoundException extends AppException {
  const UserNotFoundException() : super(AppErrorCode.notFound);

  @override
  String localizedMessage(AppLocalizations l) => l.authErrorUserNotFound;
}

/// Email already associated with an existing account (registration).
class EmailAlreadyInUseException extends AppException {
  const EmailAlreadyInUseException() : super(AppErrorCode.conflict);

  @override
  String localizedMessage(AppLocalizations l) => l.authErrorEmailAlreadyInUse;
}

/// Password does not meet strength requirements (registration).
class WeakPasswordException extends AppException {
  const WeakPasswordException() : super(AppErrorCode.unmapped);

  @override
  String localizedMessage(AppLocalizations l) => l.authErrorWeakPassword;
}

/// Current password is incorrect (change-password flow).
class WrongCurrentPasswordException extends AppException {
  const WrongCurrentPasswordException() : super(AppErrorCode.unmapped);

  @override
  String localizedMessage(AppLocalizations l) =>
      l.authErrorWrongCurrentPassword;
}
