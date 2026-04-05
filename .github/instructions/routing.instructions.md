---
applyTo: "**/*router*"
---

# Navigation — AppRouter / go_router

**Never** call `context.go('/path')` directly. Always use typed navigation:

```dart
AppRouter.goTo(context, AppRouter.home);
AppRouter.goTo(context, AppRouter.details, params: DetailParams(detailId: '123'));
AppRouter.goDeep(context, AppRouter.details, params: DetailParams(detailId: '123')); // push
AppRouter.goBack(context);
```

---

## How it works

- `AppTypedRoute<P>` — binds a route to its params type at compile time
- `GenericRouteParams` — base class; implement `toPathParams()` / `toQueryParams()`
- `NoParams` — use when a route has no parameters

---

## Transitions

- Top-level tabs (home/form/profile) → `NoTransitionPage`
- Detail routes → `CustomTransitionPage` with `FadeTransition` (150ms)

```dart
// Tab
GoRoute(
  path: '/home',
  pageBuilder: (context, state) => const NoTransitionPage(child: HomeScreen()),
),

// Detail
GoRoute(
  path: '/details/:detailId',
  pageBuilder: (context, state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: DetailsScreen(detailId: state.pathParameters['detailId']!),
      transitionsBuilder: (context, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
      transitionDuration: const Duration(milliseconds: 150),
    );
  },
),
```

---

## Workflow — Adding a new page/route

Before generating any code, collect these three things with a **single** `vscode_askQuestions` call:

1. **Route name** — `camelCase` (e.g. `recipeDetail`). Derive URL in kebab-case automatically (`/recipe-detail`).
2. **Path params** — dynamic URL segments (e.g. `recipeId` → `/recipe-detail/:recipeId`). If none, use `NoParams`.
3. **Query params** — query string params (e.g. `?tab=ingredients`). If none, omit.

### Step 1 — Create the screen

Create `lib/screens/<route-name>/<route_name>_screen.dart`:

```dart
import 'package:flutter/material.dart';
import '../../layouts/body/standard_page_layout.dart';

class RecipeDetailScreen extends StatelessWidget {
  const RecipeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const StandardPageLayout(
      body: Center(child: Text('RecipeDetailScreen')),
    );
  }
}
```

### Step 2 — Add params class + route constant in `app_router.dart`

```dart
class RecipeDetailParams extends GenericRouteParams {
  final String recipeId;
  const RecipeDetailParams({required this.recipeId});

  @override
  Map<String, String> toPathParams() => {'recipeId': recipeId};
}

// Inside AppRouter class:
static const recipeDetail = AppTypedRoute<RecipeDetailParams>('/recipe-detail/:recipeId');
```

If no params: `static const myRoute = AppTypedRoute<NoParams>('/my-route');`

### Step 3 — Register in `router.dart`

```dart
GoRoute(
  path: '/recipe-detail/:recipeId',
  pageBuilder: (context, state) {
    final params = RecipeDetailParams(
      recipeId: state.pathParameters['recipeId']!,
    );
    return CustomTransitionPage(
      child: RecipeDetailScreen(params: params),
      transitionsBuilder: (context, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
      transitionDuration: const Duration(milliseconds: 150),
    );
  },
),
```

Consuming code navigates **only** via `AppRouter.goTo` / `AppRouter.goDeep` — never with raw path strings.
