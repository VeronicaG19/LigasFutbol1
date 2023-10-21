import 'dart:core';

import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/core/extensions.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/user_requests/dto/request_match_to_referee_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/user_requests/dto/request_to_league_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/user_requests/entity/field_owner_request.dart';
import 'package:ligas_futbol_flutter/src/domain/user_requests/entity/user_requests.dart';
import 'package:user_repository/user_repository.dart';

import '../../../core/endpoints.dart';
import '../dto/request_to_admin_dto.dart';
import '../dto/response_request_dto.dart';
import 'i_user_requests_repository.dart';

@LazySingleton(as: IUserRequestsRepository)
class UserRequestsRepositoryImpl implements IUserRequestsRepository {
  final ApiClient _apiClient;

  UserRequestsRepositoryImpl(this._apiClient);

  @override
  RepositoryResponse<List<UserRequests>> getRequestByStatusAndType(
      int requestMadeById, int requestStatus, int typeRequest) {
    return _apiClient.network.getCollectionData(
        queryParams: {
          'requestMadeById': requestMadeById,
          'requestStatus': requestStatus,
          'typeRequest': typeRequest
        },
        endpoint: getRequestByStatusAndTypeEndpoint,
        converter: UserRequests.fromJsonSaveResp).validateResponse();
  }

  @override
  RepositoryResponse<List<UserRequests>> getRequestLeagueToAdmin() {
    return _apiClient.network
        .getCollectionData(
            endpoint: getRequestLeagueToAdminEndpoint,
            converter: UserRequests.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<UserRequests>> getRequestLeagueToReferee(
      {int? leagueId, int? refereeId}) {
    final data = <String, dynamic>{};
    if (leagueId != null) {
      data.addAll({'leagueId': leagueId});
    }
    if (refereeId != null) {
      data.addAll({'partyId': refereeId});
    }
    return _apiClient.network
        .getCollectionData(
            endpoint: getRequestFromReferee,
            queryParams: data,
            converter: UserRequests.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<UserRequests>> getRequestPlayerToTeam(
      {int? partyId, int? teamId}) {
    final data = <String, dynamic>{};
    if (partyId != null) {
      data.addAll({'partyId': partyId});
    }
    if (teamId != null) {
      data.addAll({'teamId': teamId});
    }
    return _apiClient.network
        .getCollectionData(
            queryParams: data,
            endpoint: getRequestPlayerToTeamEndpoint,
            converter: UserRequests.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<UserRequests>> getRequestRefereeToLeague(
      {int? leagueId, int? refereeId}) {
    final data = <String, dynamic>{};
    if (leagueId != null) {
      data.addAll({'leagueId': leagueId});
    }
    if (refereeId != null) {
      data.addAll({'partyId': refereeId});
    }
    return _apiClient.network
        .getCollectionData(
            endpoint: getRequestSendToRefree,
            queryParams: data,
            converter: UserRequests.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<UserRequests>> getRequestTeamToPlayer(
      {int? partyId, int? teamId}) {
    final data = <String, dynamic>{};
    if (partyId != null) {
      data.addAll({'partyId': partyId});
    }
    if (teamId != null) {
      data.addAll({'teamId': teamId});
    }
    return _apiClient.network
        .getCollectionData(
            queryParams: data,
            endpoint: getRequestTeamToPlayerEndpoint,
            converter: UserRequests.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<UserRequests> saveUserRequest(UserRequests request) {
    return _apiClient.network
        .postData(
            data: request.toJsonForSave(),
            endpoint: requestPlayerToTeamEndpoint,
            converter: UserRequests.fromJsonSaveResp)
        .validateResponse();
  }

  @override
  RepositoryResponse<UserRequests> saveRequestTeamToPlayer(
      UserRequests request) {
    return _apiClient.network
        .postData(
            data: request.toJsonForSave(),
            endpoint: requestTeamToPlayerEndpoint,
            converter: UserRequests.fromJsonSaveResp)
        .validateResponse();
  }

  @override
  RepositoryResponse<String> updateUserRequest(int requestId, bool status) {
    return _apiClient.network.updateData(
        data: {},
        endpoint: '$updateRequestEndpoint/$requestId?accepted=$status',
        converter: (result) => result['result'] as String).validateResponse();
  }

  @override
  RepositoryResponse<List<UserRequests>> getUserDeleteRequest(int teamId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: getUserDeleteRequestEndpoint + '?teamId=$teamId',
            converter: UserRequests.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<String> cancelUserRequest(int requestId) {
    return _apiClient.network
        .updateData(
            endpoint: '$cancelRequestEndpoint/$requestId',
            data: {},
            converter: (result) => result['result'] as String)
        .validateResponse();
  }

  @override
  RepositoryResponse<ResponseRequestDTO> sendRequestToLeague(
      RequestToAdmonDTO request) {
    return _apiClient.network
        .postData(
            data: request.toJson(),
            endpoint: getRequestToLeague,
            converter: ResponseRequestDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<UserRequests> sendRefereeRequest(UserRequests request) {
    return _apiClient.network
        .postData(
            data: request.toJsonForReferee(),
            endpoint: sendRequestRefereeToLeagueEndpoint,
            converter: UserRequests.fromJsonSaveResp)
        .validateResponse();
  }

  @override
  RepositoryResponse<UserRequests> sendLeagueRefereeRequest(
      UserRequests request) {
    return _apiClient.network
        .postData(
            data: request.toJsonForReferee(),
            endpoint: sendRequest,
            converter: UserRequests.fromJsonSaveResp)
        .validateResponse();
  }

  @override
  RepositoryResponse<String> sendNewRefereeRequest(UserRequests request) {
    return _apiClient.network
        .postData(
            data: request.toJsonForReferee(),
            endpoint: sendNewRequestRefereeToLeagueEndpoint,
            converter: (result) => result['result'] as String)
        .validateResponse();
  }

  @override
  RepositoryResponse<ResponseRequestDTO> sendTournamentRegistrationRequest(
      ResponseRequestDTO request) {
    return _apiClient.network
        .postData(
            data: request.toJson(),
            endpoint: sendRequestTournamentRegistration,
            converter: ResponseRequestDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<UserRequests>> getAllTournamentsInvitations(
      int teamId) {
    return _apiClient.network
        .getCollectionData(
          converter: UserRequests.fromJson,
          endpoint: "$getTournamentsInvitationsByTeam$teamId",
        )
        .validateResponse();
  }

  @override
  RepositoryResponse<String> sendResponseToTournament(
      int requestId, bool accepted) {
    return _apiClient.network
        .updateData(
            endpoint:
                '$sendResponseToTournamentInvitation$requestId?accepted=$accepted',
            data: {},
            converter: (result) => result['result'] as String)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<UserRequests>> getRequestsTeamToLeague(
      {int? leagueId, int? teamId}) {
    final data = <String, dynamic>{};
    if (leagueId != null) {
      data.addAll({'leagueId': leagueId});
    }
    if (teamId != null) {
      data.addAll({'teamId': teamId});
    }
    return _apiClient.network
        .getCollectionData(
            queryParams: data,
            endpoint: getRequestTeamToLeagueEndpoint,
            converter: UserRequests.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<String> updateAdminUserRequest(int requestId, bool status,
      {String? comment}) {
    final url = '$updateAdminRequestEndpoint/$requestId?accepted=$status';
    return _apiClient.network
        .updateData(
            endpoint: comment == null || comment.trim().isEmpty
                ? url
                : '$url&comment=$comment',
            data: {},
            converter: (result) => result['result'] as String)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<UserRequests>> getRequestTeamToTournament(
      {int? leagueId, int? teamId}) {
    final data = <String, dynamic>{};
    if (leagueId != null) {
      data.addAll({'leagueId': leagueId});
    }
    if (teamId != null) {
      data.addAll({'teamId': teamId});
    }
    return _apiClient.network
        .getCollectionData(
            queryParams: data,
            endpoint: getRequestTeamToTournamentEndpoint,
            converter: UserRequests.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<UserRequests>> getRequestTournamentToTeam(
      {int? leagueId, int? teamId}) {
    final data = <String, dynamic>{};
    if (leagueId != null) {
      data.addAll({'leagueId': leagueId});
    }
    if (teamId != null) {
      data.addAll({'teamId': teamId});
    }
    return _apiClient.network
        .getCollectionData(
            queryParams: data,
            endpoint: getRequestTournamentToTeamEndpoint,
            converter: UserRequests.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<int> getRequestCount(int requestTo,
      {RequestType? type, ApplicationRol? rol}) {
    final data = <String, dynamic>{};
    if (type != null) {
      data.addAll({'requestType': type.name});
    } else if (rol != null) {
      data.addAll({'rol': rol.name});
    }
    return _apiClient.network
        .getData(
            endpoint: '$getNotificationCountEndpoint/$requestTo',
            queryParams: data,
            converter: (response) => int.parse(response['result'] ?? '0'))
        .validateResponse();
  }

  @override
  RepositoryResponse<RequestToLeagueDTO> sendRequestNewTeam(
      RequestToLeagueDTO request) {
    return _apiClient.network
        .postData(
            endpoint: createRequesNewTeamEndpoint,
            data: request.toJson(),
            converter: RequestToLeagueDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<int> getRequestCountFiltered(
      int partyId, RequestType requestType) {
    return _apiClient.network
        .getData(
            endpoint:
                '$getNotificationCountEndpoint/$partyId/${requestType.name}',
            converter: (response) => int.parse(response['result'] ?? '0'))
        .validateResponse();
  }

  @override
  RepositoryResponse<UserRequests> sendRequestToFieldOwner(
      RequestToAdmonDTO request) {
    return _apiClient.network
        .postData(
            endpoint: sendRequestForFieldAdminEndpoint,
            data: request.toJson(),
            converter: UserRequests.fromJsonSaveResp)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<UserRequests>> getRequestFieldToAdmin() {
    //getRequestFieldToAdminEndpoint
    return _apiClient.network
        .getCollectionData(
            endpoint: getRequestFieldToAdminEndpoint,
            converter: UserRequests.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<String> acceptFieldOwnerRequest(final int requestId,
      {String? comment}) {
    return _apiClient.network
        .updateData(
            endpoint:
                '$acceptFieldOwnerRequestEndpoint/$requestId?accepted=true',
            data: {},
            converter: (response) => response['result'] as String)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<FieldOwnerRequest>> getFieldOwnerRequests(
      final int ownerId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$getFieldOwnerRequestEndpoint/$ownerId',
            converter: FieldOwnerRequest.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<RequestMatchToRefereeDTO>> getRequestMatchToReferee(
      int refereeId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$getRequestMatchToRefereeEndpoint/$refereeId',
            converter: RequestMatchToRefereeDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<String> sendRefereeResponseRequest(
      int requestId, bool accepted) {
    return _apiClient.network
        .updateData(
            endpoint:
                '$sendRefereeResponseRequestEndpoint/$requestId?accepted=$accepted',
            data: {},
            converter: (response) => response['result'] as String)
        .validateResponse();
  }

  @override
  RepositoryResponse<UserRequests> patchUserRequest(UserRequests request) {
    return _apiClient.updateData(
        endpoint: requestBaseEndpoint,
        data: request.toJsonForSave(),
        converter: UserRequests.fromJsonSaveResp);
  }

  @override
  RepositoryResponse<UserRequests> postUserRequest(UserRequests request) {
    return _apiClient.postData(
        endpoint: requestBaseEndpoint,
        data: request.toJsonForSave(),
        converter: UserRequests.fromJsonSaveResp);
  }

  @override
  RepositoryResponse<List<UserRequests>> getDeleteLeaguesRequest() =>
      _apiClient.fetchCollectionData(
          endpoint: getDeleteLeaguesRequestsEndpoint,
          converter: UserRequests.fromJson);
}
