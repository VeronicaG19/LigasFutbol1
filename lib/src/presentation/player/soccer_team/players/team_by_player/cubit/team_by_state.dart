part of 'team_by_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
}

class TeamByPlayerState extends Equatable {
  final List<Team> teamList;
  final String? errorMessage;
  final ScreenStatus screenStatus;

  const TeamByPlayerState({
    this.teamList = const [],
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
  });

  TeamByPlayerState copyWith({
    List<Team>? teamList,
    String? errorMessage,
    ScreenStatus? screenStatus,
  }) {
    return TeamByPlayerState(
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
