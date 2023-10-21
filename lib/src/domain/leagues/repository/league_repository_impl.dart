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
  RepositoryResponse<List<League>> getAllLeagues(
      {bool requiresAuthToken = true}) {
    return _apiClient.network
        .getCollectionData(
            requiresAuthToken: requiresAuthToken,
            endpoint: getAllLeaguesEndpoint,
            converter: League.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<String> deleteLeague(int id, bool isForced) {
    return _apiClient.deleteData(
        endpoint: '$leagueBaseEndpoint/delete/$id/$isForced',
        converter: (response) => response['result'] ?? '');
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
    return _apiClient.fetchCollectionData(
        queryParams: {'refereeId': refereeId},
        endpoint: getRefereeLeaguesEndpoint,
        converter: League.fromJson);
  }
}
