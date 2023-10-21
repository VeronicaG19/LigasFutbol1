import 'package:datasource_client/datasource_client.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/field/entity/field.dart';
import 'package:ligas_futbol_flutter/src/domain/field/repositoy/i_field_repository.dart';

import '../../../core/endpoints.dart';
import '../../../core/extensions.dart';
import '../../../core/models/address_filter.dart';

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
  RepositoryResponse<Field> getFieldByName(nameField) {
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
  RepositoryResponse<Field> getFieldByMatchId(int teamId,
      {bool requiresAuthToken = true}) {
    return _apiClient.network
        .getData(
            requiresAuthToken: requiresAuthToken,
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
  RepositoryResponse<List<Field>> getFieldsRent(int leagueId) {
    return _apiClient.network
        .getCollectionData(
            endpoint: "$getFieldRentNFEndpoint?leagueId=$leagueId",
            converter: Field.fromJson)
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
  RepositoryResponse<List<Field>> searchFieldByFilters(AddressFilter filter) {
    return _apiClient.network
        .getCollectionData(
            endpoint: getFieldRentEndpoint,
            queryParams: filter.toMap(),
            converter: Field.fromJson)
        .validateResponse();
  }
}
