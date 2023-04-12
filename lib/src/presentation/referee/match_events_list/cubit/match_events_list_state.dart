part of 'match_events_list_cubit.dart';


class MatchEventsListState extends Equatable{
  final List<RefereeMatchEventDTO> eventsList;
  final String? errorMessage;
  final BasicCubitScreenState screenState;

  const MatchEventsListState({
    this.eventsList = const [],
    this.screenState = BasicCubitScreenState.initial,
    this.errorMessage
  });

  MatchEventsListState copyWith({
    List<RefereeMatchEventDTO>? eventsList,
    BasicCubitScreenState? screenState,
    String? errorMessage,
  }) {
    return MatchEventsListState(
      eventsList: eventsList ?? this.eventsList,
      screenState: screenState ?? this.screenState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    eventsList,
    screenState,
  ];
}
