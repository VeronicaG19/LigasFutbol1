part of 'tournament_lm_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
}

class TournamentLmState extends Equatable {
  final List<Tournament> tournamentList;
  final String? errorMessage;
  final ScreenStatus screenStatus;

  const TournamentLmState({
    this.tournamentList = const [],
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
  });

  TournamentLmState copyWith({
    List<Tournament>? tournamentList,
    String? errorMessage,
    ScreenStatus? screenStatus,
  }) {
    return TournamentLmState(
      tournamentList: tournamentList ?? this.tournamentList,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object> get props => [
    tournamentList,
    screenStatus,
  ];
}
