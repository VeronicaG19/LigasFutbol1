part of 'lm_field_schedule_cubit.dart';

class LmFieldScheduleState extends Equatable {
  final List<QraEvent> selectedEvents;
  final BasicCubitScreenState screenState;
  final DateTime? firstDay;
  final DateTime? lastDay;
  final DateTime? focusedDay;
  final DateTime? selectedDay;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final DateTime? startHour;
  final DateTime? finalHour;
  final List<Availability> availabilityList;
  final Availability selectedAvailability;
  final RangeSelectionMode rangeSelectionMode;
  final List<QraPrices> pricesbyActive;

  const LmFieldScheduleState(
      {this.selectedEvents = const [],
      this.screenState = BasicCubitScreenState.initial,
      this.firstDay,
      this.lastDay,
      this.focusedDay,
      this.selectedDay,
      this.rangeStart,
      this.rangeEnd,
      this.startHour,
      this.finalHour,
      this.availabilityList = const [],
      this.selectedAvailability = Availability.empty,
      this.rangeSelectionMode = RangeSelectionMode.disabled,
      this.pricesbyActive = const []});

  LmFieldScheduleState copyWith({
    List<QraEvent>? selectedEvents,
    BasicCubitScreenState? screenState,
    DateTime? firstDay,
    DateTime? lastDay,
    DateTime? focusedDay,
    DateTime? selectedDay,
    DateTime? rangeStart,
    DateTime? rangeEnd,
    DateTime? startHour,
    DateTime? finalHour,
    List<Availability>? availabilityList,
    Availability? selectedAvailability,
    RangeSelectionMode? rangeSelectionMode,
    List<QraPrices>? pricesbyActive,
  }) {
    return LmFieldScheduleState(
        selectedEvents: selectedEvents ?? this.selectedEvents,
        screenState: screenState ?? this.screenState,
        firstDay: firstDay ?? this.firstDay,
        lastDay: lastDay ?? this.lastDay,
        focusedDay: focusedDay ?? this.focusedDay,
        selectedDay: selectedDay ?? this.selectedDay,
        rangeStart: rangeStart ?? this.rangeStart,
        rangeEnd: rangeEnd ?? this.rangeEnd,
        startHour: startHour ?? this.startHour,
        finalHour: finalHour ?? this.finalHour,
        availabilityList: availabilityList ?? this.availabilityList,
        selectedAvailability: selectedAvailability ?? this.selectedAvailability,
        rangeSelectionMode: rangeSelectionMode ?? this.rangeSelectionMode,
        pricesbyActive: pricesbyActive ?? this.pricesbyActive);
  }

  @override
  List<Object?> get props => [
        selectedEvents,
        screenState,
        firstDay,
        lastDay,
        focusedDay,
        selectedDay,
        rangeStart,
        rangeEnd,
        startHour,
        finalHour,
        availabilityList,
        selectedAvailability,
        rangeSelectionMode,
        pricesbyActive,
      ];
}
