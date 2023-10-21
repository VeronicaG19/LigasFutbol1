import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/detail_match/detailMatchDTO.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/end_match/end_match_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/match_detail/match_detail_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/matches_by_player/matches_by_player.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/start_match/start_match_res_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/result/dto/result_dto.dart';

import '../../countResponse/entity/register_count_interface.dart';
import '../dto/detail_eliminatory_dto/qualifying_match_detail_dto.dart';
import '../dto/detail_rol_match_dto/detail_rol_match_DTO.dart';
import '../dto/edit_match_dto/edit_match_dto.dart';
import '../dto/finalize_match_dto/finalize_match_dto.dart';
import '../dto/match_role_dto/match_role_dto.dart';
import '../dto/match_team_matches_refree.dart/MatchTeamMatchesRefereeDTO.dart';
import '../dto/referee_match.dart';
import '../entity/match.dart';
import '../interface/matches_by_tournament_interface.dart';

abstract class IMatchesRepository {
  RepositoryResponse<List<MatchesByTournamentsInterface>>
      getMatchesByTournament(int tournamenId, {bool requiresAuthToken = true});
  RepositoryResponse<List<MatchesByPlayerDTO>> getMatchesByPlayer(
      int personId, int teamId);
  RepositoryResponse<List<DetailMatchDTO>> getDetailMatchByPlayer(int matchId);

  /// Get list a games roles by tournament
  ///
  /// * @return [list of MatchesByTournamentsInterface]
  /// * @param [tournamentId]
  RepositoryResponse<List<MatchesByTournamentsInterface>>
      getListMatchesByTournament(int tournamentId);

  /// Create a role games by tournament id by automatic form
  ///
  /// * @return [string response]
  /// * @param [tournamentId]
  RepositoryResponse<ResultDTO> createRolesGamesByTournamentId(
      int tournamentId);

  RepositoryResponse<List<RefereeMatchDTO>> getRefereeMatches(
      {int? leagueId, DateTime? date, int? refereeId, int? tournamentId});

  RepositoryResponse<List<RefereeMatchDTO>> getHistoricRefereeMatches(
      {int? leagueId, DateTime? date, int? refereeId, int? tournamentId});

  RepositoryResponse<List<RefereeMatchDTO>> getCalendarRefereeMatches(
      {int? leagueId, DateTime? date, int? refereeId, int? tournamentId});

  /// Get a list of details for a match
  ///
  /// * @return [object of DeatilRolMatchDTO]
  /// * @param [tournamentId]
  RepositoryResponse<List<DeatilRolMatchDTO>> getMatchDetailByTorunamentId(
      int tournamentId, int? roundNumber);

  /// Get a list of rounds number
  ///
  /// * @return [object of ResgisterCountInterface]
  /// * @param [tournamentId]
  RepositoryResponse<List<ResgisterCountInterface>> getRoundNumberAnpending(
      int tournamentId);

  /// Finalize match
  /// * @param [Object of FinalizeMatchDTO]
  ///
  RepositoryResponse<FinalizeMatchDTO> finalizeMatch(
      FinalizeMatchDTO finalizeMatchDTO);

  /// Edit match
  /// * @param [Object of EditMatchDTO]
  ///
  RepositoryResponse<EditMatchDTO> editMatchDto(EditMatchDTO editMatchDTO);

  /// Delete match
  /// * @param [matchId]
  ///
  RepositoryResponse<MatchSpr> deleteMatch(int matchId);

  // getDeleteMatch  getNextRoundNumber

  /// Get next round number
  /// * @param [tournamentId]
  ///
  RepositoryResponse<ResgisterCountInterface> getNextRound(int tournamentId);

  /// Get next round number
  /// * @param [list of MatchRoleDTO]
  ///
  RepositoryResponse<MatchRoleDTO> createRolesMatchs(
      List<MatchRoleDTO> listMatchRoleDTO);

  RepositoryResponse<MatchTeamMatchesRefereeDTO> createRolesClass(
      List<MatchTeamMatchesRefereeDTO> listMatchRoleDTO, int tournamentId);

  ///
  /// ? Save the moment the match started
  /// @param [matchId]
  RepositoryResponse<StartMatchResDTO> startMatch(int matchId);

  ///
  /// ? Get match detail
  /// @param [matchId]
  RepositoryResponse<MatchDetailDTO> getMatchDetail(int matchId);

  ///
  /// ? Get match detail by eventId
  /// @param [eventId]
  RepositoryResponse<MatchSpr> getMatchDetailByEventId(int eventId);

  RepositoryResponse<String> updateMatchDate(
      DateTime day, DateTime hour, int matchId);
  RepositoryResponse<String> updateMatchField(int matchId, int fieldId);
  RepositoryResponse<String> updateMatchReferee(int matchId, int refereeId);

  ///
  /// ? game over
  /// @param [matchId]
  RepositoryResponse<ResultDTO> endMatch(EndMatchDTO endMatch);

  RepositoryResponse<QualifyingMatchDetailDTO> getDetailEliminatory(
      int matchId);
}
