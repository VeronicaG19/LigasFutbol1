import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/lookupvalue/entity/lookupvalue.dart';
import 'package:ligas_futbol_flutter/src/domain/lookupvalue/service/i_lookupvalue_service.dart';

import '../repository/i_lookupvalue_repository.dart';

@LazySingleton(as: ILookUpValueService)
class LookUpValueServiceImpl implements ILookUpValueService {
  final ILookUpValueRepository _repository;

  LookUpValueServiceImpl(this._repository);

  @override
  Future<List<LookUpValue>> getLookUpValueByType(String lookupType) async {
    final response = await _repository.getLookUpValueByType(lookupType);
    return response.fold((l) => [], (r) => r);
  }

  @override
  RepositoryResponse<List<LookUpValue>> getLookUpValueByTypeLM(
      String lookupType) {
    return _repository.getLookUpValueByType(lookupType);
  }

  @override
  RepositoryResponse<List<LookUpValue>> getLookUpValueByTypeAndName(
      String lookupType, String lookupName) {
    return _repository.getLookUpValueByTypeAndName(lookupType, lookupName);
  }
}
