import '../../../core/typedefs.dart';
import '../../countResponse/entity/register_count_interface.dart';
import '../entity/category.dart';
import '../entity/player_statics.dart';

abstract class ICategoryService {
  ///get categorie list filtered by league id an tournament name
  ///
  /// [leagueId] [tournamentName]
  RepositoryResponse<List<Category>> getCategoryByTournamentByAndLeagueId(
      int leagueId, String tournamentName,
      {bool requiresAuthToken = true});

  RepositoryResponse<List<Category>> getCategoriesByLeagueId(int leagueId);

  Future<List<Category>> getCategoriesByLeagueId2(int leagueId);

  ///Create category
  RepositoryResponse<Category> createCategory(Category category);

  ///Geta category detail by [categoryId]
  RepositoryResponse<Category> getCategoryById(int categoryId);

  /// Delete category by [categoryid]
  RepositoryResponse<void> deleteCategoryById(int categoryId);

  /// Update a category
  ///
  /// * @obj [Category]
  RepositoryResponse<Category> editCategory(Category category);

  ///Obtiene una lista de [PlayerStatics]. Devuelve una lista vacia si ocurre un
  ///error o no encuentra datos.
  Future<List<PlayerStatics>> getPlayerStaticsByCategory(int categoryId);

  ///Get count category by league
  ///
  /// * @param [leagueId]
  RepositoryResponse<ResgisterCountInterface> getCountByLeagueId(int leagueId);
}
