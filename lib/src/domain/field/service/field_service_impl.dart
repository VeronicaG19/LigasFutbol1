import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/typedefs.dart';
import 'package:ligas_futbol_flutter/src/domain/field/entity/field.dart';
import 'package:ligas_futbol_flutter/src/domain/field/service/i_field_service.dart';

import '../../../core/models/address_filter.dart';
import '../repositoy/i_field_repository.dart';

@LazySingleton(as: IFieldService)
class FieldServiceImpl implements IFieldService {
  final IFieldRepository _repository;

  FieldServiceImpl(this._repository);

  @override
  RepositoryResponse<List<Field>> getFieldsByLeagueId(int leagueId) {
    return _repository.getFieldsByLeagueId(leagueId);
  }

  @override
  RepositoryResponse<Field> createField(Field field) {
    return _repository.createField(field);
  }

  @override
  RepositoryResponse<Field> getFieldByName(String nameField) {
    return _repository.getFieldByName(nameField);
  }

  @override
  RepositoryResponse<Field> getFieldByFieldId(int fieldId) {
    return _repository.getFieldByFieldId(fieldId);
  }

  @override
  RepositoryResponse<Field> getFieldByMatchId(int teamId,
      {bool requiresAuthToken = true}) {
    return _repository.getFieldByMatchId(teamId,
        requiresAuthToken: requiresAuthToken);
  }

  @override
  Future<List<Field>> getRentalFields() async {
    final request = await _repository.getRentalFields();
    return request.fold((l) => [], (r) => r);
  }

  @override
  RepositoryResponse<List<Field>> getFieldsRent(int leagueId, int status) {
    return _repository.getFieldsRent(leagueId, status);
  }

  @override
  RepositoryResponse<Field> updateField(Field field) {
    return _repository.updateField(field);
  }

  @override
  Future<List<Field>> searchFieldByFilters(AddressFilter filter) async {
    final request = await _repository.searchFieldByFilters(filter);
    return request.fold((l) => [], (r) => r);
  }
}
