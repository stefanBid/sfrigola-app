// Project Models
import 'package:sfrigola/core/models/be-models/get_response.dart';

abstract interface class UserRepository {
  /// Returns the total number of meals favourited by the current user.
  /// In production: GET /user/favourites/count
  Future<GetDataResponse<int>> getFavouritesCount();

  /// Returns the total number of recipes authored by the current user.
  /// Only meaningful for [UserType.chef] and [UserType.admin] users.
  /// In production: GET /user/recipes/count
  Future<GetDataResponse<int>> getRecipesCount();
}
