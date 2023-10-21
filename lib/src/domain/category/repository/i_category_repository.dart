import 'package:ligas_futbol_flutter/src/core/typedefs.dart';

import '../../countResponse/entity/register_count_interface.dart';
import '../entity/category.dart';
import '../entity/player_statics.dart';

abstract class ICategoryRepository {
  RepositoryResponse<List<Category>> getCategoryByTournamentByAndLeagueId(
      int leagueId, String tournamentName,
      {bool requiresAuthToken = true});

  /// Get all categoris by league id
  RepositoryResponse<List<Category>> getCategoriesByLeagueId(int leagueId);

  /// Create a category
  RepositoryResponse<Category> createCategory(Category category);

  /// Get category by category id
  RepositoryResponse<Category> getCategoryById(int categoryId);

  /// Delete category by category id
  RepositoryResponse<void> deleteCategoryById(int categoryId);

  /// Update a category
  RepositoryResponse<Category> editCategory(Category category);

  RepositoryResponse<List<PlayerStatics>> getPlayerStaticsByCategory(
      int categoryId);

  ///Get count category by league
  ///
  /// * @param [leagueId]
  RepositoryResponse<ResgisterCountInterface> getCountByLeagueId(int leagueId);
}
