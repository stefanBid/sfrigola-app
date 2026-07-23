import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Models
import 'package:sfrigola/core/models/user.dart';

// Project Providers
import 'package:sfrigola/core/providers/repository_provider.dart';

part 'current_user_provider.g.dart';

/// Returns the currently saved [User] from secure storage.
/// Null when no session is active (logged out or first launch).
///
/// Invalidate this provider after login / logout to reflect the new state:
/// ```dart
/// ref.invalidate(currentUserProvider);
/// ```
@Riverpod(keepAlive: true)
Future<User?> currentUser(Ref ref) async {
  final repo = ref.watch(authRepositoryProvider);
  return await repo.getUser();
}
