part of 'rounds_configuration_cubit.dart';

class RoundsConfigurationState extends Equatable{

  final List<ScoringTournamentDTO> scoringTournament;
  final String? matchForRound;
  final BasicCubitScreenState screenState;
  final String? errorMessage;

  const RoundsConfigurationState({
    this.scoringTournament = const [],
    this.matchForRound,
    this.screenState = BasicCubitScreenState.initial,
    this.errorMessage,
  });

  RoundsConfigurationState copyWith({
    List<ScoringTournamentDTO>? scoringTournament,
    String? matchForRound,
    BasicCubitScreenState? screenState,
    String? errorMessage,
  }) {
    return RoundsConfigurationState(
      scoringTournament: scoringTournament ?? this.scoringTournament,
      matchForRound: matchForRound ?? this.matchForRound,
      screenState: screenState ?? this.screenState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    scoringTournament,
    matchForRound,
    screenState,
  ];

}
