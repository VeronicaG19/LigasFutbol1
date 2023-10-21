import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:user_repository/user_repository.dart';

import '../../../core/enums.dart';
import '../dto/request_match_to_referee_dto.dart';
import '../dto/request_to_admin_dto.dart';
import '../dto/request_to_league_dto.dart';
import '../dto/response_request_dto.dart';
import '../entity/field_owner_request.dart';
import '../entity/user_requests.dart';

abstract class IUserRequestsRepository {
  RepositoryResponse<List<UserRequests>> getRequestByStatusAndType(
      int requestMadeById, int requestStatus, int typeRequest);

  RepositoryResponse<List<UserRequests>> getRequestLeagueToAdmin();

  RepositoryResponse<List<UserRequests>> getRequestFieldToAdmin();

  RepositoryResponse<List<UserRequests>> getDeleteLeaguesRequest();

  /// Get reques send to referee from league
  ///
  /// * @param [leagueId, refereeId] `query params`
  RepositoryResponse<List<UserRequests>> getRequestLeagueToReferee(
      {int? leagueId, int? refereeId});

  RepositoryResponse<List<UserRequests>> getRequestPlayerToTeam(
      {int? partyId, int? teamId});

  /// Get reques send to league from referee
  ///
  /// * @param [leagueId, refereeId] `query params`
  RepositoryResponse<List<UserRequests>> getRequestRefereeToLeague(
      {int? leagueId, int? refereeId});

  RepositoryResponse<List<UserRequests>> getRequestTeamToPlayer(
      {int? partyId, int? teamId});
  RepositoryResponse<UserRequests> saveUserRequest(UserRequests request);
  RepositoryResponse<UserRequests> saveRequestTeamToPlayer(
      UserRequests request);
  RepositoryResponse<String> updateUserRequest(int requestId, bool status);
  RepositoryResponse<String> updateAdminUserRequest(int requestId, bool status,
      {String? comment});
  RepositoryResponse<List<UserRequests>> getUserDeleteRequest(int teamId);
  RepositoryResponse<String> cancelUserRequest(int requestId);

  ///Send request to league from referee
  ///
  /// * @param  [RequestToAdmonDTO]
  /// * @return [ResponseRequestDTO]
  RepositoryResponse<ResponseRequestDTO> sendRequestToLeague(
      RequestToAdmonDTO request);

  RepositoryResponse<UserRequests> sendRefereeRequest(UserRequests request);

  RepositoryResponse<UserRequests> sendLeagueRefereeRequest(
      UserRequests request);

  RepositoryResponse<String> sendNewRefereeRequest(UserRequests request);

  /// ? Send team request to register for the tournament
  ///
  /// @params [request]
  RepositoryResponse<ResponseRequestDTO> sendTournamentRegistrationRequest(
      ResponseRequestDTO request);

  /// ? get all tournaments invitations by team
  ///
  /// @params [teamId]
  RepositoryResponse<List<UserRequests>> getAllTournamentsInvitations(
      int teamId);

  /// ? send response to tournament invitation
  ///
  /// @params [requestId, accepted]
  RepositoryResponse<String> sendResponseToTournament(
      int requestId, bool accepted);

  RepositoryResponse<List<UserRequests>> getRequestsTeamToLeague(
      {int? leagueId, int? teamId});

  RepositoryResponse<List<UserRequests>> getRequestTeamToTournament(
      {int? leagueId, int? teamId});

  RepositoryResponse<List<UserRequests>> getRequestTournamentToTeam(
      {int? leagueId, int? teamId});

  RepositoryResponse<int> getRequestCount(int requestTo,
      {RequestType? type, ApplicationRol? rol});

  RepositoryResponse<int> getRequestCountFiltered(
      int partyId, RequestType requestType);

  RepositoryResponse<RequestToLeagueDTO> sendRequestNewTeam(
      RequestToLeagueDTO request);

  RepositoryResponse<UserRequests> sendRequestToFieldOwner(
      RequestToAdmonDTO request);

  RepositoryResponse<List<FieldOwnerRequest>> getFieldOwnerRequests(
      final int ownerId);

  RepositoryResponse<String> acceptFieldOwnerRequest(final int requestId,
      {final String? comment});

  RepositoryResponse<List<RequestMatchToRefereeDTO>> getRequestMatchToReferee(
      int refereeId);

  RepositoryResponse<String> sendRefereeResponseRequest(
      int requestId, bool accepted);

  RepositoryResponse<UserRequests> patchUserRequest(UserRequests request);
  RepositoryResponse<UserRequests> postUserRequest(UserRequests request);
}
