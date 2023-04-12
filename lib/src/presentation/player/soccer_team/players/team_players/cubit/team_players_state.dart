part of 'team_players_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
  success,
}

class TeamPlayerState extends Equatable {
  final List<TeamPlayer> teamPlayer;
  final String? errorMessage;
  final ScreenStatus screenStatus;
  final ValidateRequestDTO validationrequet;

  const TeamPlayerState({
    this.teamPlayer = const [],
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
    this.validationrequet = ValidateRequestDTO.empty,
  });

  TeamPlayerState copyWith({
    List<TeamPlayer>? teamPlayer,
    String? errorMessage,
    ScreenStatus? screenStatus,
    ValidateRequestDTO? validationrequet,
  }) {
    return TeamPlayerState(
      teamPlayer: teamPlayer ?? this.teamPlayer,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
      validationrequet: validationrequet ?? this.validationrequet,
    );
  }

  @override
  List<Object> get props => [
        teamPlayer,
        screenStatus,
        validationrequet,
      ];
}
