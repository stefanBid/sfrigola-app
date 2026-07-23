import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// Core Layouts
import 'core/layouts/app_layout.dart';

// Features
import 'features/feature-home/home_screen.dart';
import 'features/feature-meal-details/meal_details_screen.dart';
import 'features/feature-search/search_screen.dart';
import 'features/feature-favourites/favourite_screen.dart';
import 'features/feature-admin-cookbook/cookbook_screen.dart';
import 'features/feature-profile/profile_screen.dart';
import 'features/feature-admin-manage-meal/manage_meal_screen.dart';
import 'features/feature-login/login_screen.dart';

Widget _customTransitionBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return FadeTransition(opacity: animation, child: child);
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  redirect: (context, state) {
    if (state.uri.path == '/') return '/home';
    return null;
  },
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppLayout(child: child),
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HomeScreen()),
        ),
        GoRoute(
          path: '/search',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: SearchScreen()),
        ),
        GoRoute(
          path: '/favourites',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: FavouriteScreen()),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ProfileScreen()),
        ),
        GoRoute(
          path: '/cookbook',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: CookbookScreen()),
        ),
      ],
    ),
    ShellRoute(
      builder: (context, state, child) =>
          AppLayout(withBottomNav: false, child: child),
      routes: [
        GoRoute(
          path: '/meal/:mealId',
          pageBuilder: (context, state) {
            final mealId = state.pathParameters['mealId']!;
            return CustomTransitionPage(
              key: state.pageKey,
              child: MealDetailsScreen(mealId: mealId),
              transitionsBuilder: _customTransitionBuilder,
              transitionDuration: const Duration(milliseconds: 150),
            );
          },
        ),
        GoRoute(
          path: '/manage-meal',
          pageBuilder: (context, state) {
            final mealId = state.uri.queryParameters['mealId'];
            return CustomTransitionPage(
              key: state.pageKey,
              child: ManageMealScreen(mealId: mealId),
              transitionsBuilder: _customTransitionBuilder,
              transitionDuration: const Duration(milliseconds: 150),
            );
          },
        ),
        GoRoute(
          path: '/login',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const LoginScreen(),
            transitionsBuilder: _customTransitionBuilder,
            transitionDuration: const Duration(milliseconds: 150),
          ),
        ),
      ],
    ),
  ],
);
