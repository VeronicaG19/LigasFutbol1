import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/field/entity/field.dart';
import 'package:ligas_futbol_flutter/src/domain/field/repositoy/i_field_repository.dart';

import '../../../core/endpoints.dart';
import '../../../core/extensions.dart';

@LazySingleton(as: IFieldRepository)
class FieldRepositoryImpl implements IFieldRepository {
  final ApiClient _apiClient;

  FieldRepositoryImpl(this._apiClient);

  @override
  RepositoryResponse<List<Field>> getFieldsByLeagueId(int leagueId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: '$getFieldByLeaguePresident$leagueId',
            converter: Field.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<Field> createField(Field field) {
    return _apiClient.network
        .postData(
            endpoint: createFieldPresident,
            data: field.toJson(),
            converter: Field.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<Field> getFieldByName(String nameField) {
    return _apiClient.network
        .getData(endpoint: '$getFieldName$nameField', converter: Field.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<Field> getFieldByFieldId(int fieldId) {
    return _apiClient.network
        .getData(endpoint: '$getFieldById$fieldId', converter: Field.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<Field> getFieldByMatchId(int teamId) {
    return _apiClient.network
        .getData(
            endpoint: '$getFieldByMatchIdEndpoint/$teamId',
            converter: Field.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<Field>> getRentalFields() {
    return _apiClient.network
        .getCollectionData(
            endpoint: getRentalFieldsEndpoint, converter: Field.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<Field>> getFieldsRent() {
    return _apiClient.network
        .getCollectionData(
            endpoint: getFieldRentNFEndpoint, converter: Field.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<Field> updateField(Field field) {
    return _apiClient.network
        .updateData(
            endpoint: createFieldPresident,
            data: field.toJson(),
            converter: Field.fromJson)
        .validateResponse();
  }

  @override
  RepositoryResponse<List<Field>> searchFieldByAddress(
      String town,
      String state,
      String postalCOde,
      int matchId,
      DateTime? datematch,
      String county,
      String countryCode,
      String city) {
    final params = <String, dynamic>{};
    params.addAll({
      'city': '',
      'countryCode': '',
      'county': '',
      'datematch': datematch != null
          ? DateFormat('yyy/MM/dd HH:mm:ss').format(datematch)
          : '',
      'postalCOde': '',
      'state': state,
      'town': '',
    });
    return _apiClient.network
        .getCollectionData(
            endpoint: '$getFieldRentEndpoint/$matchId',
            queryParams: params,
            converter: Field.fromJson)
        .validateResponse();
  }
}
