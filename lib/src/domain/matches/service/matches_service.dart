import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/countResponse/entity/register_count_interface.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/detail_eliminatory_dto/qualifying_match_detail_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/detail_match/detailMatchDTO.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/detail_rol_match_dto/detail_rol_match_DTO.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/edit_match_dto/edit_match_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/end_match/end_match_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/finalize_match_dto/finalize_match_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/match_detail/match_detail_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/match_role_dto/match_role_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/matches_by_player/matches_by_player.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/referee_match.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/start_match/start_match_res_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/entity/match.dart';
import 'package:ligas_futbol_flutter/src/domain/result/dto/result_dto.dart';

import '../../../core/typedefs.dart';
import '../dto/match_team_matches_refree.dart/MatchTeamMatchesRefereeDTO.dart';
import '../interface/matches_by_tournament_interface.dart';
import '../repository/i_matches_repository.dart';
import 'i_matches_service.dart';

@LazySingleton(as: IMatchesService)
class MatchesServiceImpl implements IMatchesService {
  final IMatchesRepository _repository;

  MatchesServiceImpl(this._repository);

  @override
  RepositoryResponse<List<MatchesByTournamentsInterface>>
      getMatchesByTournament(int tournamenId, {bool requiresAuthToken = true}) {
    return _repository.getMatchesByTournament(tournamenId,
        requiresAuthToken: requiresAuthToken);
  }

  @override
  RepositoryResponse<List<DetailMatchDTO>> getDetailMatchByPlayer(int matchId) {
    return _repository.getDetailMatchByPlayer(matchId);
  }

  @override
  RepositoryResponse<List<MatchesByPlayerDTO>> getMatchesByPlayer(
      int personId, int teamId) {
    return _repository.getMatchesByPlayer(personId, teamId);
  }

  @override
  RepositoryResponse<List<MatchesByTournamentsInterface>>
      getListMatchesByTournament(int tournamentId) {
    return _repository.getMatchesByTournament(tournamentId);
  }

  @override
  RepositoryResponse<ResultDTO> createRolesGamesByTournamentId(
      int tournamentId) {
    return _repository.createRolesGamesByTournamentId(tournamentId);
  }

  @override
  RepositoryResponse<List<DeatilRolMatchDTO>> getMatchDetailByTorunamentId(
      int tournamentId, int? roundNumber) {
    return _repository.getMatchDetailByTorunamentId(tournamentId, roundNumber);
  }

  @override
  Future<List<RefereeMatchDTO>> getRefereeMatches(
      {int? leagueId,
      DateTime? matchDate,
      int? refereeId,
      int? tournamentId}) async {
    final request = await _repository.getRefereeMatches(
        leagueId: leagueId,
        date: matchDate,
        refereeId: refereeId,
        tournamentId: tournamentId);
    return request.fold((l) => [], (r) => r);
  }

  @override
  Future<List<RefereeMatchDTO>> getHistoricRefereeMatches(
      {int? leagueId,
      DateTime? matchDate,
      int? refereeId,
      int? tournamentId}) async {
    final request = await _repository.getHistoricRefereeMatches(
        leagueId: leagueId,
        date: matchDate,
        refereeId: refereeId,
        tournamentId: tournamentId);
    return request.fold((l) => [], (r) => r);
  }

  @override
  Future<List<RefereeMatchDTO>> getCalendarRefereeMatches(
      {int? leagueId,
      DateTime? matchDate,
      int? refereeId,
      int? tournamentId}) async {
    final request = await _repository.getCalendarRefereeMatches(
        leagueId: leagueId,
        date: matchDate,
        refereeId: refereeId,
        tournamentId: tournamentId);
    return request.fold((l) => [], (r) => r);
  }

  @override
  RepositoryResponse<List<ResgisterCountInterface>> getRoundNumberAnpending(
      int tournamentId) {
    return _repository.getRoundNumberAnpending(tournamentId);
  }

  @override
  RepositoryResponse<FinalizeMatchDTO> finalizeMatch(
      FinalizeMatchDTO finalizeMatchDTO) {
    return _repository.finalizeMatch(finalizeMatchDTO);
  }

  @override
  RepositoryResponse<EditMatchDTO> editMatchDto(EditMatchDTO editMatchDTO) {
    return _repository.editMatchDto(editMatchDTO);
  }

  @override
  RepositoryResponse<MatchSpr> deleteMatch(int matchId) {
    return _repository.deleteMatch(matchId);
  }

  @override
  RepositoryResponse<ResgisterCountInterface> getNextRound(int tournamentId) {
    return _repository.getNextRound(tournamentId);
  }

  @override
  RepositoryResponse<MatchRoleDTO> createRolesMatchs(
      List<MatchRoleDTO> listMatchRoleDTO) {
    return _repository.createRolesMatchs(listMatchRoleDTO);
  }

  @override
  RepositoryResponse<MatchTeamMatchesRefereeDTO> createRolesClass(
      List<MatchTeamMatchesRefereeDTO> listMatchRoleDTO, int tournamentId) {
    return _repository.createRolesClass(listMatchRoleDTO, tournamentId);
  }

  @override
  RepositoryResponse<StartMatchResDTO> startMatch(int matchId) {
    return _repository.startMatch(matchId);
  }

  @override
  RepositoryResponse<MatchDetailDTO> getMatchDetail(int matchId) {
    return _repository.getMatchDetail(matchId);
  }

  @override
  RepositoryResponse<ResultDTO> endMatch(EndMatchDTO endMatch) {
    return _repository.endMatch(endMatch);
  }

  @override
  RepositoryResponse<String> updateMatchDate(
      DateTime day, DateTime hour, int matchId) {
    return _repository.updateMatchDate(day, hour, matchId);
  }

  @override
  RepositoryResponse<String> updateMatchField(int matchId, int fieldId) {
    return _repository.updateMatchField(matchId, fieldId);
  }

  @override
  RepositoryResponse<String> updateMatchReferee(int matchId, int refereeId) {
    return _repository.updateMatchReferee(matchId, refereeId);
  }

  @override
  RepositoryResponse<QualifyingMatchDetailDTO> getDetailEliminatory(
      int matchId) {
    return _repository.getDetailEliminatory(matchId);
  }

  @override
  RepositoryResponse<MatchSpr> getMatchDetailByEventId(int eventId) {
    return _repository.getMatchDetailByEventId(eventId);
  }
}
