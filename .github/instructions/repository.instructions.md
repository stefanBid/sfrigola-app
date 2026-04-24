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

## `MealFilter`

`MealFilter` lives in `lib/core/repositories/meal/meal_repository_model.dart`. The UI knows `Category` and `query` — it never knows about BE field names or query param formats.

```dart
// lib/core/repositories/meal/meal_repository_model.dart
class MealFilter {
  const MealFilter({this.skip = 0, this.take = 10, this.categoryId, this.query = ''});

  final int skip;
  final int take;

  /// null = no category filter applied.
  final String? categoryId;

  /// Generic search key — BE matches against title and subtitle.
  /// '' = no text filter applied.
  final String query;
}
```

**Rule**: never add individual `categoryId` / `query` / `skip` / `take` arguments to repository methods. Always pass `MealFilter`.

When a new domain filter is needed (e.g. `UserFilter`), create a standalone class in its own `*_repository_model.dart` file — no base class required.

---

## BE response models — `lib/core/models/be-models/`

All repository methods return a **typed BE response wrapper**, never raw domain objects or `void`. This mirrors the contract the real backend will respect when Dio is introduced.

| Class | File | When to use |
|---|---|---|
| `GetDataResponse<T>` | `get_response.dart` | GET that returns a single resource |
| `GetListDataResponse<T>` | `get_response.dart` | GET that returns a paginated list |
| `MutationResponse` | `mutation_response.dart` | POST, PUT, PATCH, DELETE |
| `BeError` | `be_error.dart` | Error shape embedded in any response |

```dart
// get_response.dart
class GetDataResponse<T> {
  final T data;
  final BeError? error;
  GetDataResponse({required this.data, this.error});
}

class GetListDataResponse<T> {
  final List<T> data;
  final int total;
  final BeError? error;
  GetListDataResponse({required this.data, required this.total, this.error});
}

// mutation_response.dart
class MutationResponse {
  final bool success;
  final BeError? error;
  const MutationResponse({required this.success, this.error});
}

// be_error.dart
class BeError {
  final String message;
  final String code;
  const BeError({required this.message, required this.code});
}
```

**Rules:**
- Repository methods always return the **full response** (`GetDataResponse`, `GetListDataResponse`, or `MutationResponse`) — never unwrap `.data` inside the impl.
- The provider layer is responsible for extracting `.data` from the response if needed.
- `error` is always nullable — `null` means success, non-null means the BE returned an error.

---

## `MealRepository` — `lib/core/repositories/meal/meal_repository.dart`

Abstract interface only. No implementation in this file.

```dart
abstract interface class MealRepository {
  /// Returns all available categories.
  Future<GetListDataResponse<Category>> getCategories();

  /// Returns trending meals (high rate, currently popular).
  Future<GetListDataResponse<MealPreview>> getTrending(MealFilter filter);

  /// Returns a single meal by ID. Throws if not found.
  Future<GetDataResponse<Meal>> getMealById(String id);
  // ... other list methods follow the same GetListDataResponse<MealPreview> pattern
}
```

**Favorites are NOT here** — they are owned exclusively by `FavoritesRepository`.

---

## `FavoritesRepository` — `lib/core/repositories/favorites/favorites_repository.dart`

Abstract interface only. No implementation in this file.

Authentication is handled transparently via Dio interceptor — the token is never passed as a parameter.

```dart
abstract interface class FavoritesRepository {
  /// GET /favorites — returns the authenticated user's saved meals, filtered by category.
  Future<GetListDataResponse<Meal>> getFavorites(String? categoryId);

  /// POST /favorites/{mealId}
  Future<MutationResponse> addFavorite(String mealId);

  /// DELETE /favorites/{mealId}
  Future<MutationResponse> removeFavorite(String mealId);

  /// Synchronous check against a locally cached list of IDs. No network call.
  bool isFavorite(String mealId, List<String> cachedIds);
}
```

`isFavorite` is synchronous by design. The provider caches the list of IDs after `getFavorites` and uses it for instant UI feedback (e.g. heart icon on a card).

---

## `BeSimulators` — `lib/core/utils/be_simulators.dart`

`BeSimulators` is a static utility that **owns all mock data logic**. Repositories call `BeSimulators` methods and do nothing else data-related. This cleanly separates two concerns:

| Layer | Responsibility |
|---|---|
| `BeSimulators` | Knows how to build mock data (filtering, sorting, pagination, mapping) |
| `*RepositoryImpl` | Knows how to call `BeSimulators`, check for errors, and return the response |

**Key methods:**

| Method | Returns |
|---|---|
| `getCategories({simulateError})` | `Future<GetListDataResponse<Category>>` |
| `getTrending({categoryId, skip, take, simulateError})` | `Future<GetListDataResponse<MealPreview>>` |
| `getAllMeals({searchKey, skip, take, simulateError})` | `Future<GetListDataResponse<MealPreview>>` |
| `getMealById(id, {simulateError})` | `Future<GetDataResponse<Meal>>` |
| `getFavorites(List<String> ids, {categoryId, simulateError})` | `Future<GetListDataResponse<Meal>>` |
| `addFavorite({simulateError})` | `Future<MutationResponse>` |
| `removeFavorite({simulateError})` | `Future<MutationResponse>` |
| `voidCall({simulateError})` | `Future<MutationResponse>` (generic mutation helper) |

All methods accept a `simulateError` flag (default `false`) to trigger the error path without touching the repository.

---

## Implementation pattern — `_checkResponse`

Every `*RepositoryImpl` method follows the same three-line pattern:

```dart
static void _checkResponse(BeError? error) {
  if (error != null) throw GeneralException.generic();
}

// Inside a method:
final response = await BeSimulators.getTrending(...);
_checkResponse(response.error);
return response;
```

`_checkResponse` is the **single point** where a BE error is translated into a Dart exception. When the real BE arrives, add a `error.code → typed exception` mapping here — no other file changes.

---

## Implementation rules

- The abstract interface and the concrete implementation live in **separate files** within the same domain directory (`meal_repository.dart` and `meal_repository_impl.dart`).
- Method bodies call `BeSimulators` — each is marked with a `// TODO: replace with <HTTP verb> <endpoint>` comment.
- `lib/core/data/dummy_data.dart` is **auto-generated** by `scripts/generate_dummy_data.py` and is accessed only by `BeSimulators`. Repositories never import `dummy_data.dart` directly.
- When the backend is ready: replace only the `BeSimulators` call with a Dio call. The interface, response types, and all consumers remain unchanged.
- The concrete class is named `{Domain}RepositoryImpl` (e.g. `MealRepositoryImpl`) — never prefix with `Mock`.
- Repositories are **stateless** except for `FavoritesRepositoryImpl`, which holds an in-memory `_favoriteIds` list as a temporary substitute for server-side user state.

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
