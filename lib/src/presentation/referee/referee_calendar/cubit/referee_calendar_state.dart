part of 'referee_calendar_cubit.dart';

class RefereeCalendarState extends Equatable {
  final List<RefereeMatchDTO> selectedEvents;
  final BasicCubitScreenState screenState;
  final DateTime? focusedDay;
  final DateTime? selectedDay;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final RangeSelectionMode rangeSelectionMode;
  final String? errorMessage;

  const RefereeCalendarState({
    this.selectedEvents = const [],
    this.screenState = BasicCubitScreenState.initial,
    this.focusedDay,
    this.selectedDay,
    this.rangeStart,
    this.rangeSelectionMode = RangeSelectionMode.toggledOff,
    this.rangeEnd,
    this.errorMessage,
  });

  RefereeCalendarState copyWith({
    List<RefereeMatchDTO>? selectedEvents,
    BasicCubitScreenState? screenState,
    DateTime? focusedDay,
    DateTime? selectedDay,
    DateTime? rangeStart,
    RangeSelectionMode? rangeSelectionMode,
    DateTime? rangeEnd,
    String? errorMessage,
  }) {
    return RefereeCalendarState(
      selectedEvents: selectedEvents ?? this.selectedEvents,
      screenState: screenState ?? this.screenState,
      focusedDay: focusedDay ?? this.focusedDay,
      selectedDay: selectedDay ?? this.selectedDay,
      rangeStart: rangeStart ?? this.rangeStart,
      rangeEnd: rangeEnd ?? this.rangeEnd,
      rangeSelectionMode: rangeSelectionMode ?? this.rangeSelectionMode,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        selectedEvents,
        screenState,
        focusedDay,
        selectedDay,
        rangeStart,
        rangeEnd,
        rangeSelectionMode,
      ];
}
