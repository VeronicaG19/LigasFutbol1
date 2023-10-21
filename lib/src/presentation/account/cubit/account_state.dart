part of 'account_cubit.dart';

class AccountState extends Equatable {
  final UserDTO? userDTO;
  final Player? player;
  final bool warningReaded;
  final BasicCubitScreenState screenState;
  final String? errorMessage;

  const AccountState({
    this.userDTO = UserDTO.empty,
    this.player = Player.empty,
    this.warningReaded = false,
    this.screenState = BasicCubitScreenState.initial,
    this.errorMessage,
  });

  AccountState copyWith({
    UserDTO? userDTO,
    Player? player,
    bool? warningReaded,
    BasicCubitScreenState? screenState,
    String? errorMessage,
  }) {
    return AccountState(
      userDTO: userDTO ?? this.userDTO,
      player: player ?? this.player,
      warningReaded: warningReaded ?? this.warningReaded,
      screenState: screenState ?? this.screenState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        userDTO,
        player,
        warningReaded,
        screenState,
      ];
}
