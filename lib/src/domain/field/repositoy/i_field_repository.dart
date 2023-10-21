import 'package:ligas_futbol_flutter/src/domain/field/entity/field.dart';

import '../../../core/models/address_filter.dart';
import '../../../core/typedefs.dart';

abstract class IFieldRepository {
  /// Get all fields by league id
  /// * @return [List of Field]
  /// * @param [leagueId]
  RepositoryResponse<List<Field>> getFieldsByLeagueId(int leagueId);

  /// Create a field
  /// * @return [Field]
  /// * @param [Field]
  RepositoryResponse<Field> createField(Field field);

  /// Update a field
  /// * @return [Field]
  /// * @param [Field]
  RepositoryResponse<Field> updateField(Field field);

  /// Get field by name
  /// *@return [Field]
  /// * @param [nameField]
  RepositoryResponse<Field> getFieldByName(String nameField);

  /// Get field by fieldId
  /// *@return [Field]
  /// * @param [fieldId]
  RepositoryResponse<Field> getFieldByFieldId(int fieldId);
  RepositoryResponse<Field> getFieldByMatchId(int teamId,
      {bool requiresAuthToken = true});
  RepositoryResponse<List<Field>> getFieldsRent(int leagueId);
  RepositoryResponse<List<Field>> getRentalFields();
  RepositoryResponse<List<Field>> searchFieldByFilters(AddressFilter filter);
}
