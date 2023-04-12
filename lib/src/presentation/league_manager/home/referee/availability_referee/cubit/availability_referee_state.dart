part of 'availability_referee_cubit.dart';

class AvailabilityRefereeState extends Equatable {
  final RefereeByLeagueDTO referee;
  final DateTime? initialDate;
  final DateTime? initialHour;
  final DateTime? endDate;
  final DateTime? endHour;
  final BasicCubitScreenState screenState;
  final String? errorMessage;
  final List<Availability>? availability;
  final RefereeDetailDTO? detailReferee;
  final List<QraEvent> selectedEvents;
  final DateTime? firstDay;
  final DateTime? lastDay;
  final DateTime? focusedDay;
  final DateTime? selectedDay;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final DateTime? startHour;
  final DateTime? finalHour;
  final List<RefereeByLeagueDTO> refereeList;
  final RefereeByLeagueDTO selectedReferee;
  final RangeSelectionMode rangeSelectionMode;
  final FormzStatus formzStatus;
  final SimpleTextValidator description;

  const AvailabilityRefereeState(
      {this.screenState = BasicCubitScreenState.initial,
      this.referee = RefereeByLeagueDTO.empty,
      this.initialDate,
      this.initialHour,
      this.endDate,
      this.endHour,
      this.errorMessage,
      this.detailReferee = RefereeDetailDTO.empty,
      this.availability = const [],
      this.selectedEvents = const [],
      this.firstDay,
      this.lastDay,
      this.focusedDay,
      this.selectedDay,
      this.rangeStart,
      this.rangeEnd,
      this.startHour,
      this.finalHour,
      this.refereeList = const [],
      this.selectedReferee = RefereeByLeagueDTO.empty,
      this.formzStatus = FormzStatus.pure,
      this.description = const SimpleTextValidator.pure(),
      this.rangeSelectionMode = RangeSelectionMode.toggledOff});

  AvailabilityRefereeState copyWith({
    RefereeByLeagueDTO? referee,
    DateTime? initialDate,
    DateTime? initialHour,
    DateTime? endDate,
    DateTime? endHour,
    BasicCubitScreenState? screenState,
    String? errorMessage,
    List<Availability>? availability,
    RefereeDetailDTO? detailReferee,
    List<QraEvent>? selectedEvents,
    DateTime? firstDay,
    DateTime? lastDay,
    DateTime? focusedDay,
    DateTime? selectedDay,
    DateTime? rangeStart,
    DateTime? rangeEnd,
    DateTime? startHour,
    DateTime? finalHour,
    List<RefereeByLeagueDTO>? refereeList,
    RefereeByLeagueDTO? selectedReferee,
    RangeSelectionMode? rangeSelectionMode,
    FormzStatus? formzStatus,
    SimpleTextValidator? description,
  }) {
    return AvailabilityRefereeState(
      referee: referee ?? this.referee,
      initialDate: initialDate ?? this.initialDate,
      initialHour: initialHour ?? this.initialHour,
      endDate: endDate ?? this.endDate,
      endHour: endHour ?? this.endHour,
      screenState: screenState ?? this.screenState,
      errorMessage: errorMessage ?? this.errorMessage,
      availability: availability ?? this.availability,
      detailReferee: detailReferee ?? this.detailReferee,
      selectedEvents: selectedEvents ?? this.selectedEvents,
      firstDay: firstDay ?? this.firstDay,
      lastDay: lastDay ?? this.lastDay,
      focusedDay: focusedDay ?? this.focusedDay,
      selectedDay: selectedDay ?? this.selectedDay,
      rangeStart: rangeStart ?? this.rangeStart,
      rangeEnd: rangeEnd ?? this.rangeEnd,
      startHour: startHour ?? this.startHour,
      finalHour: finalHour ?? this.finalHour,
      refereeList: refereeList ?? this.refereeList,
      selectedReferee: selectedReferee ?? this.selectedReferee,
      rangeSelectionMode: rangeSelectionMode ?? this.rangeSelectionMode,
      formzStatus: formzStatus ?? this.formzStatus,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
        referee,
        initialDate,
        initialHour,
        endDate,
        endHour,
        screenState,
        errorMessage,
        availability,
        detailReferee,
        selectedEvents,
        firstDay,
        lastDay,
        focusedDay,
        selectedDay,
        rangeStart,
        rangeEnd,
        startHour,
        finalHour,
        refereeList,
        selectedReferee,
        rangeSelectionMode,
        formzStatus,
        description,
      ];
}
