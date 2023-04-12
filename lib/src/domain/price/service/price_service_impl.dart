import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/price/dto/all_my_assets/all_my_assets_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/price/repository/i_price_repository.dart';
import 'package:ligas_futbol_flutter/src/domain/price/service/i_price_service.dart';

@LazySingleton(as: IPriceService)
class PriceServiceImpl implements IPriceService{
  final IPriceRepository _repository;

  PriceServiceImpl(this._repository);

  @override
  RepositoryResponse<List<AllMyAssetsDTO>> getAllMyAssets(int activeId) {
    return _repository.getAllMyAssets(activeId);
  }

  @override
  RepositoryResponse<String> createPrice(AllMyAssetsDTO price) {
    return _repository.createPrice(price);
  }

  @override
  RepositoryResponse<void> deletePrice(int priceId) {
    return _repository.deletePrice(priceId);
  }

}