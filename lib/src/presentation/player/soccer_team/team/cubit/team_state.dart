part of 'team_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
}

class TeamState extends Equatable {
  final List<Team> teamList;
  final String? errorMessage;
  final ScreenStatus screenStatus;

  const TeamState({
    this.teamList = const [],
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
  });

  TeamState copyWith({
    List<Team>? teamList,
    String? errorMessage,
    ScreenStatus? screenStatus,
  }) {
    return TeamState(
      teamList: teamList ?? this.teamList,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object> get props => [
        teamList,
        screenStatus,
      ];
}
