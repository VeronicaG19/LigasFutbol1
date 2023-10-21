import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/countResponse/entity/register_count_interface.dart';
import 'package:ligas_futbol_flutter/src/domain/team_tournament/dto/team_tournament_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/team_tournament/entity/team_tournament.dart';
import 'package:ligas_futbol_flutter/src/domain/team_tournament/service/i_team_tournament_service.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/scoring_by_tournament/scoring_tournament_dto.dart';

import '../repository/i_team_tournament_repository.dart';

@LazySingleton(as: ITeamTournamentService)
class TeamTournamentServiceImpl implements ITeamTournamentService {
  final ITeamTournamentRepository _repository;

  TeamTournamentServiceImpl(this._repository);

  @override
  RepositoryResponse<List<TeamTournament>> getTeamTournamentByTournament(
      int tournamentId) {
    return _repository.getTeamTournamentByTournament(tournamentId);
  }

  @override
  RepositoryResponse<List<TeamTournamentDto>> getTournamentTeamDataBytournament(
      int tournamentId) {
    return _repository.getTournamentTeamDataBytournament(tournamentId);
  }

  @override
  RepositoryResponse<TeamTournament> inscribeTeamOnATournament(
      List<TeamTournament> teamTournament) {
    return _repository.inscribeTeamOnATournament(teamTournament);
  }

  @override
  RepositoryResponse<ResgisterCountInterface> getTeamcounTorunament(
      int tournamentId) {
    return _repository.getTeamcounTorunament(tournamentId);
  }

  @override
  RepositoryResponse<TeamTournament> unsubscribeTeamTournament(
      int teamTournamentId) {
    return _repository.unsubscribeTeamTournament(teamTournamentId);
  }

  @override
  RepositoryResponse<List<ScoringTournamentDTO>> getGeneralTableByTournament(
      int tournamentId,
      {bool requiresAuthToken = true}) {
    return _repository.getGeneralTableByTournament(tournamentId,
        requiresAuthToken: requiresAuthToken);
  }

  @override
  RepositoryResponse<List<TeamTournament>> getQualifiedTeams(int tournamentId) {
    return _repository.getQualifiedTeams(tournamentId);
  }
}
