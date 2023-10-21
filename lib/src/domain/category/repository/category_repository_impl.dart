import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/category/entity/player_statics.dart';

import '../../../core/endpoints.dart';
import '../../../core/extensions.dart';
import '../../../core/typedefs.dart';
import '../../countResponse/entity/register_count_interface.dart';
import '../entity/category.dart';
import 'i_category_repository.dart';

@LazySingleton(as: ICategoryRepository)
class CategoryRepositoryImpl implements ICategoryRepository {
  final ApiClient _apiClient;

  CategoryRepositoryImpl(this._apiClient);

  @override
  RepositoryResponse<List<Category>> getCategoryByTournamentByAndLeagueId(
      int leagueId, tournamentName,
      {bool requiresAuthToken = true}) {
    return _apiClient.network
        .getCollectionData(
            requiresAuthToken: requiresAuthToken,
            converter: Category.fromJson,
            //  queryParams: {'idLeague': leagueId},
            endpoint:
                "$getCategoryByTournamentByAndLeagueIdEndpoint/$leagueId/$tournamentName")
        .validateResponse();
  }

  @override
  RepositoryResponse<List<Category>> getCategoriesByLeagueId(int leagueId) {
    return _apiClient.network
        .getCollectionData(
            converter: Category.fromJson,
            //  queryParams: {'idLeague': leagueId},
            endpoint: "$getCategoryByLeagueIdPresident$leagueId")
        .validateResponse();
  }

  @override
  RepositoryResponse<Category> createCategory(Category category) {
    return _apiClient.network
        .postData(
            endpoint: createCategoryPresident,
            data: category.toJson(),
            converter: Category.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<Category> getCategoryById(int categoryId) {
    return _apiClient.network
        .getData(
            endpoint: '$getCategoryByCategoryIdPresident$categoryId',
            converter: Category.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<void> deleteCategoryById(int categoryId) {
    return _apiClient.network
        .deleteData(
            endpoint: '$deleteCatecoryByIdPresident$categoryId',
            converter: (response) {})
        .validateResponse();
  }

  @override
  RepositoryResponse<Category> editCategory(Category category) {
    return _apiClient.network
        .updateData(
            endpoint: updateCategoryPresident,
            data: category.toJson(),
            converter: Category.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<PlayerStatics>> getPlayerStaticsByCategory(
      int categoryId) {
    return _apiClient.network
        .getCollectionData(
            converter: PlayerStatics.fromJson,
            endpoint: '$staticsPlayerByCategoryEndpoint/$categoryId')
        .validateResponse();
  }

  @override
  RepositoryResponse<ResgisterCountInterface> getCountByLeagueId(int leagueId) {
    return _apiClient.network
        .getData(
            converter: ResgisterCountInterface.fromJson,
            endpoint: createCategoryPresident + "/countCategory/$leagueId")
        .validateResponse();
  }
}
