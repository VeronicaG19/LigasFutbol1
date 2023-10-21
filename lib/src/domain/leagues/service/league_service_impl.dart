import 'package:injectable/injectable.dart';

import '../../../core/typedefs.dart';
import '../entity/league.dart';
import '../repository/i_league_repository.dart';
import 'i_league_service.dart';

@LazySingleton(as: ILeagueService)
class LeagueServiceImpl implements ILeagueService {
  final ILeagueRepository _repository;

  LeagueServiceImpl(this._repository);

  @override
  RepositoryResponse<List<League>> getAllLeagues(
      {bool requiresAuthToken = true}) {
    return _repository.getAllLeagues(requiresAuthToken: requiresAuthToken);
  }

  @override
  RepositoryResponse<String> deleteLeague(int id, bool isForced) {
    return _repository.deleteLeague(id, isForced);
  }

  @override
  RepositoryResponse<League> getLeagueById(int id) {
    return _repository.getLeagueById(id);
  }

  @override
  RepositoryResponse<League> saveLeague(League league) {
    return _repository.saveLeague(league);
  }

  @override
  RepositoryResponse<League> updateLeague(League league) {
    return _repository.updateLeague(league);
  }

  @override
  Future<List<League>> getManagerLeagues(int personId) async {
    final request = await _repository.getManagerLeagues(personId);
    return request.fold((l) => [], (r) => r);
  }

  @override
  List<League> filterRequestList(String filter, List<League> leagues) {
    return leagues
        .where((element) =>
            filter.isEmpty ||
            element.leagueName.toLowerCase().contains(filter.toLowerCase()))
        .toList();
  }

  @override
  Future<List<League>> getRefereeLeagues(int refereeId) async {
    final request = await _repository.getRefereeLeagues(refereeId);
    return request.fold((l) => [], (r) => r);
  }
}
