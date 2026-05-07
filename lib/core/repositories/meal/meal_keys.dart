/// Filterable fields for meal list endpoints.
///
/// Used as [TFilter] in [GetRequest<MealFilterKey, MealSortKey>].
/// Extend as new filterable fields are exposed by the backend.
enum MealFilterKey { category, complexity, affordability, rating }

/// Sortable fields for meal list endpoints.
///
/// Used as [TSort] in [GetRequest<MealFilterKey, MealSortKey>].
/// Extend as new sortable fields are exposed by the backend.
enum MealSortKey { name, rating, complexity, affordability }
