import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Repositories
import 'package:sfrigola/core/repositories/auth/auth_repository.dart';
import 'package:sfrigola/core/repositories/auth/auth_repository_impl.dart';
import 'package:sfrigola/core/repositories/favorites/favorites_repository.dart';
import 'package:sfrigola/core/repositories/favorites/favorites_repository_impl.dart';
import 'package:sfrigola/core/repositories/meal/meal_repository.dart';
import 'package:sfrigola/core/repositories/meal/meal_repository_impl.dart';
import 'package:sfrigola/core/repositories/admin/admin_repository.dart';
import 'package:sfrigola/core/repositories/admin/admin_repository_impl.dart';
import 'package:sfrigola/core/repositories/user/user_repository.dart';
import 'package:sfrigola/core/repositories/user/user_repository_impl.dart';
import 'package:sfrigola/core/repositories/language/language_repository.dart';
import 'package:sfrigola/core/repositories/language/language_repository_impl.dart';

// Project Providers
import 'package:sfrigola/core/providers/dio_client_provider.dart';

part 'repository_provider.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => AuthRepositoryImpl();

@Riverpod(keepAlive: true)
MealRepository mealRepository(Ref ref) => MealRepositoryImpl();

@Riverpod(keepAlive: true)
FavoritesRepository favoritesRepository(Ref ref) => FavoritesRepositoryImpl();

@Riverpod(keepAlive: true)
AdminRepository adminRepository(Ref ref) => AdminRepositoryImpl();

@Riverpod(keepAlive: true)
UserRepository userRepository(Ref ref) => UserRepositoryImpl();

@Riverpod(keepAlive: true)
LanguageRepository languageRepository(Ref ref) =>
    LanguageRepositoryImpl(ref.watch(dioClientProvider));
