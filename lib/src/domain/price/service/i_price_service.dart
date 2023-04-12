import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import '../dto/all_my_assets/all_my_assets_dto.dart';

abstract class IPriceService{
  RepositoryResponse<List<AllMyAssetsDTO>> getAllMyAssets(int activeId);
  RepositoryResponse<String> createPrice(AllMyAssetsDTO price);
  RepositoryResponse<void> deletePrice(int priceId);
}