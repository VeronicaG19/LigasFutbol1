import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/team_tournament/entity/team_tournament.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/config_league/config_league_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/config_league/config_league_interface_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/getOpenTournamentsInterface/get_open_tournaments_interface.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/goals_by_tournament/goals_tournament_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/performance_by_tournament/performance_by_tournament.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/scoring_by_tournament/scoring_tournament_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/tournament_by_player/tournament_by_player.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/tournament_champion/tournament_champion_dto.dart';

import '../../../core/typedefs.dart';
import '../../countResponse/entity/register_count_interface.dart';
import '../dto/tournament_by_team/tournament_by_team_dto.dart';
import '../entity/tournament.dart';
import '../repository/i_tournament_repository.dart';
import 'i_tournament_service.dart';

@LazySingleton(as: ITournamentService)
class TournamentServiceImpl implements ITournamentService {
  final ITournamentRepository _repository;

  TournamentServiceImpl(this._repository);

  @override
  RepositoryResponse<List<Tournament>> getTournamentByLeagueId(int leagueId,
      {bool requiresAuthToken = true}) {
    return _repository.getTournamentByLeagueId(leagueId,
        requiresAuthToken: requiresAuthToken);
  }

  @override
  RepositoryResponse<List<ScoringTournamentDTO>> getScoringTournamentId(
      int tournamentId,
      {bool requiresAuthToken = true}) {
    return _repository.getScoringTournamentId(tournamentId,
        requiresAuthToken: requiresAuthToken);
  }

  @override
  RepositoryResponse<List<GoalsTournamentDTO>> getGoalsTournamentId(
      int tournamentId,
      {bool requiresAuthToken = true}) {
    return _repository.getGoalsTournamentId(tournamentId,
        requiresAuthToken: requiresAuthToken);
  }

  @override
  RepositoryResponse<List<TournamentByPlayer>> getTournamentByPlayer(
      int partyId) {
    return _repository.getTournamentByPlayer(partyId);
  }

  @override
  RepositoryResponse<List<PerformanceByTournament>> getPerformanceByPlayer(
      int partyId, int tournamentId) {
    return _repository.getPerformanceByPlayer(partyId, tournamentId);
  }

  @override
  RepositoryResponse<List<Tournament>> getTournamentsListPresidnt(
      int categoryId) {
    return _repository.getTournamentsListPresidnt(categoryId);
  }

  @override
  RepositoryResponse<Tournament> createTournamentPresident(
      List<Tournament> tournament) {
    return _repository.createTournamentPresident(tournament);
  }

  @override
  RepositoryResponse<Tournament> updateTournamentPresiden(
      Tournament tournament) {
    return _repository.updateTournamentPresiden(tournament);
  }

  @override
  RepositoryResponse<Tournament> detailTournamentPresident(int tournamentId) {
    return _repository.detailTournamentPresident(tournamentId);
  }

  @override
  RepositoryResponse<List<Tournament>> getHistoricTournaments(
      int categoryId) async {
    return _repository.getHistoricTournaments(categoryId);
  }

  @override
  RepositoryResponse<List<Tournament>> getTournamentsListByLeagePresidnt(
      int leagueId) {
    return _repository.getTournamentsListByLeagePresidnt(leagueId);
  }

  @override
  RepositoryResponse<Tournament> getCurrentTournament(int categoryId) {
    return _repository.getCurrentTournament(categoryId);
  }

  @override
  RepositoryResponse<List<Tournament>> getAllTournamentByLeagueId(
      int leagueId) {
    return _repository.getAllTournamentByLeagueId(leagueId);
  }

  @override
  RepositoryResponse<ResgisterCountInterface> getCountByLeagueId(int leagueId) {
    return _repository.getCountByLeagueId(leagueId);
  }

  @override
  RepositoryResponse<List<TournamentByTeamDTO>> getTeamTournamentsByTeamId(
      int teamId) {
    return _repository.getTeamTournamentsByTeamId(teamId);
  }

  @override
  RepositoryResponse<List<GetOpenTournamentsInterface>>
      getAvailableTournamentsByTeamId(int teamId) {
    return _repository.getAvailableTournamentsByTeamId(teamId);
  }

  @override
  RepositoryResponse<List<GetOpenTournamentsInterface>>
      getTournamentsByTeamIdAndLeagueId(int teamId, {int? leagueId}) {
    return _repository.getTournamentsByTeamIdAndLeagueId(teamId,
        leagueId: leagueId!);
  }

  @override
  RepositoryResponse<Tournament> deleteTournamentPresident(int tournamentId) {
    return _repository.deleteTournamentPresident(tournamentId);
  }

  @override
  RepositoryResponse<Tournament> getFindByNameAndCategory(
      int categoryId, String tournamentName,
      {bool requiresAuthToken = true}) {
    return _repository.getFindByNameAndCategory(categoryId, tournamentName,
        requiresAuthToken: requiresAuthToken);
  }

  @override
  RepositoryResponse<TournamentChampionDTO> getTournamentChampion(
      int tournamentId,
      {bool requiresAuthToken = true}) {
    return _repository.getTournamentChampion(tournamentId,
        requiresAuthToken: requiresAuthToken);
  }

  @override
  RepositoryResponse<String> getTournamentMatchesStatus(int tournamentId,
      {bool requiresAuthToken = true}) {
    return _repository.getTournamentMatchesStatus(tournamentId,
        requiresAuthToken: requiresAuthToken);
  }

  @override
  RepositoryResponse<TournamentChampionDTO> tournamentFinished(
      int tournamentId) {
    return _repository.tournamentFinished(tournamentId);
  }

  @override
  RepositoryResponse<String> createRoundsConfiguration(ConfigLeagueDTO config) {
    return _repository.createRoundsConfiguration(config);
  }

  @override
  RepositoryResponse<String> inscribeLeagueTeams(
      List<TeamTournament> teams, int tournamentId) {
    return _repository.inscribeLeagueTeams(teams, tournamentId);
  }

  @override
  RepositoryResponse<ConfigLeagueInterfaceDTO> getLeagueConfiguration(
      int tournamentId) {
    return _repository.getLeagueConfiguration(tournamentId);
  }
}
