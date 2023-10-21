import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/extensions.dart';
import 'package:ligas_futbol_flutter/src/domain/referee/dto/referee_by_address.dart';
import 'package:ligas_futbol_flutter/src/domain/referee/entity/count_tournament_event.dart';

import '../../../core/endpoints.dart';
import '../../../core/models/address_filter.dart';
import '../../../core/typedefs.dart';
import '../dto/create_referee_dto.dart';
import '../entity/rating_referee_dto.dart';
import '../entity/referee.dart';
import '../entity/referee_by_league_dto.dart';
import '../entity/referee_detail_dto.dart';
import '../entity/referee_matches_dto.dart';
import '../entity/referee_statics.dart';
import 'i_referee_repository.dart';

@LazySingleton(as: IRefereeRepository)
class RefereeRepositoryImpl implements IRefereeRepository {
  final ApiClient _apiClient;
  const RefereeRepositoryImpl(this._apiClient);

  @override
  RepositoryResponse<Referee> createReferee(CreateRefereeDTO referee) {
    return _apiClient.network
        .postData(
            endpoint: refereeEndpoint,
            data: referee.toJson(),
            converter: Referee.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<RefereeByLeagueDTO>> getRefereeByLeague(
      int leagueId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$refereeByLeagueEndpoint/$leagueId',
            converter: RefereeByLeagueDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<RefereeByLeagueDTO>> getSearchReferee(int leagueId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$searchRefereeEndpoint/$leagueId',
            converter: RefereeByLeagueDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<RefereeDetailDTO> getRefereeDetail(int refereeId) {
    return _apiClient.network
        .getData(
            endpoint: '$detailRefereeEndpoint/$refereeId',
            converter: RefereeDetailDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<RefereeMatchesDTO>> getRefereeMatches(int refereeId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$refereeMatchesEndpoint/$refereeId',
            converter: RefereeMatchesDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<RatingRefereeDTO> getRefereeRating(int refereeId) {
    return _apiClient.network
        .getData(
            endpoint: '$ratingByRefereeEndpoint/$refereeId',
            converter: RatingRefereeDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<Referee> getRefereeDataByPersonId(int personId) {
    return _apiClient.network
        .getData(
            endpoint: '$getRefereeDataByPersonIdEndpoint/$personId',
            converter: Referee.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<RefereeStatics>> getRefereeStatics(
      int personId, int leagueId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$getRefereeStaticsEndpoint/$personId/$leagueId',
            converter: RefereeStatics.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<CountEventTournament>> getTournamentEventCount(
      int refereeId, int leagueId,
      {int? tournamentId}) {
    final params = <String, dynamic>{};
    params.addAll({
      'leagueId': leagueId,
      'refereeId': refereeId,
    });
    if (tournamentId != null) {
      params.addAll({'tournamentId': tournamentId});
    }
    return _apiClient.network
        .getCollectionData(
            endpoint: getTournamentEventCountEndpoint,
            queryParams: params,
            converter: CountEventTournament.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<String> updateReferee(Referee referee) {
    return _apiClient.network
        .updateData(
            endpoint: updateRefereeEndpoint,
            data: referee.toJson(),
            converter: (response) => response['result'] as String)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<RefereeByAddress>> searchByFiltersReferee(
      AddressFilter filter) {
    return _apiClient.network
        .getCollectionData(
            endpoint: getRefereeByAddressEndpoint,
            queryParams: filter.toMap(),
            converter: RefereeByAddress.fromJson)
        .validateResponse();
  }
}
