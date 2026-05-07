// Project Data
import 'package:sfrigola/core/data/dummy_data.dart';

// Project Models
import 'package:sfrigola/core/models/be-models/be_error.dart';
import 'package:sfrigola/core/models/be-models/be_filter.dart';
import 'package:sfrigola/core/models/be-models/be_sort.dart';
import 'package:sfrigola/core/models/be-models/get_response.dart';
import 'package:sfrigola/core/models/be-models/get_request.dart';
import 'package:sfrigola/core/models/be-models/mutation_response.dart';
import 'package:sfrigola/core/models/be-models/be_filters.dart';
import 'package:sfrigola/core/models/category.dart';
import 'package:sfrigola/core/models/meal.dart';

// Project Repositories
import 'package:sfrigola/core/repositories/meal/meal_keys.dart';

/// Simulates BE HTTP calls during mock development.
///
/// Each method mirrors a real endpoint — filtering, sorting, pagination and
/// mapping are all performed here, exactly as a server would do.
/// The repository only calls the method and checks [BeError] on the response.
///
/// To test the error path on any endpoint, set [simulateError] to true.
/// Replace each method body with the real Dio call when the BE is ready —
/// the repository contract stays unchanged.
class BeSimulators {
  static const BeError _error = BeError(
    message: 'Simulated BE error',
    code: 'SIMULATED',
  );

  // ---------------------------------------------------------------------------
  // Meal endpoints
  // ---------------------------------------------------------------------------

  /// GET /categories
  static Future<GetListDataResponse<Category>> getCategories({
    Duration delay = const Duration(milliseconds: 500),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    return GetListDataResponse(
      data: availableCategories,
      total: availableCategories.length,
      error: simulateError ? _error : null,
    );
  }

  /// GET /meals/trending
  static Future<GetListDataResponse<MealPreview>> getTrending(
    GetRequest<MealFilterKey, MealSortKey> request, {
    Duration delay = const Duration(milliseconds: 500),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    final base = [...availableMeals]..sort((a, b) => b.rate.compareTo(a.rate));
    return _buildPreviewResponse(base, request, simulateError);
  }

  /// GET /meals?complexity=simple
  static Future<GetListDataResponse<MealPreview>> getEasy(
    GetRequest<MealFilterKey, MealSortKey> request, {
    Duration delay = const Duration(milliseconds: 500),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    final base = availableMeals
        .where((m) => m.complexity == Complexity.simple)
        .toList();
    return _buildPreviewResponse(base, request, simulateError);
  }

  /// GET /meals?complexity=hard
  static Future<GetListDataResponse<MealPreview>> getChallenge(
    GetRequest<MealFilterKey, MealSortKey> request, {
    Duration delay = const Duration(milliseconds: 500),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    final base = availableMeals
        .where((m) => m.complexity == Complexity.hard)
        .toList();
    return _buildPreviewResponse(base, request, simulateError);
  }

  /// GET /meals?affordability=affordable
  static Future<GetListDataResponse<MealPreview>> getBudget(
    GetRequest<MealFilterKey, MealSortKey> request, {
    Duration delay = const Duration(milliseconds: 500),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    final base = availableMeals
        .where((m) => m.affordability == Affordability.affordable)
        .toList();
    return _buildPreviewResponse(base, request, simulateError);
  }

  /// GET /meals?affordability=luxurious
  static Future<GetListDataResponse<MealPreview>> getPremium(
    GetRequest<MealFilterKey, MealSortKey> request, {
    Duration delay = const Duration(milliseconds: 500),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    final base = availableMeals
        .where((m) => m.affordability == Affordability.luxurious)
        .toList();
    return _buildPreviewResponse(base, request, simulateError);
  }

  /// GET /meals
  static Future<GetListDataResponse<MealPreview>> getAllMeals(
    GetRequest<MealFilterKey, MealSortKey> request, {
    Duration delay = const Duration(milliseconds: 500),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    return _buildPreviewResponse(availableMeals, request, simulateError);
  }

  /// GET /meals/{id}
  static Future<GetDataResponse<Meal>> getMealById(
    String id, {
    Duration delay = const Duration(milliseconds: 500),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    final meal = availableMeals.firstWhere((m) => m.id == id);
    final resolved = meal.copyWith(
      isFavourite: _favoriteIds.contains(id),
      userRate: _userRatings[id] ?? meal.userRate,
    );
    return GetDataResponse(
      data: resolved,
      error: simulateError ? _error : null,
    );
  }

  // ---------------------------------------------------------------------------
  // Favorites endpoints
  // ---------------------------------------------------------------------------

  /// In-memory favourite IDs — seeded from [isFavourite] in dummy data.
  /// Mutated by [addFavorite] / [removeFavorite] to mirror server-side state.
  static final List<String> _favoriteIds = availableMeals
      .where((m) => m.isFavourite)
      .map((m) => m.id)
      .toList();

  /// In-memory user ratings — seeded from [userRate] in dummy data.
  /// Mutated by [updateMealRating] to mirror server-side state.
  static final Map<String, double> _userRatings = {
    for (final m in availableMeals)
      if (m.userRate != null) m.id: m.userRate!,
  };

  /// GET /favorites — returns meal previews for the current favourite list, filtered and sorted.
  static Future<GetListDataResponse<MealPreview>> getFavorites({
    Complexity? complexity,
    Affordability? affordability,
    double? minRate,
    double? maxRate,
    SortOrder? sortOrder,
    int skip = 0,
    int take = 10,
    Duration delay = const Duration(milliseconds: 300),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);

    var results = availableMeals.where((m) => _favoriteIds.contains(m.id));

    if (complexity != null) {
      results = results.where((m) => m.complexity == complexity);
    }
    if (affordability != null) {
      results = results.where((m) => m.affordability == affordability);
    }
    if (minRate != null) {
      results = results.where((m) => m.rate >= minRate);
    }
    if (maxRate != null) {
      results = results.where((m) => m.rate <= maxRate);
    }

    final sorted = results.toList();
    if (sortOrder != null) {
      sorted.sort(
        (a, b) => switch (sortOrder) {
          SortOrder.alphabeticalAscending => a.title.compareTo(b.title),
          SortOrder.alphabeticalDescending => b.title.compareTo(a.title),
          SortOrder.rateAscending => a.rate.compareTo(b.rate),
          SortOrder.rateDescending => b.rate.compareTo(a.rate),
          SortOrder.complexityAscending => a.complexity.index.compareTo(
            b.complexity.index,
          ),
          SortOrder.complexityDescending => b.complexity.index.compareTo(
            a.complexity.index,
          ),
          SortOrder.affordabilityAscending => a.affordability.index.compareTo(
            b.affordability.index,
          ),
          SortOrder.affordabilityDescending => b.affordability.index.compareTo(
            a.affordability.index,
          ),
        },
      );
    }

    final paged = sorted.skip(skip).take(take).toList();

    return GetListDataResponse(
      data: paged
          .map(
            (m) => MealPreview(
              id: m.id,
              title: m.title,
              subtitle: m.subtitle,
              imageUrl: m.imageUrl,
              duration: m.duration,
              complexity: m.complexity,
              affordability: m.affordability,
              rate: m.rate,
            ),
          )
          .toList(),
      total: sorted.length,
      error: simulateError ? _error : null,
    );
  }

  /// POST /favorites/{mealId}
  static Future<MutationResponse> addFavorite({
    required String mealId,
    Duration delay = const Duration(milliseconds: 200),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    if (!simulateError && !_favoriteIds.contains(mealId)) {
      _favoriteIds.add(mealId);
    }
    return MutationResponse(
      success: !simulateError,
      error: simulateError ? _error : null,
    );
  }

  /// DELETE /favorites/{mealId}
  static Future<MutationResponse> removeFavorite({
    required String mealId,
    Duration delay = const Duration(milliseconds: 200),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    if (!simulateError) _favoriteIds.remove(mealId);
    return MutationResponse(
      success: !simulateError,
      error: simulateError ? _error : null,
    );
  }

  // ---------------------------------------------------------------------------
  // Generic helpers — for mutations and repositories without dedicated methods
  // ---------------------------------------------------------------------------

  /// Simulates a GET endpoint that returns a list with pagination metadata.
  static Future<GetListDataResponse<T>> getList<T>({
    required List<T> data,
    required int total,
    Duration delay = const Duration(milliseconds: 500),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    return GetListDataResponse(
      data: data,
      total: total,
      error: simulateError ? _error : null,
    );
  }

  /// Simulates a mutation endpoint (POST / PUT / DELETE) with no response body.
  /// Returns a [MutationResponse] with [error] set when [simulateError] is true.
  static Future<MutationResponse> voidCall({
    Duration delay = const Duration(milliseconds: 200),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    return MutationResponse(
      success: !simulateError,
      error: simulateError ? _error : null,
    );
  }

  /// PATCH /meals/{mealId}/rating
  static Future<MutationResponse> updateMealRating({
    required String mealId,
    required double newRating,
    Duration delay = const Duration(milliseconds: 300),
    bool simulateError = false,
  }) async {
    await Future.delayed(delay);
    if (!simulateError) {
      _userRatings[mealId] = newRating;
    }
    return MutationResponse(
      success: !simulateError,
      error: simulateError ? _error : null,
    );
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  /// Applies [request] filters, text search, sort and pagination to [meals].
  ///
  /// [meals] must already be base-filtered by the calling endpoint
  /// (e.g. complexity == simple for getEasy) and base-sorted when relevant
  /// (e.g. by rate desc for getTrending). [request.sort] overrides the base
  /// sort when set.
  static GetListDataResponse<MealPreview> _buildPreviewResponse(
    List<Meal> meals,
    GetRequest<MealFilterKey, MealSortKey> request,
    bool simulateError,
  ) {
    var filtered = List<Meal>.from(meals);

    // Apply FilterGroups — conditions in a group are OR; groups are AND
    for (final group in request.filters) {
      filtered = filtered
          .where((m) => group.conditions.any((c) => _matchesCondition(m, c)))
          .toList();
    }

    // Apply text search
    if (request.searchKey?.isNotEmpty ?? false) {
      final key = request.searchKey!.toLowerCase();
      filtered = filtered
          .where((m) => m.title.toLowerCase().contains(key))
          .toList();
    }

    // Apply sort — overrides endpoint's default sort when set
    if (request.sort != null) {
      filtered.sort((a, b) => _compareMealBy(a, b, request.sort!));
    }

    final total = filtered.length;
    final paged = filtered
        .skip(request.skip)
        .take(request.take)
        .map((m) => MealPreview.fromJson(m.toJson()))
        .toList();

    return GetListDataResponse(
      data: paged,
      total: total,
      error: simulateError ? _error : null,
    );
  }

  static bool _matchesCondition(
    Meal meal,
    FilterCondition<MealFilterKey> condition,
  ) {
    return switch (condition.key) {
      MealFilterKey.category => switch (condition.comparator) {
        FilterOperator.equals => meal.categories.contains(
          condition.value as String,
        ),
        _ => true,
      },
      MealFilterKey.complexity => switch (condition.comparator) {
        FilterOperator.equals =>
          meal.complexity.index == (condition.value as int),
        _ => true,
      },
      MealFilterKey.affordability => switch (condition.comparator) {
        FilterOperator.equals =>
          meal.affordability.index == (condition.value as int),
        _ => true,
      },
      MealFilterKey.rating => switch (condition.comparator) {
        FilterOperator.greaterThanOrEquals =>
          meal.rate >= (condition.value as double),
        FilterOperator.lessThanOrEquals =>
          meal.rate <= (condition.value as double),
        FilterOperator.greaterThan => meal.rate > (condition.value as double),
        FilterOperator.lessThan => meal.rate < (condition.value as double),
        FilterOperator.equals => meal.rate == (condition.value as double),
        _ => true,
      },
    };
  }

  static int _compareMealBy(Meal a, Meal b, SortParam<MealSortKey> sort) {
    final cmp = switch (sort.key) {
      MealSortKey.name => a.title.compareTo(b.title),
      MealSortKey.rating => a.rate.compareTo(b.rate),
      MealSortKey.complexity => a.complexity.index.compareTo(
        b.complexity.index,
      ),
      MealSortKey.affordability => a.affordability.index.compareTo(
        b.affordability.index,
      ),
    };
    return sort.direction == SortDirection.desc ? -cmp : cmp;
  }
}
