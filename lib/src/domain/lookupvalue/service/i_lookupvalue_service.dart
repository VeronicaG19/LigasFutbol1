import '../../../core/typedefs.dart';
import '../entity/lookupvalue.dart';

abstract class ILookUpValueService {
  ///
  /// Get all lookupvalues filtered by lookupType
  ///
  ///* @param [lookupType]
  ///* @return [list of LookUpValue]
  Future<List<LookUpValue>> getLookUpValueByType(String lookupType);
  RepositoryResponse<List<LookUpValue>> getLookUpValueByTypeLM(
      String lookupType);

  ///
  /// Get all lookupvalues filtered by lookupType and lookupName
  ///
  ///* @param query params [{lookupType, lookupName}]
  ///* @return [list of LookUpValue]
  RepositoryResponse<List<LookUpValue>> getLookUpValueByTypeAndName(
      String lookupType, String lookupName);
}
