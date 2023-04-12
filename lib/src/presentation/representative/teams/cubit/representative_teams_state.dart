part of 'representative_teams_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
}

class RepresentativeTeamsState extends Equatable{
  final List<Team> teamList;
  final String? errorMessage;
  final ScreenStatus screenStatus;

  const RepresentativeTeamsState({
    this.teamList = const [],
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
  });

  RepresentativeTeamsState copyWith({
    List<Team>? teamList,
    String? errorMessage,
    ScreenStatus? screenStatus,
  }) {
    return RepresentativeTeamsState(
      teamList: teamList ?? this.teamList,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object?> get props => [teamList, screenStatus];

}
