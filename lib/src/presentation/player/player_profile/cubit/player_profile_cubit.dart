import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:formz/formz.dart';
import 'package:here_repository/here_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:ligas_futbol_flutter/src/domain/player/entity/player.dart';
import 'package:ligas_futbol_flutter/src/domain/player/entity/player_image_profile.dart';
import 'package:ligas_futbol_flutter/src/domain/player/pos_player.dart';
import 'package:ligas_futbol_flutter/src/domain/player/service/i_player_service.dart';

import '../../../../domain/player/address.dart' as plyadd;
import '../../../../domain/player/birdth_date.dart';
import '../../../../domain/player/entity/position.dart';
import '../../../../domain/player/nick_name.dart';

part 'player_profile_state.dart';

@injectable
class PlayerProfileCubit extends Cubit<PlayerProfileState> {
  PlayerProfileCubit(this._service, this._apiHereReposiTory)
      : super(const PlayerProfileState());

  final IPlayerService _service;
  final ApiHereReposiTory _apiHereReposiTory;

  final _mapController = MapController();
  final TextEditingController _textEditingController = TextEditingController();
  MapController get getMapController => _mapController;

  TextEditingController get getTextAddresController => _textEditingController;

  Future<void> loadInfoPlayer({required int personId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final request = await _service.getDataPlayerByPartyId(personId);
    request.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("----------RESULTADO----------");
      print(r.playerid);
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, playerInfo: r));
    });
  }

  void onChagedNickName(String value) {
    final nickname = NickName.dirty(value);
    emit(
      state.copyWith(
        nickNameInput: nickname,
        formStatus: Formz.validate(
          [nickname, state.nickNameInput],
        ),
      ),
    );
  }

  void onChagedPosId(String value) {
    final postion = PositionPlayer.dirty(value);
    emit(
      state.copyWith(
        postionInput: postion,
        formStatus: Formz.validate(
          [postion, state.postionInput],
        ),
      ),
    );
  }

  Future<void> onChagePos(Positions value) async {
    emit(state.copyWith(
        playerInfo: state.playerInfo.copyWith(
          preferencePositionId: value.preferencePositionId,
        ),
        formStatus: FormzStatus.submissionInProgress));
  }

  Future<void> onchangeTag(String tag) async {
    emit(state.copyWith(
      playerInfo: state.playerInfo.copyWith(nickNameFlag: 'Y', nickName: tag),
      formStatus: FormzStatus.submissionInProgress,
    ));
  }

  void onChagedBirthDate(String value) {
    print(value);
    final birthDate = BirthDate.dirty(value);
    emit(
      state.copyWith(
        bithDateInput: birthDate,
        formStatus: Formz.validate(
          [birthDate, state.bithDateInput],
        ),
      ),
    );
  }

  Future<void> onchangePlayerBirthday(DateTime playerBirthday) async {
    final birthDate = BirthDate.dirty(playerBirthday.toString());
    emit(state.copyWith(
      playerInfo: state.playerInfo.copyWith(birthday: playerBirthday),
      bithDateInput: birthDate,
      formStatus: Formz.validate(
        [birthDate, state.bithDateInput],
      ),
    ));
  }

  Future<void> onchangeBirthDay(DateTime playerBirthday) async {
    emit(state.copyWith(
      playerInfo: state.playerInfo.copyWith(birthday: playerBirthday),
      formStatus: FormzStatus.submissionInProgress,
    ));
  }

  Future<void> onchangeAddresPlayer(String addres) async {
    emit(state.copyWith(
        playerInfo: state.playerInfo.copyWith(playerAddress: addres)));
  }

  void onChagedAddress(String value) {
    final address = plyadd.Address.dirty(value);
    emit(
      state.copyWith(
        addresInput: address,
        formStatus: Formz.validate(
          [address, state.addresInput],
        ),
      ),
    );
  }

  String agePlayer(DateTime? birthday) {
    final currentDate = DateTime.now();
    final currentYear = currentDate.year;
    final yearBirth = birthday?.year ?? currentYear;
    String playerAge;

    playerAge = (currentYear - yearBirth).toString();

    if (playerAge == '0') {
      return playerAge = '';
    }

    return '$playerAge' ' Años';
  }

  Future<void> onUpdatePersonName() async {
    emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
    //emit(state.copyWith(screenStatus: ScreenStatus.loading));
    //if (!state.formStatus.isValidated) return;
    /*String dateStart = '22-04-2021 05:57:58 PM';
  DateFormat inputFormat = DateFormat('dd-MM-yyyy hh:mm:ss a');*/
    // emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
    // print('birth date ${state.bithDateInput.value}');
    final photo = PlayerPhotoId(
      document: state.playerInfo.document,
      fileId: state.playerInfo.fileId,
    );
    final obj = state.playerInfo.copyWith(playerPhotoId: photo);
    final request = await _service.updatePlayer(obj);
    request.fold((l) {
      emit(
        state.copyWith(
          errorMessage: l.errorMessage,
          formStatus: FormzStatus.submissionFailure,
        ),
      );
      loadInfoPlayer(personId: state.playerInfo.partyId!);
    }, (r) {
      emit(state.copyWith(formStatus: FormzStatus.submissionSuccess));
      loadInfoPlayer(personId: r.partyId!);
    });
  }

  Future<void> onUpdatePhotoImage(String imageFile) async {
    emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
    final photo = PlayerPhotoId(
      document: imageFile,
      fileId: state.playerInfo.fileId,
      fileType: 'IMAGE',
      fileName: 'PLAYER_PHOTO',
      approveResource: 'P',
    );
    final obj = state.playerInfo.copyWith(playerPhotoId: null);
    print('onUpdatePersonName');
    final request = await _service.updatePlayer(obj);
    request.fold(
        (l) => emit(
              state.copyWith(
                errorMessage: l.errorMessage,
                formStatus: FormzStatus.submissionFailure,
              ),
            ), (r) {
      emit(state.copyWith(formStatus: FormzStatus.submissionSuccess));
      loadInfoPlayer(personId: r.partyId!);
    });
  }

  // addres metods
  Future<void> onUpdateLatLeng(double lat, double lengt) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    print(lat);
    print(lengt);
    emit(state.copyWith(
        lat: lat, leng: lengt, screenStatus: ScreenStatus.loaded));
  }

  void onFieldAddresChange(String value) {
    emit(state.copyWith(
        screenStatus: ScreenStatus.loaded,
        playerInfo: state.playerInfo.copyWith(playerAddress: value)));
  }

  void onFieldLatitudeChange(String value) {
    emit(state.copyWith(
        playerInfo: state.playerInfo.copyWith(playerLatitude: value)));
  }

  void onFieldLengthChange(String value) {
    emit(state.copyWith(
        playerInfo: state.playerInfo.copyWith(playerLenght: value)));
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
    emit(state.copyWith(
      screenStatus: ScreenStatus.loading,
    ));
    String latLngthGeo = '${latLng.latitude}%2C${latLng.longitude}';
    final response = await _apiHereReposiTory.getReverseGeoAddres(latLngthGeo);
    response.fold((l) => null, (r) {
      _textEditingController.text = r.items.first.address!.label!;
      onFieldLengthChange('${latLng.longitude}');
      onFieldLatitudeChange('${latLng.latitude}');
      onFieldAddresChange(r.items.first.address!.label!);
      addMarker(latLng);
    });
  }

  Future<void> updateAddresAsset() async {
    emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
    final photo = PlayerPhotoId(
      document: state.playerInfo.document,
      fileId: state.playerInfo.fileId,
    );
    final obj = state.playerInfo.copyWith(playerPhotoId: photo);
    final request = await _service.updatePlayer(obj);
    request.fold(
        (l) => emit(state.copyWith(formStatus: FormzStatus.submissionFailure)),
        (r) async {
      emit(state.copyWith(formStatus: FormzStatus.submissionSuccess));
      loadInfoPlayer(personId: r.partyId!);
    });
  }
}
