import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/agenda.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/availability.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/qra_addresses.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/qra_asset.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/qra_event.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/qra_prices.dart';
import 'package:ligas_futbol_flutter/src/domain/result/dto/result_dto.dart';

import '../repository/i_agenda_repository.dart';
import 'i_agenda_service.dart';

@LazySingleton(as: IAgendaService)
class LeagueServiceImpl implements IAgendaService {
  final IAgendaRepository _repository;

  LeagueServiceImpl(this._repository);

  @override
  RepositoryResponse<List<Agenda>> getRefereeAgenda(int availabilityId) {
    return _repository.getRefereeAgenda(availabilityId);
  }

  @override
  RepositoryResponse<List<Availability>> getRefereeAvailability(int refereeId) {
    return _repository.getRefereeAvailability(refereeId);
  }

  @override
  RepositoryResponse<Availability> createAvailability(
      Availability availability) {
    return _repository.createAvailability(availability);
  }

  @override
  Future<QraAsset> createRefereeSchedule(QraAsset qraAsset) async {
    final request = await _repository.createRefereeSchedule(qraAsset);
    return request.fold((l) => QraAsset.empty, (r) => r);
  }

  @override
  RepositoryResponse<String> createQraEvents(QraEvent event) {
    return _repository.createQraEvents(event);
  }

  @override
  RepositoryResponse<QraAsset> createQraFieldLeague(QraAsset event) {
    return _repository.createQraFieldLeague(event);
  }

  @override
  RepositoryResponse<List<Availability>> getFieldsAvailability(
      int activeId) async {
    return _repository.getFieldsAvailability(activeId);
  }

  @override
  Future<List<QraEvent>> getFieldsEvents(int activeId) async {
    final request = await _repository.getFieldsEvents(activeId);
    return request.fold((l) => [], (r) => r);
  }

  @override
  Future<List<QraEvent>> getRefereesEvents(int activeId) async {
    final request = await _repository.getRefereesEvents(activeId);
    return request.fold((l) => [], (r) => r);
  }

  @override
  RepositoryResponse<List<QraPrices>> getPricesByActive(int activeId) {
    return _repository.getPricesByActive(activeId);
  }

  @override
  RepositoryResponse<ResultDTO> createPrices(QraPrices qraPrice) {
    return _repository.createPrices(qraPrice);
  }

  @override
  RepositoryResponse<ResultDTO> deletePrice(int priceId) {
    return _repository.deletePrice(priceId);
  }

  @override
  RepositoryResponse<QraAddresses> addAdrresAssets(int activeId, QraAddresses qraAddresses) {
    return _repository.addAdrresAssets(activeId, qraAddresses);
  }

  @override
  RepositoryResponse<QraAddresses> getAddressesByActive(int activeId) {
    return _repository.getAddressesByActive(activeId);
  }

  @override
  RepositoryResponse<QraAddresses> updateAddresssset(QraAddresses qraAddresses) {
    return _repository.updateAddresssset(qraAddresses);
  }
}
