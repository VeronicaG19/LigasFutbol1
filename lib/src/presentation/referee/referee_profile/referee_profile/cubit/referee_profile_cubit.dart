import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:formz/formz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:here_repository/here_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/referee_profile/referee_profile/view/referee_profile_page.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/validators/simple_text_validator.dart';
import '../../../../../domain/agenda/agenda.dart';
import '../../../../../domain/agenda/entity/qra_addresses.dart';
import '../../../../../domain/agenda/entity/qra_asset.dart';
import '../../../../../domain/referee/entity/referee.dart';
import '../../../../../domain/referee/service/i_referee_service.dart';

part 'referee_profile_state.dart';

@injectable
class RefereeProfileCubit extends Cubit<RefereeProfileState> {
  RefereeProfileCubit(
      this._refereeService, this._agendaService, this._apiHereReposiTory)
      : super(RefereeProfileState());

  final IRefereeService _refereeService;
  final IAgendaService _agendaService;
  final ApiHereReposiTory _apiHereReposiTory;
  double? lat;
  double? long;
  final _mapController = MapController();
  final TextEditingController _textEditingController = TextEditingController();
  MapController get getMapController => _mapController;

  TextEditingController get getTextAddresController => _textEditingController;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final List<PositionItem> _positionItems = <PositionItem>[];
  bool positionStreamStarted = false;
  static const String _kLocationServicesDisabledMessage =
      'Los servicios de ubicación están deshabilitados.';
  static const String _kPermissionDeniedMessage = 'Permiso denegado.';
  static const String _kPermissionDeniedForeverMessage =
      'Permiso denegado para siempre.';
  static const String _kPermissionGrantedMessage = 'Permiso concedido.';
  void onAddressChanged(String value) {
    final address = SimpleTextValidator.dirty(value);
    emit(state.copyWith(
      address: address,
      status: Formz.validate([state.address]),
    ));
  }

  Future<void> onSubmitAddress(Referee referee) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final request = await _refereeService
        .updateReferee(referee.copyWith(refereeAddress: state.address.value));
    request.fold(
        (l) => emit(state.copyWith(status: FormzStatus.submissionFailure)),
        (r) => emit(state.copyWith(status: FormzStatus.submissionSuccess)));
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

  Future<void> updateAddresAsset() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final request = await _refereeService.updateReferee(state.referee);
    request.fold(
        (l) => emit(state.copyWith(status: FormzStatus.submissionFailure)),
        (r) async {
      if (state.qraAddresses.addressId != 0) {
        final response =
            await _agendaService.updateAddresssset(state.qraAddresses);
        response.fold(
            (l) => null,
            (r) => emit(state.copyWith(
                status: FormzStatus.submissionSuccess, qraAddresses: r)));
      } else {
        QraAsset assetData = QraAsset(
          appId: 4,
          activeId: state.referee.activeId!,
          assignedPrice: 0.0,
          partyId: state.referee.partyId ?? 0,
          capacity: 0,
          durationEvents: 0,
          location: '',
          namePerson: '',
        );

        state.qraAddresses.copyWith(activeId: assetData);
        final responseAdd = await _agendaService.addAdrresAssets(
            state.referee.activeId!, state.qraAddresses);
        responseAdd.fold(
            (l) => null,
            (r) => emit(state.copyWith(
                status: FormzStatus.submissionSuccess, qraAddresses: r)));
      }
    });
  }

  Future<void> getAddressesDetail(Referee referee) async {
    final response =
        await _agendaService.getAddressesByActive(referee.activeId!);

    response.fold(
        (l) => emit(state.copyWith(
            referee: referee, screenStatus: ScreenStatus.loaded)), (r) {
      print('>>> ------------------------------------------------------------');
      print('>>> getAddressesDetail');
      print('>>> ------------------------------------------------------------');
      print('${response}');
      print('>>> ------------------------------------------------------------');

      emit(state.copyWith(
          qraAddresses: r,
          referee: referee,
          screenStatus: ScreenStatus.loaded));
    });
  }

  Future<void> onUpdateLatLeng(double lat, double lengt) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    print("Datos de la latitude y longitude");
    print(lat);
    print(lengt);
    emit(state.copyWith(
        lat: lat, leng: lengt, screenStatus: ScreenStatus.loaded));
  }

  Future<void> getRefreeInfo(int personId, String personName) async {
    final response =
        await _refereeService.getRefereeDataByPersonId(personId, personName);
    /**
     * his.lat = 19.4260138,
    this.leng = -99.6389653,
     */
    if (response.refereeLatitude != null) {
      emit(state.copyWith(
        lat: response.refereeLatitude!.length > 0
            ? double.parse(response.refereeLatitude!)
            : lat,
      ));
    }

    if (response.refereeLength != null) {
      emit(state.copyWith(
        leng: response.refereeLength!.length > 0
            ? double.parse(response.refereeLength!)
            : long,
      ));
    }

    emit(state.copyWith(
      screenStatus: ScreenStatus.loaded,
      referee: response,
    ));

    await getAddressesDetail(response);
  }

  Future<void> getCurrentPosition(int personId, String personName) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));

    if (await Permission.location.isGranted) {
      final position = await _geolocatorPlatform.getCurrentPosition();
      lat = position.latitude;
      long = position.longitude;
      emit(state.copyWith(lat: lat, leng: long));
      if (position.longitude != null && position.latitude != null) {
        await _updatePositionList(PositionItemType.position,
            position.toString(), personId, personName);
        emit(state.copyWith(
            lat: lat, leng: long, screenStatus: ScreenStatus.loaded));
      }
    } else {
      lat = 23.634501;
      long = -102.552784;
      emit(state.copyWith(
          lat: lat, leng: long, screenStatus: ScreenStatus.loaded));
    }
  }

  Future<void> _updatePositionList(PositionItemType type, String displayValue,
      int personId, String personName) async {
    _positionItems.add(PositionItem(type, displayValue));
    emit(state.copyWith(lat: lat, leng: long));
    await getRefreeInfo(personId, personName);
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
            addressName: 'REFEREE',
            enabledFlag: 'Y',
            addressType: 'REFEREE')));
  }

  void onFieldAddresChange(String value) {
    emit(state.copyWith(
        screenStatus: ScreenStatus.loaded,
        referee: state.referee.copyWith(refereeAddress: value)));
  }

  void onFieldLatitudeChange(String value) {
    emit(state.copyWith(
        referee: state.referee.copyWith(refereeLatitude: value)));
  }

  void onFieldLengthChange(String value) {
    emit(state.copyWith(referee: state.referee.copyWith(refereeLength: value)));
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
}
