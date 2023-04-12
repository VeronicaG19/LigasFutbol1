part of 'data_player_cubit.dart';

@immutable
enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
}

class DataPlayerState extends Equatable {
  final Player playerInfo;
  final String? errorMessage;
  final ScreenStatus screenStatus;

  const DataPlayerState({
    this.playerInfo = Player.empty,
    this.screenStatus = ScreenStatus.initial,
    this.errorMessage,
  });

  DataPlayerState copyWith({
    Player? playerInfo,
    String? errorMessage,
    ScreenStatus? screenStatus,
  }) {
    return DataPlayerState(
      playerInfo: playerInfo ?? this.playerInfo,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object> get props => [playerInfo, screenStatus];
}
