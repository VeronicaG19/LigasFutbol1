import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/scoring_system/entity/scoring_system.dart';
import 'package:ligas_futbol_flutter/src/domain/scoring_system/service/i_scoring_system_service.dart';

import '../repository/i_scoring_system_repository.dart';

@LazySingleton(as: IScoringSystemService)
class ScoringSystemServiceImpl implements IScoringSystemService {
  final IScoringSystemRepository _repository;

  ScoringSystemServiceImpl(this._repository);

  @override
  RepositoryResponse<ScoringSystem> updateScoringSystem(
      ScoringSystem scoringSystem) {
    return _repository.updateScoringSystem(scoringSystem);
  }

  @override
  RepositoryResponse<ScoringSystem> createScoringSystem(
      ScoringSystem scoringSystem) {
    return _repository.createScoringSystem(scoringSystem);
  }

  @override
  RepositoryResponse<List<ScoringSystem>> getScoringSystemByLeague(
      int leagueId) {
    return _repository.getScoringSystemByLeague(leagueId);
  }

  @override
  RepositoryResponse<ScoringSystem> getScoringSystemByTournament(
      int tournamentId,
      {bool requiresAuthToken = true}) {
    return _repository.getScoringSystemByTournament(tournamentId,
        requiresAuthToken: requiresAuthToken);
  }
}
