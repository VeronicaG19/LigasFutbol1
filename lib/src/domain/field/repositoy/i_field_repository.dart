import 'package:ligas_futbol_flutter/src/domain/field/entity/field.dart';

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
  RepositoryResponse<Field> getFieldByMatchId(int teamId);
  RepositoryResponse<List<Field>> getFieldsRent();
  RepositoryResponse<List<Field>> getRentalFields();
  RepositoryResponse<List<Field>> searchFieldByAddress(
      String town,
      String state,
      String postalCOde,
      int matchId,
      DateTime? datematch,
      String county,
      String countryCode,
      String city);
}
