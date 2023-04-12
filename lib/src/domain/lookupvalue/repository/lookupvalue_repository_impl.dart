import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/lookupvalue/entity/lookupvalue.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/lookupvalue/repository/i_lookupvalue_repository.dart';
import '../../../core/endpoints.dart';
import '../../../core/extensions.dart';

@LazySingleton(as: ILookUpValueRepository)
class LookUpValueImpl implements ILookUpValueRepository{

  final ApiClient _apiClient;

  LookUpValueImpl(this._apiClient);

  @override
  RepositoryResponse<List<LookUpValue>> getLookUpValueByType(String lookupType) {
      return _apiClient.network.getCollectionData(
        endpoint: '$getLookUpValuesByLookupType$lookupType', 
        converter: LookUpValue.fromJson).validateResponse();
    }
  
    @override
    RepositoryResponse<List<LookUpValue>> getLookUpValueByTypeAndName(String lookupType, String lookupName) {
    return _apiClient.network.getCollectionData(
        endpoint: getLookUpValuesByLookupTypeAndName, 
        queryParams: { 'lookupType':lookupType, 'lookupName':lookupName},
        converter: LookUpValue.fromJson).validateResponse();
  }

}