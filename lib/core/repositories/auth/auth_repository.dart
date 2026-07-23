import 'package:sfrigola/core/models/be-models/mutation_response.dart';
import 'package:sfrigola/core/models/be-models/get_response.dart';
import 'package:sfrigola/core/models/user.dart';

abstract interface class AuthRepository {
  /// Logs in a user with the provided credentials.
  /// In production: POST /auth/login
  Future<GetDataResponse<UserWithToken>> login(String email, String password);

  /// Logs out the current user.
  Future<bool> logout();

  /// Registers a new user with the provided details.
  /// In production: POST /auth/register
  Future<MutationResponse> register(User user, String password);

  /// Changes the current user's password.
  /// In production: POST /auth/change-password
  Future<MutationResponse> changePassword(
    String currentPassword,
    String newPassword,
  );

  /// Returns the currently stored [User] from local secure storage.
  /// Returns null when no user is saved (logged out).
  Future<User?> getUser();
}

