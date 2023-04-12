part of 'ref_league_cubit.dart';

class RefLeagueState extends Equatable {
  final List<League> leagueList;
  final BasicCubitScreenState screenState;
  final UserRequests userRequests;
  final String? errorMessage;

  const RefLeagueState({
    this.leagueList = const [],
    this.userRequests = UserRequests.empty,
    this.screenState = BasicCubitScreenState.initial,
    this.errorMessage,
  });

  RefLeagueState copyWith({
    List<League>? leagueList,
    BasicCubitScreenState? screenState,
    UserRequests? userRequests,
    String? errorMessage,
  }) {
    return RefLeagueState(
      leagueList: leagueList ?? this.leagueList,
      userRequests: userRequests ?? this.userRequests,
      screenState: screenState ?? this.screenState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [leagueList, screenState, userRequests];
}
