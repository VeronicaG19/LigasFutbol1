import 'package:ligas_futbol_flutter/src/domain/team_tournament/dto/team_tournament_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/scoring_by_tournament/scoring_tournament_dto.dart';

import '../../../core/typedefs.dart';
import '../../countResponse/entity/register_count_interface.dart';
import '../entity/team_tournament.dart';

abstract class ITeamTournamentService {
  ///Get a list of teams on tournament
  ///
  /// * @param [tournamentId]
  RepositoryResponse<List<TeamTournament>> getTeamTournamentByTournament(
      int tournamentId);

  ///Get a list of teams on tournament
  ///
  /// * @param [tournamentId]
  RepositoryResponse<List<TeamTournamentDto>> getTournamentTeamDataBytournament(
      int tournamentId);

  ///Get a list of teams on tournament
  ///
  /// * @param [tournamentId]
  RepositoryResponse<TeamTournament> inscribeTeamOnATournament(
      List<TeamTournament> teamTournament);

  /// Get a count for teams inscribed in a tournamnet
  ///
  ///* param [tournamentId]
  ///* return a list of ResgisterCountInterface
  RepositoryResponse<ResgisterCountInterface> getTeamcounTorunament(
      int tournamentId);

  /// Unsubscribe team on a tournament
  ///
  ///* param [tournamentId]
  RepositoryResponse<TeamTournament> unsubscribeTeamTournament(
      int teamTournamentId);

  /// get data of general table by tournament
  ///
  ///* param [tournamentId]
  RepositoryResponse<List<ScoringTournamentDTO>> getGeneralTableByTournament(
      int tournamentId,
      {bool requiresAuthToken = true});

  RepositoryResponse<List<TeamTournament>> getQualifiedTeams(int tournamentId);
}
