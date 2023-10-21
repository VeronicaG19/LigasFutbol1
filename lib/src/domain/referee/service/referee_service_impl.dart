import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/environment_config.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/qra_asset.dart';
import 'package:ligas_futbol_flutter/src/domain/referee/dto/referee_by_address.dart';
import 'package:ligas_futbol_flutter/src/domain/referee/entity/count_tournament_event.dart';
import 'package:ligas_futbol_flutter/src/domain/referee/entity/referee_statics.dart';
import 'package:user_repository/user_repository.dart';

import '../../../core/models/address_filter.dart';
import '../../../core/typedefs.dart';
import '../../agenda/service/i_agenda_service.dart';
import '../dto/create_referee_dto.dart';
import '../entity/rating_referee_dto.dart';
import '../entity/referee.dart';
import '../entity/referee_by_league_dto.dart';
import '../entity/referee_detail_dto.dart';
import '../entity/referee_matches_dto.dart';
import '../repository/i_referee_repository.dart';
import 'i_referee_service.dart';

@LazySingleton(as: IRefereeService)
class RefereeServiceImpl implements IRefereeService {
  final IRefereeRepository _repository;
  final IAgendaService _agendaService;

  const RefereeServiceImpl(this._repository, this._agendaService);

  @override
  RepositoryResponse<Referee> createReferee(
      CreateRefereeDTO referee, User user) async {
    final qraAsset = QraAsset(
        appId: EnvironmentConfig.orgId,
        assignedPrice: 0,
        capacity: 25,
        durationEvents: 0,
        activeId: 0,
        //latitude: r.refereeLatitude,
        //location: referee.refereeAddress ?? '',
        //longitude: r.refereeLength,
        namePerson: user.person.getFullName,
        partyId: user.person.personId ?? 0,
        location: '');
    final assetRequest = await _agendaService.createRefereeSchedule(qraAsset);
    return _repository
        .createReferee(referee.copyWith(activeId: assetRequest.activeId));
  }

  @override
  RepositoryResponse<List<RefereeByLeagueDTO>> getRefereeByLeague(
      int leagueId) async {
    return _repository.getRefereeByLeague(leagueId);
  }

  @override
  Future<List<RefereeByLeagueDTO>> getRefereeByLeague2(int leagueId) async {
    final request = await _repository.getRefereeByLeague(leagueId);
    return request.fold((l) => [], (r) => r);
  }

  @override
  RepositoryResponse<RefereeDetailDTO> getRefereeDetail(int refereeId) async {
    return _repository.getRefereeDetail(refereeId);
  }

  @override
  RepositoryResponse<List<RefereeMatchesDTO>> getRefereeMatches(
      int refereeId) async {
    return _repository.getRefereeMatches(refereeId);
  }

  @override
  RepositoryResponse<RatingRefereeDTO> getRefereeRating(int refereeId) async {
    return _repository.getRefereeRating(refereeId);
  }

  @override
  RepositoryResponse<List<RefereeByLeagueDTO>> getRefereeByLeague1(
      int leagueId) {
    return _repository.getRefereeByLeague(leagueId);
  }

  @override
  RepositoryResponse<List<RefereeByLeagueDTO>> getSearchReferee1(int leagueId) {
    return _repository.getSearchReferee(leagueId);
  }

  @override
  Future<Referee> getRefereeDataByPersonId(
      int personId, String personName) async {
    final request = await _repository.getRefereeDataByPersonId(personId);
    return request.fold((l) => Referee.empty, (r) async {
      if (r.activeId == null || r.activeId == 0) {
        final qraAsset = QraAsset(
            appId: EnvironmentConfig.orgId,
            assignedPrice: 0,
            capacity: 25,
            durationEvents: 0,
            activeId: 0,
            //latitude: r.refereeLatitude,
            location: r.refereeAddress ?? '',
            //longitude: r.refereeLength,
            namePerson: personName,
            partyId: personId);
        final assetRequest =
            await _agendaService.createRefereeSchedule(qraAsset);
        if (assetRequest.isNotEmpty) {
          final referee =
              await updateReferee(r.copyWith(activeId: assetRequest.activeId));
          return referee.fold(
              (rl) => r, (rr) => r.copyWith(activeId: assetRequest.activeId));
        }
      }
      return r;
    });
  }

  @override
  Future<List<RefereeStatics>> getRefereeStatics(
      int personId, int leagueId) async {
    final request = await _repository.getRefereeStatics(personId, leagueId);
    return request.fold((l) => [], (r) => r);
  }

  @override
  Future<List<CountEventTournament>> getTournamentEventCount(
      int refereeId, int leagueId,
      {int? tournamentId}) async {
    final request = await _repository.getTournamentEventCount(
        refereeId, leagueId,
        tournamentId: tournamentId);
    return request.fold((l) => [], (r) => r);
  }

  @override
  RepositoryResponse<String> updateReferee(Referee referee) =>
      _repository.updateReferee(referee);

  @override
  Future<List<RefereeByAddress>> searchByFiltersReferee(
      AddressFilter filter) async {
    final request = await _repository.searchByFiltersReferee(filter);
    return request.fold((l) => [], (r) => r);
  }
}
