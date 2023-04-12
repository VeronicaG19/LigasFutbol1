import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/result/dto/result_dto.dart';

import '../agenda.dart';
import '../entity/availability.dart';
import '../entity/qra_addresses.dart';
import '../entity/qra_asset.dart';
import '../entity/qra_event.dart';
import '../entity/qra_prices.dart';

abstract class IAgendaRepository {
  RepositoryResponse<List<Availability>> getRefereeAvailability(int refereeId);
  RepositoryResponse<List<Agenda>> getRefereeAgenda(int availabilityId);
  RepositoryResponse<Availability> createAvailability(
      Availability availability);
  RepositoryResponse<QraAsset> createRefereeSchedule(QraAsset qraAsset);
  RepositoryResponse<String> createQraEvents(QraEvent event);
  RepositoryResponse<QraAsset> createQraFieldLeague(QraAsset event);
  RepositoryResponse<List<QraEvent>> getFieldsEvents(int activeId);
  RepositoryResponse<List<QraEvent>> getRefereesEvents(int activeId);
  RepositoryResponse<List<Availability>> getFieldsAvailability(int activeId);

  ///
  ///Get list of prices by on active
  RepositoryResponse<List<QraPrices>> getPricesByActive(int activeId);

  RepositoryResponse<ResultDTO> createPrices(QraPrices qraPrice);

  RepositoryResponse<ResultDTO> deletePrice(int priceId);
  ///
  ///Add addres to active
  RepositoryResponse<QraAddresses> addAdrresAssets(int activeId, QraAddresses qraAddresses);

  ///
  ///update addres to active
  RepositoryResponse<QraAddresses> updateAddresssset(QraAddresses qraAddresses);


  ///
  ///get addres by active
  RepositoryResponse<QraAddresses> getAddressesByActive(int activeId);
}
