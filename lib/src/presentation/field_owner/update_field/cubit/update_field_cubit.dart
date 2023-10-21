import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:here_repository/here_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

import '../../../../domain/agenda/agenda.dart';
import '../../../../domain/agenda/entity/qra_addresses.dart';
import '../../../../domain/field/entity/field.dart';
import '../../../../domain/field/service/i_field_service.dart';
import '../../../../domain/lookupvalue/entity/lookupvalue.dart';

part 'update_field_state.dart';

@injectable
class UpdateFieldCubit extends Cubit<UpdateFieldState> {
  UpdateFieldCubit(this._apiHereReposiTory, this._service, this._agendaService)
      : super(UpdateFieldState());

  final ApiHereReposiTory _apiHereReposiTory;
  final IFieldService _service;
  final IAgendaService _agendaService;

  final _mapController = MapController();
  final TextEditingController _textEditingController = TextEditingController();
  MapController get getMapController => _mapController;

  TextEditingController get getTextAddresController => _textEditingController;

  Future<void> updateField() async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _service.updateField(state.detailField);
    response.fold(
        (l) => emit(state.copyWith(screenStatus: ScreenStatus.loaded)), (r) {
      updateAddresAsset(r);
    });
  }

  Future<void> updateAddresAsset(Field detailField) async {
    final response = await _agendaService.updateAddresssset(state.qraAddresses);
    response.fold(
        (l) => null,
        (r) => emit(state.copyWith(
            detailField: detailField,
            screenStatus: ScreenStatus.updateSucces,
            qraAddresses: r)));
  }

  Future<void> getAddressesDetail(Field field) async {
    final response = await _agendaService.getAddressesByActive(field.activeId!);
    response.fold(
        (l) => emit(state.copyWith(
            detailField: field, screenStatus: ScreenStatus.loaded)),
        (r) => {
              emit(state.copyWith(
                  qraAddresses: r,
                  detailField: field,
                  screenStatus: ScreenStatus.loaded))
            });
  }

  Future<void> onUpdateLatLeng(double lat, double lengt) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    print(lat);
    print(lengt);
    emit(state.copyWith(
        lat: lat, leng: lengt, screenStatus: ScreenStatus.loaded));
  }

  void onFieldNameChange(String value) {
    emit(state.copyWith(
        screenStatus: ScreenStatus.loaded,
        detailField: state.detailField.copyWith(fieldName: value)));
  }

  Future<void> assignFieldData(Field field) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final request = await _service.getFieldByFieldId(field.fieldId ?? 0);
    request.fold(
        (l) => emit(state.copyWith(
            detailField: field, screenStatus: ScreenStatus.loaded)),
        (r) => getAddressesDetail(r));
  }

  void onFieldAddresChange(String value) {
    emit(state.copyWith(
        screenStatus: ScreenStatus.loaded,
        detailField: state.detailField.copyWith(fieldsAddress: value)));
  }

  void onFieldLatitudeChange(String value) {
    emit(state.copyWith(
        detailField: state.detailField.copyWith(fieldsLatitude: value)));
  }

  void onFieldLengthChange(String value) {
    emit(state.copyWith(
        detailField: state.detailField.copyWith(fieldsLength: value)));
  }

  Future<void> onGetAddressse(String text) async {
    emit(state.copyWith(screenStatus: ScreenStatus.addresGeting));
    final response = await _apiHereReposiTory.getAddresssesWithText(text);
    response.fold((l) => null, (r) {
      emit(state.copyWith(
          apiHereResponseAddresses: r,
          addreses: r.result,
          screenStatus: ScreenStatus.addresGeted));
    });
  }

  void onUpdateAssetAddres(ReverseHeoApiHere reverseHeoApiHere) {
    emit(state.copyWith(
        qraAddresses: state.qraAddresses.copyWith(
      city: reverseHeoApiHere.items.first.address!.city!,
      postalCode: reverseHeoApiHere.items.first.address!.postalCode!,
      state: reverseHeoApiHere.items.first.address!.stateCode,
      countryCode: reverseHeoApiHere.items.first.address!.countryCode,
      addressLine1:
          '${reverseHeoApiHere.items.first.address!.street} ${reverseHeoApiHere.items.first.address?.houseNumber ?? ''}',
      county: reverseHeoApiHere.items.first.address!.district,
      town: reverseHeoApiHere.items.first.address!.district,
      length: '${reverseHeoApiHere.items.first.position!.lng!}',
      latitude: '${reverseHeoApiHere.items.first.position!.lat}',
    )));
  }

  Future<void> addMarker(LatLng latLng) async {
    //allMarkers.clear();
    List<Marker> markers = [
      Marker(
        builder: (ctx) => Icon(
          Icons.location_on_rounded,
          color: Colors.red[800],
          size: 60.0,
        ),
        point: latLng,
      )
    ];

    emit(state.copyWith(allMarkers: markers));
  }

  Future<void> addDireccionAndMarket(LatLng latLng) async {
    String latLngthGeo = '${latLng.latitude}%2C${latLng.longitude}';
    final response = await _apiHereReposiTory.getReverseGeoAddres(latLngthGeo);
    response.fold((l) => null, (r) {
      _textEditingController.text = r.items.first.address!.label!;
      onFieldLengthChange('${latLng.longitude}');
      onFieldLatitudeChange('${latLng.latitude}');
      print('adrress: ${r.items.first.address!.label!}');
      onFieldAddresChange(r.items.first.address!.label!);
      onUpdateAssetAddres(r);
      addMarker(latLng);
    });
  }
}
