part of 'ref_matches_cubit.dart';

class RefMatchesState extends Equatable {
  final List<RefereeMatchDTO> matches;
  final BasicCubitScreenState screenState;
  final String? errorMessage;

  const RefMatchesState({
    this.matches = const [],
    this.screenState = BasicCubitScreenState.initial,
    this.errorMessage,
  });

  RefMatchesState copyWith({
    List<RefereeMatchDTO>? matches,
    BasicCubitScreenState? screenState,
    String? errorMessage,
  }) {
    return RefMatchesState(
      matches: matches ?? this.matches,
      screenState: screenState ?? this.screenState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        screenState,
        matches,
      ];
}
