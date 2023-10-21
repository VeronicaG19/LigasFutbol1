import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/user_requests/dto/request_match_to_referee_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/user_requests/dto/request_to_league_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/user_requests/entity/field_owner_request.dart';
import 'package:ligas_futbol_flutter/src/domain/user_requests/entity/user_requests.dart';
import 'package:ligas_futbol_flutter/src/domain/user_requests/repository/i_user_requests_repository.dart';
import 'package:user_repository/user_repository.dart';

import '../dto/request_to_admin_dto.dart';
import '../dto/response_request_dto.dart';
import 'i_user_requests_service.dart';

@LazySingleton(as: IUserRequestsService)
class UserRequestsServiceImpl implements IUserRequestsService {
  final IUserRequestsRepository _repository;
  UserRequestsServiceImpl(this._repository);

  @override
  RepositoryResponse<List<UserRequests>> getRequestByStatusAndType(
      int requestMadeById, int requestStatus, int typeRequest) {
    return _repository.getRequestByStatusAndType(
        requestMadeById, requestStatus, typeRequest);
  }

  @override
  RepositoryResponse<List<UserRequests>> getRequestLeagueToAdmin() async {
    return _repository.getRequestLeagueToAdmin();
    //return response.fold((l) => [], (r) => r);
  }

  @override
  Future<List<UserRequests>> getRequestLeagueToReferee(
      {int? leagueId, int? refereeId}) async {
    final response = await _repository.getRequestLeagueToReferee(
        leagueId: leagueId, refereeId: refereeId);
    return response.fold((l) => [], (r) => r);
  }

  @override
  Future<List<UserRequests>> getRequestPlayerToTeam(
      {int? partyId, int? teamId}) async {
    final request = await _repository.getRequestPlayerToTeam(
        partyId: partyId, teamId: teamId);
    return request
        .getOrElse(() => [])
        .where((element) => element.requestStatus == 'Solicitud enviada')
        .toList();
  }

  @override
  Future<List<UserRequests>> getRequestRefereeToLeague(
      {int? leagueId, int? refereeId}) async {
    final response = await _repository.getRequestRefereeToLeague(
        leagueId: leagueId, refereeId: refereeId);
    return response.fold((l) => [], (r) => r);
  }

  @override
  Future<List<UserRequests>> getRequestTeamToPlayer(
      {int? partyId, int? teamId}) async {
    final request = await _repository.getRequestTeamToPlayer(
        partyId: partyId, teamId: teamId);
    return request
        .getOrElse(() => [])
        .where((element) => element.requestStatus == 'Solicitud enviada')
        .toList();
  }

  @override
  RepositoryResponse<UserRequests> saveUserRequest(UserRequests request) {
    return _repository.saveUserRequest(request);
  }

  @override
  RepositoryResponse<UserRequests> saveRequestTeamToPlayer(
      UserRequests request) {
    return _repository.saveRequestTeamToPlayer(request);
  }

  @override
  RepositoryResponse<String> updateUserRequest(int requestId, bool status) {
    return _repository.updateUserRequest(requestId, status);
  }

  @override
  RepositoryResponse<List<UserRequests>> getUserDeleteRequest(int teamId) {
    return _repository.getUserDeleteRequest(teamId);
  }

  @override
  RepositoryResponse<String> cancelUserRequest(int requestId) {
    return _repository.cancelUserRequest(requestId);
  }

  @override
  RepositoryResponse<ResponseRequestDTO> sendRequestToLeague(
      RequestToAdmonDTO request) {
    return _repository.sendRequestToLeague(request);
  }

  @override
  List<UserRequests> filterRequestList(
      String filter, List<UserRequests> requests) {
    return requests
        .where((element) =>
            filter.isEmpty ||
            element.requestMadeBy.toLowerCase().contains(filter.toLowerCase()))
        .toList();
  }

  @override
  RepositoryResponse<UserRequests> sendRefereeRequestToLeague(
      int refereeId, int leagueId) {
    return _repository.sendRefereeRequest(UserRequests(
        requestMadeById: refereeId,
        requestStatus: '3',
        typeRequest: '3',
        requestMadeBy: '',
        requestToId: leagueId,
        comments: '',
        content: '',
        requestId: 0));
  }

  @override
  RepositoryResponse<UserRequests> sendLeagueToRefereeRequest(
      int refereeId, int leagueId) {
    return _repository.sendLeagueRefereeRequest(UserRequests(
        requestMadeById: leagueId,
        requestStatus: '3',
        typeRequest: '4',
        requestMadeBy: '',
        requestToId: refereeId,
        comments: '',
        content: '',
        requestId: 0));
  }

  @override
  RepositoryResponse<String> sendNewRefereeRequestToLeague(
      int refereeId, int leagueId) {
    return _repository.sendNewRefereeRequest(UserRequests(
        requestMadeById: refereeId,
        requestStatus: '3',
        typeRequest: '3',
        requestMadeBy: '',
        requestToId: leagueId,
        comments: '',
        content: '',
        requestId: 0));
  }

  @override
  RepositoryResponse<ResponseRequestDTO> sendTournamentRegistrationRequest(
      int tournamentId, int teamId) {
    return _repository.sendTournamentRegistrationRequest(
        ResponseRequestDTO(requestToId: tournamentId, requestMadeById: teamId));
  }

  @override
  RepositoryResponse<List<UserRequests>> getAllTournamentsInvitations(
      int teamId) {
    return _repository.getAllTournamentsInvitations(teamId);
  }

  @override
  RepositoryResponse<String> sendResponseToTournament(
      int requestId, bool accepted) {
    return _repository.sendResponseToTournament(requestId, accepted);
  }

  @override
  Future<List<UserRequests>> getRequestsTeamToLeague(
      {int? leagueId, int? teamId}) async {
    final request = await _repository.getRequestsTeamToLeague(
        leagueId: leagueId, teamId: teamId);
    return request
        .getOrElse(() => [])
        .where((element) => element.requestStatus == 'Solicitud enviada')
        .toList();
  }

  @override
  RepositoryResponse<String> updateAdminUserRequest(int requestId, bool status,
      {String? comment}) {
    return _repository.updateAdminUserRequest(requestId, status,
        comment: comment);
  }

  @override
  Future<List<UserRequests>> getRequestTeamToTournament(
      {int? leagueId, int? teamId}) async {
    final request = await _repository.getRequestTeamToTournament(
        leagueId: leagueId, teamId: teamId);
    return request
        .getOrElse(() => [])
        .where((element) => element.requestStatus == 'Solicitud enviada')
        .toList();
  }

  @override
  Future<List<UserRequests>> getRequestTournamentToTeam(
      {int? leagueId, int? teamId}) async {
    final request = await _repository.getRequestTournamentToTeam(
        leagueId: leagueId, teamId: teamId);
    return request
        .getOrElse(() => [])
        .where((element) => element.requestStatus == 'Solicitud enviada')
        .toList();
  }

  @override
  Future<int> getRequestCount(int requestTo,
      {RequestType? type, ApplicationRol? rol}) async {
    final request =
        await _repository.getRequestCount(requestTo, type: type, rol: rol);
    return request.getOrElse(() => 0);
  }

  @override
  RepositoryResponse<RequestToLeagueDTO> sendRequestNewTeam(
      RequestToLeagueDTO request) {
    return _repository.sendRequestNewTeam(request);
  }

  @override
  RepositoryResponse<int> getRequestCountFiltered(
      int partyId, RequestType requestType) {
    return _repository.getRequestCountFiltered(partyId, requestType);
  }

  @override
  RepositoryResponse<UserRequests> sendRequestToFieldOwner(
      RequestToAdmonDTO request) {
    return _repository.sendRequestToFieldOwner(request);
  }

  @override
  RepositoryResponse<List<UserRequests>> getRequestFieldToAdmin() {
    return _repository.getRequestFieldToAdmin();
  }

  @override
  RepositoryResponse<String> acceptFieldOwnerRequest(int requestId,
      {String? comment}) {
    return _repository.acceptFieldOwnerRequest(requestId, comment: comment);
  }

  @override
  Future<List<FieldOwnerRequest>> getFieldOwnerRequests(int ownerId) async {
    final request = await _repository.getFieldOwnerRequests(ownerId);
    return request.fold((l) => [], (r) => r);
  }

  @override
  Future<List<RequestMatchToRefereeDTO>> getRequestMatchToReferee(
      int refereeId) async {
    final request = await _repository.getRequestMatchToReferee(refereeId);
    return request.fold((l) => [], (r) => r);
  }

  @override
  RepositoryResponse<String> sendRefereeResponseRequest(
      int requestId, bool accepted) {
    return _repository.sendRefereeResponseRequest(requestId, accepted);
  }

  @override
  RepositoryResponse<UserRequests> patchUserRequest(UserRequests request) {
    return _repository.patchUserRequest(request);
  }

  @override
  RepositoryResponse<UserRequests> postUserRequest(UserRequests request) {
    return _repository.postUserRequest(request);
  }

  @override
  Future<List<UserRequests>> getDeleteLeaguesRequest() => _repository
      .getDeleteLeaguesRequest()
      .then((value) => value.fold((l) => [], (r) => r));
}
