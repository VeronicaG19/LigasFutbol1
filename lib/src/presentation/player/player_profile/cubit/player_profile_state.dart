part of 'player_profile_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error
}

class PlayerProfileState extends Equatable {
  final Player playerInfo;
  //final EmailInput emailInput;
  final NickName nickNameInput;
  final BirthDate bithDateInput;
  final String? errorMessage;
  final ScreenStatus screenStatus;
  final FormzStatus formStatus;
  final plyadd.Address addresInput;
  final PositionPlayer postionInput;
  final ApiHereResponseAddresses apiHereResponseAddresses;
  final List<Result> addreses;
  final double lat;
  final double leng;
  final List<Marker> allMarkers;

  const PlayerProfileState({
    this.playerInfo = Player.empty,
    this.screenStatus = ScreenStatus.initial,
    this.errorMessage,
    this.lat = 19.4260138,
    this.leng = -99.6389653,
    this.addreses = const [],
    this.formStatus = FormzStatus.pure,
    this.nickNameInput = const NickName.pure(),
    this.bithDateInput = const BirthDate.pure(),
    this.addresInput = const plyadd.Address.pure(),
    this.postionInput = const PositionPlayer.pure(),
    this.apiHereResponseAddresses = ApiHereResponseAddresses.empty,
    this.allMarkers = const [],

  });

  @override
  // TODO: implement props
  List<Object?> get props => [playerInfo, 
  screenStatus,
  formStatus, 
  bithDateInput, 
  nickNameInput, 
  addresInput,
  postionInput,
  lat,
  leng,
  addreses,
  apiHereResponseAddresses,
  allMarkers];

  PlayerProfileState copyWith({
    Player? playerInfo,
    String? errorMessage,
    ScreenStatus? screenStatus,
    FormzStatus? formStatus,
    NickName ? nickNameInput,
    BirthDate? bithDateInput,
    plyadd.Address? addresInput,
    PositionPlayer? postionInput,
    ApiHereResponseAddresses? apiHereResponseAddresses,
    List<Result>? addreses,
    double? lat,
    double? leng,
    List<Marker>? allMarkers

  }) {
    return PlayerProfileState(
      playerInfo: playerInfo ?? this.playerInfo,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
      formStatus: formStatus ?? this.formStatus,
      nickNameInput : nickNameInput ?? this.nickNameInput,
      bithDateInput : bithDateInput ??this.bithDateInput,
      addresInput : addresInput ?? this.addresInput,
      postionInput: postionInput ?? this.postionInput,
      apiHereResponseAddresses: apiHereResponseAddresses ?? this.apiHereResponseAddresses,
      addreses: addreses ?? this.addreses,
      lat: lat ?? this.lat,
      leng: leng ?? this.leng,
      allMarkers: allMarkers ?? this.allMarkers
    );
  }
}
