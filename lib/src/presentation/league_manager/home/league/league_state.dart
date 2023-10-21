part of 'league_cubit.dart';

class LeagueByLeagueManagerState extends Equatable {
  final League league;
  final String? errorMessage;
  final BasicCubitScreenState screenState;
  final SimpleTextValidator description;
  final FormzStatus formzStatus;

  const LeagueByLeagueManagerState({
    this.league = League.empty,
    this.errorMessage,
    this.screenState = BasicCubitScreenState.initial,
    this.description = const SimpleTextValidator.pure(),
    this.formzStatus = FormzStatus.pure,
  });

  LeagueByLeagueManagerState copyWith({
    League? league,
    String? errorMessage,
    BasicCubitScreenState? screenState,
    SimpleTextValidator? description,
    FormzStatus? formzStatus,
  }) {
    return LeagueByLeagueManagerState(
      league: league ?? this.league,
      errorMessage: errorMessage ?? this.errorMessage,
      screenState: screenState ?? this.screenState,
      description: description ?? this.description,
      formzStatus: formzStatus ?? this.formzStatus,
    );
  }

  @override
  List<Object> get props => [league, screenState, description, formzStatus];
}
