import '../../../core/typedefs.dart';
import '../entity/field.dart';

abstract class IFieldService {
  /// Get all fields by league id
  RepositoryResponse<List<Field>> getFieldsByLeagueId(int leagueId);

  /// Create a field
  /// * @return [Field]
  /// * @param [Field]
  RepositoryResponse<Field> createField(Field field);

  /// Update a field
  /// * @return [Field]
  /// * @param [Field]
  RepositoryResponse<Field> updateField(Field field);

  /// Get fiel by name
  /// *@return [Field]
  /// * @param [nameField]
  RepositoryResponse<Field> getFieldByName(String nameField);

  /// Get field by fieldId
  /// *@return [Field]
  /// * @param [fieldId]
  RepositoryResponse<Field> getFieldByFieldId(int fieldId);
  RepositoryResponse<Field> getFieldByMatchId(int teamId);
  RepositoryResponse<List<Field>> getFieldsRent();
  Future<List<Field>> getRentalFields();
  Future<List<Field>> searchFieldByAddress(
    int matchId, {
    String? state,
    DateTime? datematch,
  }
      //String town,
      //int postalCOde,
      //String county,
      //int countryCode,
      //String city
      );
}
