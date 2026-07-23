import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Repositories
import 'package:sfrigola/core/providers/repository_provider.dart';

// Project

part 'login_provider.g.dart';

@riverpod
class Login extends _$Login {
  @override
  FutureOr<void> build() {}

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(authRepositoryProvider);
      await repo.login(email, password);
    });
  }
}
