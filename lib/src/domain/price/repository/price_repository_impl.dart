import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/extensions.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/price/dto/all_my_assets/all_my_assets_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/price/repository/i_price_repository.dart';
import '../../../core/endpoints.dart';

@LazySingleton(as: IPriceRepository)
class PriceRepositoryImpl implements IPriceRepository{
  final ApiClient _apiClient;

  PriceRepositoryImpl(this._apiClient);

  @override
  RepositoryResponse<List<AllMyAssetsDTO>> getAllMyAssets(int activeId) {
    return _apiClient.network.getCollectionData(
        endpoint: "$getAllMyAssetsEndpoint/$activeId",
        converter: AllMyAssetsDTO.fromJson
    ).validateResponse();
  }

  @override
  RepositoryResponse<String> createPrice(AllMyAssetsDTO price) {
    return _apiClient.network.postData(
        endpoint: createPriceEndpoint,
        data: price.toJson(),
        converter: (response) => response['result'] as String
    ).validateResponse();
  }

  @override
  RepositoryResponse<void> deletePrice(int priceId) {
    return _apiClient.network.deleteData(
        endpoint: '$deletePriceEndpoint/$priceId',
        converter: (response) => response['result'] as String
    ).validateResponse();
  }

}