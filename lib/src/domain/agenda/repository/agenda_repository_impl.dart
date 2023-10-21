import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/qra_addresses.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/qra_asset.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/qra_event.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/qra_prices.dart';
import 'package:ligas_futbol_flutter/src/domain/result/dto/result_dto.dart';

import '../../../core/endpoints.dart';
import '../../../core/extensions.dart';
import '../../../core/typedefs.dart';
import '../agenda.dart';
import '../entity/availability.dart';

@LazySingleton(as: IAgendaRepository)
class AgendaRepositoryImpl implements IAgendaRepository {
  final ApiClient _apiClient;

  AgendaRepositoryImpl(this._apiClient);

  @override
  RepositoryResponse<List<Agenda>> getRefereeAgenda(int availabilityId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$getRefereeAgendaEndpoint/$availabilityId',
            converter: Agenda.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<Availability>> getRefereeAvailability(int refereeId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$getRefereeAvailabilityEndpoint/$refereeId',
            converter: Availability.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<Availability> createAvailability(
      Availability availability) {
    return _apiClient.network
        .postData(
            data: availability.toJson(),
            endpoint: createAvailabilityEndpoint,
            converter: Availability.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<QraAsset> createRefereeSchedule(QraAsset qraAsset) {
    return _apiClient.network
        .postData(
            data: qraAsset.toJson(),
            endpoint: createRefereeScheduleEndpoint,
            converter: QraAsset.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<String> createQraEvents(QraEvent event) {
    return _apiClient.network
        .postData(
            data: event.toJson(),
            endpoint: qraEventEndpoint,
            converter: (response) => response['result'] as String)
        .validateResponse();
  }

  @override
  RepositoryResponse<QraAsset> createQraFieldLeague(QraAsset event) {
    return _apiClient.network
        .postData(
            data: event.toJson(),
            endpoint: createQraFieldLeagueEndpoint,
            converter: QraAsset.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<Availability>> getFieldsAvailability(int activeId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$getAvailabilityFieldEndpoint/$activeId',
            converter: Availability.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<QraEvent>> getFieldsEvents(int activeId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$getFieldsEventsEndpoint/$activeId/x',
            converter: QraEvent.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<QraEvent>> getRefereesEvents(int activeId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$getRefereeEventsEndpoint/$activeId',
            converter: QraEvent.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<QraPrices>> getPricesByActive(int activeId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$qraPricesEndpoint/allbyactiveid/$activeId',
            converter: QraPrices.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<ResultDTO> createPrices(QraPrices qraPrice) {
    return _apiClient.network
        .postData(
            data: qraPrice.toJson(),
            endpoint: qraPricesEndpoint,
            converter: ResultDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<ResultDTO> deletePrice(int priceId) {
    return _apiClient.network
        .deleteData(
            endpoint: '$qraDeletePriceEndpoint$priceId',
            converter: ResultDTO.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<QraAddresses> addAdrresAssets(
      int activeId, QraAddresses qraAddresses) {
    return _apiClient.network
        .postData(
            endpoint: '$addressesEndpoint/$activeId',
            data: qraAddresses.toJson(),
            converter: QraAddresses.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<QraAddresses> getAddressesByActive(int activeId) {
    return _apiClient.network
        .getData(
            endpoint: '$addressesEndpoint/get/$activeId',
            converter: QraAddresses.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<QraAddresses> updateAddresssset(
      QraAddresses qraAddresses) {
    return _apiClient.network
        .updateData(
            endpoint: addressesEndpoint,
            data: qraAddresses.toJson(),
            converter: QraAddresses.fromJson)
        .validateResponse();
  }
}
