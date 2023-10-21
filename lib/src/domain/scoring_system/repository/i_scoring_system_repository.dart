import 'package:ligas_futbol_flutter/src/core/typedefs.dart';

import '../entity/scoring_system.dart';

abstract class IScoringSystemRepository {
  /// Create a ScoringSystem
  ///
  /// * @return [ScoringSystem]
  /// * @param [Object of ScoringSystem]
  RepositoryResponse<ScoringSystem> createScoringSystem(
      ScoringSystem scoringSystem);

  /// Update a ScoringSystem
  ///
  /// * @return [ScoringSystem]
  /// * @param [Object of ScoringSystem]
  RepositoryResponse<ScoringSystem> updateScoringSystem(
      ScoringSystem scoringSystem);

  /// Get a ScoringSystems by leagueId
  ///
  /// * @return [List of ScoringSystem]
  /// * @param [leagueId]
  RepositoryResponse<List<ScoringSystem>> getScoringSystemByLeague(
      int leagueId);

  /// Get a ScoringSystems by tournament
  ///
  /// * @return [ScoringSystem]
  /// * @param [tournamentId]
  RepositoryResponse<ScoringSystem> getScoringSystemByTournament(
      int tournamentId,
      {bool requiresAuthToken = true});
}
