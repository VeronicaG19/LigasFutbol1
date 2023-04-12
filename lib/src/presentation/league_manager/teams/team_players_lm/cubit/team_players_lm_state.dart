part of 'team_players_lm_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
  success,
}

class TeamPlayersLMState extends Equatable {
  final List<PlayerByTeam> teamPlayer;
  final String? errorMessage;
  final ScreenStatus screenStatus;

  const TeamPlayersLMState({
    this.teamPlayer = const [],
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
  });

  TeamPlayersLMState copyWith({
    List<PlayerByTeam>? teamPlayer,
    String? errorMessage,
    ScreenStatus? screenStatus,
  }) {
    return TeamPlayersLMState(
      teamPlayer: teamPlayer ?? this.teamPlayer,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object> get props => [
        teamPlayer,
        screenStatus,
      ];
}
