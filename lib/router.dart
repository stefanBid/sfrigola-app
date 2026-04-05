import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// Layouts
import 'layouts/app_layout.dart';

// Screens
import 'screens/details/details_screen.dart';
import 'screens/form/form_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/profile/profile_screen.dart';

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
          path: '/form',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: FormScreen()),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ProfileScreen()),
        ),
      ],
    ),
    ShellRoute(
      builder: (context, state, child) =>
          AppLayout(withBottomNav: false, child: child),
      routes: [
        GoRoute(
          path: '/details/:detailId',
          pageBuilder: (context, state) {
            final detailId = state.pathParameters['detailId']!;
            return CustomTransitionPage(
              key: state.pageKey,
              child: DetailsScreen(detailId: detailId),
              transitionsBuilder: _customTransitionBuilder,
              transitionDuration: const Duration(milliseconds: 150),
            );
          },
        ),
      ],
    ),
  ],
);
