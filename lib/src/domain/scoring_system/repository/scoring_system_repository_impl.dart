import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/extensions.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/scoring_system/entity/scoring_system.dart';

import '../../../core/endpoints.dart';
import 'i_scoring_system_repository.dart';

@LazySingleton(as: IScoringSystemRepository)
class ScoringSystemRepositoryImpl implements IScoringSystemRepository {
  final ApiClient _apiClient;

  ScoringSystemRepositoryImpl(this._apiClient);

  @override
  RepositoryResponse<ScoringSystem> updateScoringSystem(
      ScoringSystem scoringSystem) {
    return _apiClient.network
        .updateData(
            endpoint: updateScoringSystemPresident,
            data: scoringSystem.toJson(),
            converter: ScoringSystem.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<ScoringSystem> createScoringSystem(
      ScoringSystem scoringSystem) {
    return _apiClient.network
        .postData(
            endpoint: createScoringSystemPresident,
            data: scoringSystem.toJson(),
            converter: ScoringSystem.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<ScoringSystem>> getScoringSystemByLeague(
      int leagueId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$getScoringSystemsPresident$leagueId',
            converter: ScoringSystem.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<ScoringSystem> getScoringSystemByTournament(
      int tournamentId,
      {bool requiresAuthToken = true}) {
    return _apiClient.network
        .getData(
            requiresAuthToken: requiresAuthToken,
            endpoint: '$getScoringSystemTournamnetPresident$tournamentId',
            converter: ScoringSystem.fromJson)
        .validateResponse();
  }
}
