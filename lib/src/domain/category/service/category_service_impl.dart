import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/category/entity/player_statics.dart';

import '../../../core/typedefs.dart';
import '../../countResponse/entity/register_count_interface.dart';
import '../entity/category.dart';
import '../repository/i_category_repository.dart';
import 'i_category_service.dart';

@LazySingleton(as: ICategoryService)
class CategoryServiceImpl implements ICategoryService {
  final ICategoryRepository _repository;

  CategoryServiceImpl(this._repository);

  @override
  RepositoryResponse<List<Category>> getCategoryByTournamentByAndLeagueId(
      int leagueId, String tournamentName, {bool requiresAuthToken = true}) {
    return _repository.getCategoryByTournamentByAndLeagueId(
        leagueId, tournamentName, requiresAuthToken: requiresAuthToken);
  }

  @override
  RepositoryResponse<List<Category>> getCategoriesByLeagueId(int leagueId) {
    return _repository.getCategoriesByLeagueId(leagueId);
  }

  @override
  Future<List<Category>> getCategoriesByLeagueId2(int leagueId) async {
    final response = await _repository.getCategoriesByLeagueId(leagueId);
    return response.fold((l) => [], (r) => r);
  }

  @override
  RepositoryResponse<Category> createCategory(Category category) {
    return _repository.createCategory(category);
  }

  @override
  RepositoryResponse<Category> getCategoryById(int categoryId) {
    return _repository.getCategoryById(categoryId);
  }

  @override
  RepositoryResponse<void> deleteCategoryById(int categoryId) {
    return _repository.deleteCategoryById(categoryId);
  }

  @override
  RepositoryResponse<Category> editCategory(Category category) {
    return _repository.editCategory(category);
  }

  @override
  Future<List<PlayerStatics>> getPlayerStaticsByCategory(int categoryId) async {
    final response = await _repository.getPlayerStaticsByCategory(categoryId);
    return response.fold((l) => [], (r) => r);
  }

  @override
  RepositoryResponse<ResgisterCountInterface> getCountByLeagueId(int leagueId) {
    return _repository.getCountByLeagueId(leagueId);
  }
}
