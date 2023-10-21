import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:formz/formz.dart';
import 'package:here_repository/here_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/agenda.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/qra_addresses.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/qra_asset.dart';
import 'package:ligas_futbol_flutter/src/domain/field/entity/field.dart';
import 'package:ligas_futbol_flutter/src/domain/field/field_address.dart';
import 'package:ligas_futbol_flutter/src/domain/field/field_image.dart';
import 'package:ligas_futbol_flutter/src/domain/field/field_latitude.dart';
import 'package:ligas_futbol_flutter/src/domain/field/field_length.dart';
import 'package:ligas_futbol_flutter/src/domain/field/field_name.dart';
import 'package:ligas_futbol_flutter/src/domain/field/field_type.dart';
import 'package:ligas_futbol_flutter/src/domain/field/service/i_field_service.dart';
import 'package:ligas_futbol_flutter/src/domain/lookupvalue/entity/lookupvalue.dart';
import 'package:ligas_futbol_flutter/src/domain/lookupvalue/service/i_lookupvalue_service.dart';

part 'field_owner_state.dart';

@injectable
class FieldOwnerCubit extends Cubit<FieldOwnerState> {
  FieldOwnerCubit(this._service, this._lookUpValueService,
      this._apiHereReposiTory, this._agendaService)
      : super(FieldOwnerState());
  final ApiHereReposiTory _apiHereReposiTory;
  final IFieldService _service;
  final IAgendaService _agendaService;

  final ILookUpValueService _lookUpValueService;
  //final _mapController = MapController();
  final TextEditingController _textEditingController = TextEditingController();

  //MapController get getMapController => _mapController;

  TextEditingController get getTextAddresController => _textEditingController;

  Future<void> loadfields({required int leagueId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _service.getFieldsByLeagueId(leagueId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");

      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded,
          fieldtList: r,
          formzStatus: FormzStatus.pure));
    });
  }

  Future<void> detailField({required int fieldId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _service.getFieldByFieldId(fieldId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r}");

      emit(state.copyWith(screenStatus: ScreenStatus.loaded, detailField: r));
      getTypeFields();
    });
  }

  void onFieldNameChange(String value) {
    final fieldName = FieldName.dirty(value);
    emit(state.copyWith(
        fieldName: fieldName,
        formzStatus: Formz.validate([fieldName, state.fieldName])));
  }

  Future<void> onGetAddressse(String text) async {
    emit(state.copyWith(screenStatus: ScreenStatus.addresGeting));
    final response = await _apiHereReposiTory.getAddresssesWithText(text);
    response.fold(
        (l) => debugPrint('response without addres value ${l.message}'), (r) {
      debugPrint('response with addres value');
      emit(state.copyWith(
          apiHereResponseAddresses: r,
          addreses: r.result,
          screenStatus: ScreenStatus.addresGeted));
    });
  }

  void onFieldAddresChange(String value) {
    final fieldAddres = FieldAddres.dirty(value);
    emit(state.copyWith(
        fieldAddres: fieldAddres,
        formzStatus: Formz.validate([fieldAddres, state.fieldAddres])));
  }

  void onUpdateAssetAddres(ReverseHeoApiHere reverseHeoApiHere) {
    emit(state.copyWith(
        qraAddresses: state.qraAddresses.copyWith(
            city: reverseHeoApiHere.items.first.address?.city ?? '',
            postalCode: reverseHeoApiHere.items.first.address?.postalCode ?? '',
            state: reverseHeoApiHere.items.first.address?.stateCode,
            countryCode: reverseHeoApiHere.items.first.address?.countryCode,
            addressLine1:
                '${reverseHeoApiHere.items.first.address!.street} ${reverseHeoApiHere.items.first.address?.houseNumber ?? ''}',
            county: reverseHeoApiHere.items.first.address!.district,
            town: reverseHeoApiHere.items.first.address!.district,
            length: '${reverseHeoApiHere.items.first.position!.lng!}',
            latitude: '${reverseHeoApiHere.items.first.position!.lat}',
            addressName: 'FIELD',
            enabledFlag: 'Y',
            addressType: 'PERSON')));
  }

  void onFieldLatitudeChange(String value) {
    final fieldLatitude = FieldLatitude.dirty(value);
    emit(state.copyWith(
        fieldLatitude: fieldLatitude,
        formzStatus: Formz.validate([fieldLatitude, state.fieldLatitude])));
  }

  void onFieldLengthChange(String value) {
    final fieldLength = FieldLength.dirty(value);
    emit(state.copyWith(
        fieldLength: fieldLength,
        formzStatus: Formz.validate([fieldLength, state.fieldLength])));
  }

  void onFieldTypeChange(LookUpValue value) {
    emit(state.copyWith(
      cteField:
          state.cteField.copyWith(fieldType: value.lookupValue.toString()),
      lookupSelect: value,
    ));
  }

  void onCategoryChange(LookUpValue lookUpValue) {
    emit(state.copyWith(lookupSelect: lookUpValue));
  }

  Future<void> createField(
      {required int? leagueId, required int? partyId}) async {
    bool allFormIsValid;
    emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));
    if (state.fieldName.valid == true && state.fieldAddres.valid == true) {
      allFormIsValid = true;
    } else {
      if (!state.fieldAddres.valid && state.fieldName.valid) {
        emit(state.copyWith(
            formzStatus: FormzStatus.submissionFailure,
            errorMessage: 'Selecciona un punto en el mapa'));
        return;
      }
      allFormIsValid = false;
    }

    emit(state.copyWith(
      fieldName: FieldName.dirty(state.fieldName.value),
      fieldAddres: FieldAddres.dirty(state.fieldAddres.value),
      fieldLatitude: FieldLatitude.dirty(state.fieldLatitude.value),
      fieldLength: FieldLength.dirty(state.fieldLength.value),
      allFormIsValid: allFormIsValid,
      apiHereResponseAddresses: ApiHereResponseAddresses.empty,
      addreses: const [],
    ));

    if (state.allFormIsValid) {
      QraAsset assetData = QraAsset(
          latitude: state.fieldLatitude.value,
          longitude: state.fieldLength.value,
          namePerson: state.fieldName.value,
          location: state.fieldAddres.value,
          appId: 4,
          activeId: 0,
          assignedPrice: 0.0,
          partyId: partyId ?? 0,
          capacity: 0,
          durationEvents: 0);
      final fieldObj = await _agendaService.createQraFieldLeague(assetData);

      fieldObj.fold(
          (l) => emit(state.copyWith(
              screenStatus: ScreenStatus.error,
              errorMessage: l.errorMessage)), (r) async {
        Field field = Field(
            activeId: r.activeId,
            leagueId: leagueId,
            fieldName: state.fieldName.value,
            fieldsAddress: _textEditingController.text,
            fieldsLatitude: state.fieldLatitude.value,
            fieldsLength: state.fieldLength.value,
            fieldType: state.cteField.fieldType ??
                state.lookupSelect.lookupValue.toString(), // fieldType.value,
            sportType: "Soccer" // state.fieldType.value,
            // fieldPhotoId: state.fieldImage.value
            );
        final response = await _service.createField(field);
        response.fold(
            (l) => emit(state.copyWith(
                formzStatus: FormzStatus.submissionFailure,
                errorMessage: l.errorMessage)), (r) async {
          QraAsset assetData = QraAsset(
              latitude: state.fieldLatitude.value,
              longitude: state.fieldLength.value,
              namePerson: state.fieldName.value,
              location: state.fieldAddres.value,
              appId: 4,
              activeId: r.activeId!,
              assignedPrice: 0.0,
              partyId: partyId ?? 0,
              capacity: 0,
              durationEvents: 0);
          state.qraAddresses.copyWith(activeId: assetData);
          final responseAdd = await _agendaService.addAdrresAssets(
              r.activeId!, state.qraAddresses);
          responseAdd.fold((l) => null, (r) => debugPrint('good'));
          print("Datos ${r}");
          _textEditingController.text = '';
          emit(state.copyWith(
              allMarkers: const [],
              formzStatus: FormzStatus.submissionSuccess,
              detailField: r));
          loadfields(leagueId: leagueId!);
        });
      });
    } else {
      //_textEditingController.text = '';
      emit(state.copyWith(
          fieldName: FieldName.dirty(state.fieldName.value),
          fieldAddres: FieldAddres.dirty(state.fieldAddres.value),
          fieldLatitude: FieldLatitude.dirty(state.fieldLatitude.value),
          fieldLength: FieldLength.dirty(state.fieldLength.value),
          allFormIsValid: false,
          formzStatus: FormzStatus.submissionCanceled));
    }
  }

  Future<void> getTypeFields() async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response =
        await _lookUpValueService.getLookUpValueByTypeLM("FIELD_TYPE");
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded,
          lookUpValues: r,
          lookupSelect: r[0]));
    });
  }

  Future<void> onUpdateLatLeng(double lat, double lengt) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    print(lat);
    print(lengt);
    emit(state.copyWith(
        lat: lat, leng: lengt, screenStatus: ScreenStatus.loaded));
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
      onUpdateAssetAddres(r);
      onFieldLengthChange('${latLng.longitude}');
      onFieldLatitudeChange('${latLng.latitude}');
      onFieldAddresChange(r.items.first.address!.label!);
      addMarker(latLng);
    });
  }

  Future<void> onCleanFields() async {
    _textEditingController.text = '';
    emit(state.copyWith(
      fieldName: const FieldName.pure(),
      fieldAddres: const FieldAddres.pure(),
      fieldLatitude: const FieldLatitude.pure(),
      fieldLength: const FieldLength.pure(),
      formzStatus: FormzStatus.pure,
      allFormIsValid: false,
      allMarkers: const [],
    ));
  }
}
