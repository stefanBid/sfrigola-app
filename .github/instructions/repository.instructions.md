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
    meal_repository.dart          ← abstract interface only
    meal_repository_impl.dart     ← concrete implementation only
  favorites/
    favorites_repository.dart         ← abstract interface only
    favorites_repository_impl.dart    ← concrete implementation only
```

> **Rule**: one subdirectory per repository domain — one abstract file + one implementation file.

> Repository methods that return lists accept a **`GetRequest<TFilter, TSort>`** — never loose parameters. `GetRequest` carries `searchKey`, `skip`, `take`, `filters` and `sort`. The provider layer builds and owns the request object.

---

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

Filter and sort keys are defined in `lib/core/models/meal.dart`:

```dart
enum MealFilterKey { category, complexity, affordability, rating }
enum MealSortKey   { name, rating, complexity, affordability }
```

```dart
abstract interface class MealRepository {
  Future<GetListDataResponse<Category>> getCategories();

  Future<GetListDataResponse<MealPreview>> getTrending(
    GetRequest<MealFilterKey, MealSortKey> request);

  Future<GetListDataResponse<MealPreview>> getEasy(
    GetRequest<MealFilterKey, MealSortKey> request);

  Future<GetListDataResponse<MealPreview>> getChallenge(
    GetRequest<MealFilterKey, MealSortKey> request);

  Future<GetListDataResponse<MealPreview>> getBudget(
    GetRequest<MealFilterKey, MealSortKey> request);

  Future<GetListDataResponse<MealPreview>> getPremium(
    GetRequest<MealFilterKey, MealSortKey> request);

  Future<GetListDataResponse<MealPreview>> getAllMeals(
    GetRequest<MealFilterKey, MealSortKey> request);

  Future<GetDataResponse<Meal>> getMealById(String id);

  Future<MutationResponse> updateMealRating(String mealId, double newRating);
}
```

**Favorites are NOT here** — they are owned exclusively by `FavoritesRepository`.

---

## `FavoritesRepository` — `lib/core/repositories/favorites/favorites_repository.dart`

Abstract interface only. No implementation in this file.

Authentication is handled transparently via Dio interceptor — the token is never passed as a parameter.

```dart
abstract interface class FavoritesRepository {
  /// GET /favorites — returns the user's saved meals, filtered and sorted.
  /// In production: auth token is passed via Dio interceptor — never as a parameter.
  Future<GetListDataResponse<MealPreview>> getFavorites(
    GetRequest<MealFilterKey, MealSortKey> request,
  );

  /// POST /favorites/{mealId}
  Future<MutationResponse> addFavorite(String mealId);

  /// DELETE /favorites/{mealId}
  Future<MutationResponse> removeFavorite(String mealId);
}
```

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
| `getTrending(GetRequest<MealFilterKey, MealSortKey>, {simulateError})` | `Future<GetListDataResponse<MealPreview>>` |
| `getEasy(GetRequest<MealFilterKey, MealSortKey>, {simulateError})` | `Future<GetListDataResponse<MealPreview>>` |
| `getChallenge(GetRequest<MealFilterKey, MealSortKey>, {simulateError})` | `Future<GetListDataResponse<MealPreview>>` |
| `getBudget(GetRequest<MealFilterKey, MealSortKey>, {simulateError})` | `Future<GetListDataResponse<MealPreview>>` |
| `getPremium(GetRequest<MealFilterKey, MealSortKey>, {simulateError})` | `Future<GetListDataResponse<MealPreview>>` |
| `getAllMeals(GetRequest<MealFilterKey, MealSortKey>, {simulateError})` | `Future<GetListDataResponse<MealPreview>>` |
| `getMealById(id, {simulateError})` | `Future<GetDataResponse<Meal>>` |
| `getFavorites(GetRequest<MealFilterKey, MealSortKey>, {simulateError})` | `Future<GetListDataResponse<MealPreview>>` |
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
- Repositories are **stateless**. In-memory mock state (`_favoriteIds`, `_userRatings`) lives in `BeSimulators` as static fields — not in the repository impl.

---

## Naming conventions

| Element | Pattern | Example |
|---|---|---|
| Domain directory | `{domain}/` | `meal/`, `favorites/` |
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
