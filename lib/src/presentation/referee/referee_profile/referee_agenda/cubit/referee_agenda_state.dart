part of 'referee_agenda_cubit.dart';

class RefereeAgendaState extends Equatable {
  final DateTime? initialDate;
  final DateTime? initialHour;
  final DateTime? endDate;
  final DateTime? endHour;
  final List<DaysEnum> selectedDays;
  final String? errorMessage;
  final List<Agenda> agendaList;
  final List<Availability> availabilityList;
  final Availability selectedAvailability;
  final DateTime? focusedDay;
  final DateTime? selectedDay;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final RangeSelectionMode rangeSelectionMode;
  final BasicCubitScreenState screenState;

  const RefereeAgendaState({
    this.initialDate,
    this.initialHour,
    this.endDate,
    this.endHour,
    this.selectedDays = const [],
    this.agendaList = const [],
    this.availabilityList = const [],
    this.selectedAvailability = Availability.empty,
    this.focusedDay,
    this.selectedDay,
    this.rangeStart,
    this.rangeSelectionMode = RangeSelectionMode.toggledOff,
    this.rangeEnd,
    this.errorMessage,
    this.screenState = BasicCubitScreenState.initial,
  });

  RefereeAgendaState copyWith({
    DateTime? initialDate,
    DateTime? initialHour,
    DateTime? endDate,
    DateTime? endHour,
    List<DaysEnum>? selectedDays,
    String? errorMessage,
    List<Availability>? availabilityList,
    Availability? selectedAvailability,
    List<Agenda>? agendaList,
    DateTime? focusedDay,
    DateTime? selectedDay,
    DateTime? rangeStart,
    RangeSelectionMode? rangeSelectionMode,
    DateTime? rangeEnd,
    BasicCubitScreenState? screenState,
  }) {
    return RefereeAgendaState(
      initialDate: initialDate ?? this.initialDate,
      initialHour: initialHour ?? this.initialHour,
      endDate: endDate ?? this.endDate,
      endHour: endHour ?? this.endHour,
      selectedDays: selectedDays ?? this.selectedDays,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedAvailability: selectedAvailability ?? this.selectedAvailability,
      agendaList: agendaList ?? this.agendaList,
      availabilityList: availabilityList ?? this.availabilityList,
      focusedDay: focusedDay ?? this.focusedDay,
      selectedDay: selectedDay ?? this.selectedDay,
      rangeStart: rangeStart ?? this.rangeStart,
      rangeEnd: rangeEnd ?? this.rangeEnd,
      rangeSelectionMode: rangeSelectionMode ?? this.rangeSelectionMode,
      screenState: screenState ?? this.screenState,
    );
  }

  @override
  List<Object?> get props => [
        initialDate,
        initialHour,
        endDate,
        endHour,
        selectedDays,
        availabilityList,
        agendaList,
        selectedAvailability,
        screenState,
        focusedDay,
        selectedDay,
        rangeStart,
        rangeEnd,
        rangeSelectionMode,
      ];
}
