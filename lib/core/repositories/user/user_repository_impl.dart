// Project Models
import 'package:sfrigola/core/models/be-models/get_response.dart';

// Project Repositories
import 'package:sfrigola/core/repositories/user/user_repository.dart';

// Project Utils
import 'package:sfrigola/core/utils/be_simulators.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<GetDataResponse<int>> getFavouritesCount() async {
    // TODO: replace with GET /user/favourites/count
    return BeSimulators.getUserFavouritesCount();
  }

  @override
  Future<GetDataResponse<int>> getRecipesCount() async {
    // TODO: replace with GET /user/recipes/count
    return BeSimulators.getUserRecipesCount();
  }
}

