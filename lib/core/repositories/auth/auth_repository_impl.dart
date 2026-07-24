import 'package:sfrigola/core/helpers/app_storage.dart';
import 'package:sfrigola/core/models/be-models/be_error.dart';
import 'package:sfrigola/core/models/be-models/get_response.dart';
import 'package:sfrigola/core/models/be-models/mutation_response.dart';
import 'package:sfrigola/core/models/app_exception.dart';
import 'package:sfrigola/core/models/user.dart';

// Project Repositories
import 'package:sfrigola/core/repositories/auth/auth_repository.dart';

// Project Utils
import 'package:sfrigola/core/utils/be_simulators.dart';

class AuthRepositoryImpl implements AuthRepository {
  static const _tokenKey = 'auth_token';
  static const _userKey = 'auth_user';

  /// Maps a [BeError] from login / register to the correct typed exception.
  static void _checkResponse(BeError? error) {
    if (error == null) return;
    throw switch (error.code) {
      'UNAUTHORIZED' => const InvalidCredentialsException(),
      'CONFLICT' => const EmailAlreadyInUseException(),
      _ => AppException.unmapped(),
    };
  }

  @override
  Future<GetDataResponse<UserWithToken>> login(
    String email,
    String password,
  ) async {
    // TODO: replace with POST /auth/login
    final response = await BeSimulators.login(email: email, password: password);
    _checkResponse(response.error);
    final user = response.data;
    await Future.wait([
      AppStorage.instance.write(_tokenKey, user.token),
      AppStorage.instance.writeObject<User>(_userKey, user, (u) => u.toJson()),
    ]);
    return response;
  }

  @override
  Future<bool> logout() async {
    await Future.wait([
      AppStorage.instance.delete(_tokenKey),
      AppStorage.instance.delete(_userKey),
    ]);
    return true;
  }

  @override
  Future<MutationResponse> register(User user, String password) async {
    // TODO: replace with POST /auth/register
    final response = await BeSimulators.register(
      user: user,
      password: password,
    );
    _checkResponse(response.error);
    return response;
  }

  @override
  Future<MutationResponse> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    // TODO: replace with POST /auth/change-password
    final response = await BeSimulators.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    if (response.error != null) {
      throw switch (response.error!.code) {
        'UNAUTHORIZED' => const WrongCurrentPasswordException(),
        _ => AppException.unmapped(),
      };
    }
    return response;
  }

  @override
  Future<User?> getUser() =>
      AppStorage.instance.readObject<User>(_userKey, User.fromJson);
}
