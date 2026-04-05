// * ════════════════════════════════════════════════════════════════════════════
// *  APP ROUTER
// * ════════════════════════════════════════════════════════════════════════════
// *
// *  Type-safe navigation layer on top of go_router. Consuming code must never
// *  call context.go() directly — always use AppRouter.
// *
// *  AppRouter.goTo(context, AppRouter.home)
// *  AppRouter.goDeep(context, AppRouter.details, params: DetailParams(...))
// *  AppRouter.goBack(context)
// *
// * ════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// * ════════════════════════════════════════════════════════════════════════════
// *  TYPED NAVIGATION LAYER
// * ════════════════════════════════════════════════════════════════════════════
// *
// *  This file implements an abstraction layer on top of go_router that allows
// *  navigating between screens without ever knowing the URL path structure.
// *
// *  ! Consuming code must NEVER call context.go() directly,
// *  ! nor know strings like '/meal/:mealId'. Everything goes through AppRouter.
// *
// *  The mechanism is based on three concepts:
// *
// *  ? 1. AppTypedRoute<P>
// *       Represents an app route. The generic P statically binds
// *       each route to the type of parameters it accepts. The compiler
// *       prevents passing the wrong params.
// *
// *  ? 2. GenericRouteParams
// *       Base class for all parameters. Each route with params
// *       defines its own subclass with typed fields and
// *       implements toPathParams() and toQueryParams() to map
// *       values to URL segments.
// *
// *  ? 3. AppRouter.goTo()
// *       Single entry point for navigation. Receives the route and
// *       params, automatically resolves placeholders (:mealId → value),
// *       builds the complete Uri and calls context.go().
// *
// *  ADDING A NEW ROUTE:
// *    1. Create the params class extending GenericRouteParams
// *    2. Add the constant in AppRoutes
// *    todo 3. AppRouter should never be touched
// *
// * ════════════════════════════════════════════════════════════════════════════

abstract class GenericRouteParams {
  const GenericRouteParams();
  Map<String, String> toPathParams() => {};
  Map<String, String> toQueryParams() => {};
}

class NoParams extends GenericRouteParams {
  const NoParams();
}

class AppTypedRoute<P extends GenericRouteParams> {
  final String path;
  const AppTypedRoute(this.path);
}

class DetailParams extends GenericRouteParams {
  final String detailId;

  const DetailParams({required this.detailId});

  @override
  Map<String, String> toPathParams() => {'detailId': detailId};
}

class AppRouter {
  const AppRouter._();

  static const home = AppTypedRoute<NoParams>('/home');
  static const forms = AppTypedRoute<NoParams>('/form');
  static const profile = AppTypedRoute<NoParams>('/profile');
  static const details = AppTypedRoute<DetailParams>('/details/:detailId');

  static void goTo<P extends GenericRouteParams>(
    BuildContext context,
    AppTypedRoute<P> route, {
    P? params,
    Object? extra,
  }) {
    context.go(_resolve(route, params), extra: extra);
  }

  static void goDeep<P extends GenericRouteParams>(
    BuildContext context,
    AppTypedRoute<P> route, {
    P? params,
    Object? extra,
  }) {
    context.push(_resolve(route, params), extra: extra);
  }

  static String _resolve<P extends GenericRouteParams>(
    AppTypedRoute<P> route,
    P? params,
  ) {
    String resolvedPath = route.path;
    final pathParams = params?.toPathParams() ?? {};
    final queryParams = params?.toQueryParams() ?? {};

    for (final entry in pathParams.entries) {
      resolvedPath = resolvedPath.replaceAll(
        ':${entry.key}',
        Uri.encodeComponent(entry.value),
      );
    }

    assert(
      !RegExp(r':\w+').hasMatch(resolvedPath),
      '[AppRouter] Missing parameters. Required: '
      '${RegExp(r':(\w+)').allMatches(route.path).map((m) => m.group(1)).join(', ')}',
    );

    return Uri(
      path: resolvedPath,
      queryParameters: queryParams.isEmpty ? null : queryParams,
    ).toString();
  }

  static void goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      goTo(context, home);
    }
  }
}
