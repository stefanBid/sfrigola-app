---
applyTo: "**/repositories/**"
---

# Repository Layer

The repository layer is the **single point of contact between the app and any data source** (remote API, local DB, mock). Provider and UI layers never access data directly — they always go through a repository.

---

## File structure — `lib/core/repositories/`

```
lib/core/repositories/
  meal/
    meal_repository_model.dart    ← MealFilter + MealNotFoundException
    meal_repository.dart          ← abstract interface only
    meal_repository_impl.dart     ← concrete implementation only
  favorites/
    favorites_repository.dart          ← abstract interface only
    favorites_repository_impl.dart     ← concrete implementation only
```

> **Rule**: one subdirectory per repository domain. Each domain contains a `*_repository_model.dart` file (value objects, exceptions, response shapes) + one abstract file + one implementation file.

> `meal/meal_repository_model.dart` is the canonical home of `MealFilter` and `MealNotFoundException`. `FavoritesRepository` imports `MealFilter` from there — it is a meal-domain concept used across repositories.

---

## `RepositoryFilter` + `MealFilter`

`RepositoryFilter` lives in `lib/core/models/repository_filter.dart` — it is a **global model**, not repository-scoped, because the pagination contract is shared across all domains.

`MealFilter` lives in `lib/core/repositories/meal/meal_repository_model.dart` and extends it with meal-domain parameters. The UI knows `Category` and `query` — it never knows about BE field names or query param formats.

```dart
// lib/models/repository_filter.dart
abstract class RepositoryFilter {
  const RepositoryFilter({this.skip = 0, this.take = 10});
  final int skip;
  final int take;
}

// lib/repositories/meal/meal_repository_model.dart
class MealFilter extends RepositoryFilter {
  const MealFilter({super.skip, super.take, this.categoryId, this.query = ''});

  /// null = no category filter applied.
  final String? categoryId;

  /// Generic search key — BE matches against title and subtitle.
  /// '' = no text filter applied.
  final String query;
}
```

**Rule**: never add individual `categoryId` / `query` / `skip` / `take` arguments to repository methods. Always pass `MealFilter`.

When a new domain filter is needed (e.g. `UserFilter`), create a new class that extends `RepositoryFilter` in its own `*_repository_model.dart` file.

---

## `MealRepository` — `lib/core/repositories/meal/meal_repository.dart`

Abstract interface only. No implementation in this file.

```dart
abstract interface class MealRepository {
  /// Returns all available categories.
  Future<List<Category>> getCategories();

  /// Returns trending meals (high rate, currently popular).
  Future<List<Meal>> getTrending(MealFilter filter);

  /// Returns recently added meals.
  Future<List<Meal>> getRecent(MealFilter filter);

  /// Returns the most popular meals (community rating).
  Future<List<Meal>> getPopular(MealFilter filter);

  /// Returns a single meal by ID. Throws if not found.
  Future<Meal> getMealById(String id);
}
```

**Favorites are NOT here** — they are owned exclusively by `FavoritesRepository`.

---

## `FavoritesRepository` — `lib/core/repositories/favorites/favorites_repository.dart`

Abstract interface only. No implementation in this file.

Authentication is handled transparently via Dio interceptor — the token is never passed as a parameter.

```dart
abstract interface class FavoritesRepository {
  /// GET /favorites — returns the authenticated user's saved meals, filtered.
  Future<List<Meal>> getFavorites(MealFilter filter);

  /// POST /favorites/{mealId}
  Future<void> addFavorite(String mealId);

  /// DELETE /favorites/{mealId}
  Future<void> removeFavorite(String mealId);

  /// Synchronous check against a locally cached list of IDs. No network call.
  bool isFavorite(String mealId, List<String> cachedIds);
}
```

`isFavorite` is synchronous by design. The provider caches the list of IDs after `getFavorites` and uses it for instant UI feedback (e.g. heart icon on a card).

---

## Implementation rules

- The abstract interface and the concrete implementation live in **separate files** within the same domain directory (`meal_repository.dart` and `meal_repository_impl.dart`).
- Method bodies currently use `lib/core/data/dummy_data.dart` as the data source — each method is marked with a `// TODO: replace with <HTTP verb> <endpoint>` comment.
- `lib/core/data/dummy_data.dart` is **auto-generated** by `scripts/generate_dummy_data.py`. Never edit it manually.
- When the backend is ready: replace only the method body. The interface and class signature stay unchanged.
- The concrete class is named `{Domain}RepositoryImpl` (e.g. `MealRepositoryImpl`) — never prefix with `Mock`.
- No artificial delays (`Future.delayed`) in the implementation — async latency comes naturally from real I/O.

---

## Naming conventions

| Element | Pattern | Example |
|---|---|---|
| Domain directory | `{domain}/` | `meal/`, `favorites/` |
| Model file | `{domain}_repository_model.dart` | `meal_repository_model.dart` |
| Abstract file | `{domain}_repository.dart` | `meal_repository.dart` |
| Abstract class | `{Domain}Repository` | `MealRepository` |
| Impl file | `{domain}_repository_impl.dart` | `meal_repository_impl.dart` |
| Impl class | `{Domain}RepositoryImpl` | `MealRepositoryImpl` |

---

## Import group for repositories

When importing a repository in a provider or screen, use the `// Project Repositories` group:

```dart
// Project Repositories
import 'package:sfrigola/core/repositories/meal/meal_repository_model.dart';
import 'package:sfrigola/core/repositories/meal/meal_repository.dart';
import 'package:sfrigola/core/repositories/favorites/favorites_repository.dart';
```

---

## Dependency injection

Repositories are provided to the app via Riverpod providers defined in `lib/core/providers/`. **Never instantiate a repository directly in a widget or screen.**

```dart
// In lib/core/providers/repository_providers.dart
@riverpod
MealRepository mealRepository(Ref ref) => MealRepositoryImpl();

@riverpod
FavoritesRepository favoritesRepository(Ref ref) => FavoritesRepositoryImpl();
```

To switch from dummy data to HTTP: replace only the method bodies inside `MealRepositoryImpl` / `FavoritesRepositoryImpl`. The interface, directory structure, and all consumers remain unchanged.

---

## Error handling

Repositories throw typed exceptions — they do **not** return `null` or raw error strings. The provider layer catches and converts to `AsyncError` via Riverpod's `AsyncNotifier`.

```dart
// Repository throws:
throw MealNotFoundException(id);

// Provider exposes:
AsyncError<List<Meal>>(MealNotFoundException(id), stackTrace)

// UI handles:
ref.watch(trendingMealsProvider).when(
  data: (meals) => ...,
  loading: () => ...,
  error: (e, _) => ...,
);
```

Exception classes live in the domain's `*_repository_model.dart` file (e.g. `MealNotFoundException` in `meal_repository_model.dart`).
