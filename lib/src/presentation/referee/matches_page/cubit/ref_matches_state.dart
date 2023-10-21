part of 'ref_matches_cubit.dart';

class RefMatchesState extends Equatable {
  final List<RefereeMatchDTO> matches;
  final BasicCubitScreenState screenState;
  final String? errorMessage;
  final String? statusMessage;
  final List<RefereeMatchDTO> finishedMatchesList;
  final List<RefereeMatchDTO> otherMatchesList;

  const RefMatchesState(
      {this.matches = const [],
      this.screenState = BasicCubitScreenState.initial,
      this.errorMessage,
      this.statusMessage,
      this.finishedMatchesList = const [],
      this.otherMatchesList = const []});

  RefMatchesState copyWith(
      {List<RefereeMatchDTO>? matches,
      BasicCubitScreenState? screenState,
      String? errorMessage,
      String? statusMessage,
      List<RefereeMatchDTO>? finishedMatchesList,
      List<RefereeMatchDTO>? otherMatchesList}) {
    return RefMatchesState(
        matches: matches ?? this.matches,
        screenState: screenState ?? this.screenState,
        errorMessage: errorMessage ?? this.errorMessage,
        statusMessage: statusMessage ?? this.statusMessage,
        finishedMatchesList: finishedMatchesList ?? this.finishedMatchesList,
        otherMatchesList: otherMatchesList ?? this.otherMatchesList);
  }

  @override
  List<Object?> get props => [
        screenState,
        matches,
        statusMessage,
        finishedMatchesList,
        otherMatchesList
      ];
}
