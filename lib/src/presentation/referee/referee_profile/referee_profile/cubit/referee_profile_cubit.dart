import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:formz/formz.dart';
import 'package:here_repository/here_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

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
      : super(const RefereeProfileState());

  final IRefereeService _refereeService;
  final IAgendaService _agendaService;
  final ApiHereReposiTory _apiHereReposiTory;

  final _mapController = MapController();
  final TextEditingController _textEditingController = TextEditingController();
  MapController get getMapController => _mapController;

  TextEditingController get getTextAddresController => _textEditingController;

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

    response.fold((l) => null, (r) {
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
    print(lat);
    print(lengt);
    emit(state.copyWith(
        lat: lat, leng: lengt, screenStatus: ScreenStatus.loaded));
  }

  Future<void> getRefreeInfo(int personId, String personName) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));

    final response =
        await _refereeService.getRefereeDataByPersonId(personId, personName);
    /**
     * his.lat = 19.4260138,
    this.leng = -99.6389653,
     */
    if (response.refereeLatitude != null) {
      emit(state.copyWith(
        leng: response.refereeLatitude!.length > 0
            ? double.parse(response.refereeLatitude!)
            : -99.6389653,
      ));
    }

    if (response.refereeLength != null) {
      emit(state.copyWith(
        leng: response.refereeLength!.length > 0
            ? double.parse(response.refereeLength!)
            : -99.6389653,
      ));
    }

    emit(state.copyWith(
      screenStatus: ScreenStatus.loaded,
      referee: response,
    ));

    getAddressesDetail(response);
  }

  void onUpdateAssetAddres(ReverseHeoApiHere reverseHeoApiHere) {
    emit(state.copyWith(
        qraAddresses: state.qraAddresses.copyWith(
            city: reverseHeoApiHere.items.first.address!.city!,
            postalCode: reverseHeoApiHere.items.first.address!.postalCode!,
            state: reverseHeoApiHere.items.first.address!.state,
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
