import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';

import '../../../core/endpoints.dart';
import '../../../core/extensions.dart';
import '../../../core/typedefs.dart';
import '../entity/league.dart';
import 'i_league_repository.dart';

@LazySingleton(as: ILeagueRepository)
class LeagueRepositoryImpl implements ILeagueRepository {
  final ApiClient _apiClient;

  LeagueRepositoryImpl(this._apiClient);

  @override
  RepositoryResponse<List<League>> getAllLeagues() {
    return _apiClient.network
        .getCollectionData(
            requiresAuthToken: false,
            endpoint: getAllLeaguesEndpoint,
            converter: League.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<void> deleteLeague(int id) {
    return _apiClient.network
        .deleteData(
            endpoint: '$getAllLeaguesEndpoint/$id', converter: League.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<League> getLeagueById(int id) {
    return _apiClient.network
        .getData(
          endpoint: '$getLeagueByIdEndpoint/$id',
          converter: League.fromJson,
        )
        .validateResponse();
  }

  @override
  RepositoryResponse<League> saveLeague(League league) {
    return _apiClient.network
        .postData(
            endpoint: getAllLeaguesEndpoint,
            data: league.toJson(),
            converter: League.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<League> updateLeague(League league) {
    return _apiClient.network
        .updateData(
            endpoint: getAllLeaguesEndpoint,
            data: league.toJson(),
            converter: League.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<League>> getManagerLeagues(int personId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$getManagerLeaguesEndpoint/$personId',
            converter: League.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<League>> getRefereeLeagues(int refereeId) {
    return _apiClient.network.getCollectionData(
        queryParams: {'refereeId': refereeId},
        endpoint: getRefereeLeaguesEndpoint,
        converter: League.fromJson).validateResponse();
  }
}
