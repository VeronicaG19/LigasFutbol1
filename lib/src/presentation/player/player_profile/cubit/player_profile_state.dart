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
  final Address addresInput;
  final PositionPlayer postionInput;

  const PlayerProfileState({
    this.playerInfo = Player.empty,
    this.screenStatus = ScreenStatus.initial,
    this.errorMessage,
    this.formStatus = FormzStatus.pure,
    this.nickNameInput = const NickName.pure(),
    this.bithDateInput = const BirthDate.pure(),
    this.addresInput = const Address.pure(),
    this.postionInput = const PositionPlayer.pure()
  });

  @override
  // TODO: implement props
  List<Object?> get props => [playerInfo, screenStatus,formStatus, bithDateInput, nickNameInput, addresInput,postionInput];

  PlayerProfileState copyWith({
    Player? playerInfo,
    String? errorMessage,
    ScreenStatus? screenStatus,
    FormzStatus? formStatus,
    NickName ? nickNameInput,
    BirthDate? bithDateInput,
    Address? addresInput,
    PositionPlayer? postionInput
  }) {
    return PlayerProfileState(
      playerInfo: playerInfo ?? this.playerInfo,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
      formStatus: formStatus ?? this.formStatus,
      nickNameInput : nickNameInput ?? this.nickNameInput,
      bithDateInput : bithDateInput ??this.bithDateInput,
      addresInput : addresInput ?? this.addresInput,
      postionInput: postionInput ?? this.postionInput
    );
  }
}
