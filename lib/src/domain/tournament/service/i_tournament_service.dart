import 'package:ligas_futbol_flutter/src/domain/tournament/dto/config_league/config_league_interface_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/getOpenTournamentsInterface/get_open_tournaments_interface.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/goals_by_tournament/goals_tournament_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/performance_by_tournament/performance_by_tournament.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/scoring_by_tournament/scoring_tournament_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/tournament_by_player/tournament_by_player.dart';

import '../../../core/typedefs.dart';
import '../../countResponse/entity/register_count_interface.dart';
import '../../team_tournament/entity/team_tournament.dart';
import '../dto/config_league/config_league_dto.dart';
import '../dto/tournament_by_team/tournament_by_team_dto.dart';
import '../dto/tournament_champion/tournament_champion_dto.dart';
import '../entity/tournament.dart';

abstract class ITournamentService {
  RepositoryResponse<List<Tournament>> getTournamentByLeagueId(int leagueId,
      {bool requiresAuthToken = true});
  RepositoryResponse<List<ScoringTournamentDTO>> getScoringTournamentId(
      int tournamentId,
      {bool requiresAuthToken = true});
  RepositoryResponse<List<GoalsTournamentDTO>> getGoalsTournamentId(
      int tournamentId,
      {bool requiresAuthToken = true});
  RepositoryResponse<List<TournamentByPlayer>> getTournamentByPlayer(
      int partyId);
  RepositoryResponse<List<PerformanceByTournament>> getPerformanceByPlayer(
      int partyId, int tournamentId);

  ///Get lis a tournaments filtered by category
  ///
  /// * @return [List of Tournament]
  /// * @param [categoryId]
  RepositoryResponse<List<Tournament>> getTournamentsListPresidnt(
      int categoryId);

  ///Get lis a tournaments filtered by category
  ///
  /// * @return [List of Tournament]
  /// * @param [leagueId]
  RepositoryResponse<List<Tournament>> getTournamentsListByLeagePresidnt(
      int leagueId);

  /// Create a tournament
  ///
  /// * @param [Tournament]
  RepositoryResponse<Tournament> createTournamentPresident(
      List<Tournament> tournament);

  /// Update a tournament
  ///
  /// * @param [Tournament]
  RepositoryResponse<Tournament> updateTournamentPresiden(
      Tournament tournament);

  /// Detail a tournament
  ///
  /// * @param [tournamentId]
  RepositoryResponse<Tournament> detailTournamentPresident(int tournamentId);

  ///Obtiene una lista de [Tournament]. Devuelve una lista vacia si ocurre un
  ///error o no encuentra datos.
  RepositoryResponse<List<Tournament>> getHistoricTournaments(int categoryId);

  ///Obtiene un objeto de [Tournament]. Devuelve una lista vacia si ocurre un
  ///error o no encuentra datos.
  RepositoryResponse<Tournament> getCurrentTournament(int categoryId);

  ///Get all tournaments by league
  ///
  /// * @param [leagueId]
  RepositoryResponse<List<Tournament>> getAllTournamentByLeagueId(int leagueId);

  ///Get count tournament by league
  ///
  /// * @param [leagueId]
  RepositoryResponse<ResgisterCountInterface> getCountByLeagueId(int leagueId);

  /// * Get team torunaments
  ///
  /// @param [teamId]
  RepositoryResponse<List<TournamentByTeamDTO>> getTeamTournamentsByTeamId(
      int teamId);

  /// * Get available torunaments by team
  ///
  /// @param [teamId]
  RepositoryResponse<List<GetOpenTournamentsInterface>>
      getAvailableTournamentsByTeamId(int teamId);

  /// * Get tournaments by team
  ///
  /// * @params [teamId, leagueId]
  RepositoryResponse<List<GetOpenTournamentsInterface>>
      getTournamentsByTeamIdAndLeagueId(int teamId, {int? leagueId});

  RepositoryResponse<Tournament> deleteTournamentPresident(int tournamentId);
  RepositoryResponse<Tournament> getFindByNameAndCategory(
      int categoryId, String tournamentName,
      {bool requiresAuthToken = true});

  RepositoryResponse<TournamentChampionDTO> getTournamentChampion(
      int tournamentId,
      {bool requiresAuthToken = true});
  RepositoryResponse<TournamentChampionDTO> tournamentFinished(
      int tournamentId);
  RepositoryResponse<String> getTournamentMatchesStatus(int tournamentId,
      {bool requiresAuthToken = true});

  RepositoryResponse<String> createRoundsConfiguration(ConfigLeagueDTO config);
  RepositoryResponse<String> inscribeLeagueTeams(
      List<TeamTournament> teams, int tournamentId);

  RepositoryResponse<ConfigLeagueInterfaceDTO> getLeagueConfiguration(
      int tournamentId);
}
