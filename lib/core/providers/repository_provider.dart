import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project Repositories
import 'package:sfrigola/core/repositories/favorites/favorites_repository.dart';
import 'package:sfrigola/core/repositories/favorites/favorites_repository_impl.dart';
import 'package:sfrigola/core/repositories/meal/meal_repository.dart';
import 'package:sfrigola/core/repositories/meal/meal_repository_impl.dart';
import 'package:sfrigola/core/repositories/admin/admin_repository.dart';
import 'package:sfrigola/core/repositories/admin/admin_repository_impl.dart';

part 'repository_provider.g.dart';

@Riverpod(keepAlive: true)
MealRepository mealRepository(Ref ref) => MealRepositoryImpl();

@Riverpod(keepAlive: true)
FavoritesRepository favoritesRepository(Ref ref) => FavoritesRepositoryImpl();

@Riverpod(keepAlive: true)
AdminRepository adminRepository(Ref ref) => AdminRepositoryImpl();
