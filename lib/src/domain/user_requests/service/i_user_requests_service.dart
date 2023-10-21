import 'package:user_repository/user_repository.dart';

import '../../../core/enums.dart';
import '../../../core/typedefs.dart';
import '../dto/request_match_to_referee_dto.dart';
import '../dto/request_to_admin_dto.dart';
import '../dto/request_to_league_dto.dart';
import '../dto/response_request_dto.dart';
import '../entity/field_owner_request.dart';
import '../entity/user_requests.dart';

abstract class IUserRequestsService {
  RepositoryResponse<List<UserRequests>> getRequestByStatusAndType(
      int requestMadeById, int requestStatus, int typeRequest);
  RepositoryResponse<List<UserRequests>> getRequestLeagueToAdmin();

  RepositoryResponse<List<UserRequests>> getRequestFieldToAdmin();

  Future<List<UserRequests>> getRequestLeagueToReferee(
      {int? leagueId, int? refereeId});
  Future<List<UserRequests>> getRequestPlayerToTeam(
      {int? partyId, int? teamId});
  Future<List<UserRequests>> getRequestRefereeToLeague(
      {int? leagueId, int? refereeId});
  Future<List<UserRequests>> getRequestTeamToPlayer(
      {int? partyId, int? teamId});
  RepositoryResponse<UserRequests> saveUserRequest(UserRequests request);
  RepositoryResponse<UserRequests> saveRequestTeamToPlayer(
      UserRequests request);
  RepositoryResponse<String> updateUserRequest(int requestId, bool status);
  RepositoryResponse<String> updateAdminUserRequest(int requestId, bool status,
      {String? comment});
  RepositoryResponse<List<UserRequests>> getUserDeleteRequest(int teamId);
  RepositoryResponse<String> cancelUserRequest(int requestId);
  List<UserRequests> filterRequestList(
      String filter, List<UserRequests> requests);

  ///Send request to league from referee
  ///
  /// * @param  [RequestToAdmonDTO]
  /// * @return [responseRequestDTO]
  RepositoryResponse<ResponseRequestDTO> sendRequestToLeague(
      RequestToAdmonDTO request);

  RepositoryResponse<UserRequests> sendRefereeRequestToLeague(
      int refereeId, int leagueId);

  RepositoryResponse<UserRequests> sendLeagueToRefereeRequest(
      int refereeId, int leagueId);

  RepositoryResponse<String> sendNewRefereeRequestToLeague(
      int refereeId, int leagueId);

  /// ? send request to tournament
  ///
  /// @param [teamId]
  /// @param [tournamentId]
  RepositoryResponse<ResponseRequestDTO> sendTournamentRegistrationRequest(
      int tournamentId, int teamId);

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

  Future<List<UserRequests>> getRequestsTeamToLeague(
      {int? leagueId, int? teamId});

  Future<List<UserRequests>> getRequestTeamToTournament(
      {int? leagueId, int? teamId});

  Future<List<UserRequests>> getRequestTournamentToTeam(
      {int? leagueId, int? teamId});

  Future<int> getRequestCount(int requestTo,
      {RequestType? type, ApplicationRol? rol});

  RepositoryResponse<int> getRequestCountFiltered(
      int partyId, RequestType requestType);

  RepositoryResponse<RequestToLeagueDTO> sendRequestNewTeam(
      RequestToLeagueDTO request);

  RepositoryResponse<UserRequests> sendRequestToFieldOwner(
      RequestToAdmonDTO request);

  Future<List<FieldOwnerRequest>> getFieldOwnerRequests(final int ownerId);

  RepositoryResponse<String> acceptFieldOwnerRequest(final int requestId,
      {final String? comment});

  Future<List<RequestMatchToRefereeDTO>> getRequestMatchToReferee(
      int refereeId);

  RepositoryResponse<String> sendRefereeResponseRequest(
      int requestId, bool accepted);

  RepositoryResponse<UserRequests> patchUserRequest(UserRequests request);

  RepositoryResponse<UserRequests> postUserRequest(UserRequests request);

  Future<List<UserRequests>> getDeleteLeaguesRequest();
}
