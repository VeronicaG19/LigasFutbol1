import 'package:ligas_futbol_flutter/src/core/typedefs.dart';

import '../entity/league.dart';

abstract class ILeagueRepository {
  RepositoryResponse<List<League>> getAllLeagues(
      {bool requiresAuthToken = true});
  RepositoryResponse<List<League>> getRefereeLeagues(int refereeId);
  RepositoryResponse<League> getLeagueById(int id);
  RepositoryResponse<League> saveLeague(League league);
  RepositoryResponse<League> updateLeague(League league);
  RepositoryResponse<List<League>> getManagerLeagues(int personId);
  RepositoryResponse<String> deleteLeague(int id, bool isForced);
}
