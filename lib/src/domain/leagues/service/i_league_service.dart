import '../../../core/typedefs.dart';
import '../entity/league.dart';

abstract class ILeagueService {
  RepositoryResponse<List<League>> getAllLeagues();
  RepositoryResponse<League> getLeagueById(int id);
  RepositoryResponse<League> saveLeague(League league);
  RepositoryResponse<League> updateLeague(League league);
  RepositoryResponse<void> deleteLeague(int id);
  Future<List<League>> getManagerLeagues(int personId);
  List<League> filterRequestList(String filter, List<League> leagues);
  Future<List<League>> getRefereeLeagues(int refereeId);
}
