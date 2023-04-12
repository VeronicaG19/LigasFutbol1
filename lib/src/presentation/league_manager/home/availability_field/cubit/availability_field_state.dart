part of 'availability_field_cubit.dart';

class AvailabilityFieldState extends Equatable {
  final Field field;
  final DateTime? initialDate;
  final DateTime? initialHour;
  final DateTime? endDate;
  final DateTime? endHour;
  final BasicCubitScreenState screenState;
  final String? errorMessage;
  final List<Availability>? availability;
  final Field? detailField;
  final List<QraEvent> selectedEvents;
  final DateTime? firstDay;
  final DateTime? lastDay;
  final DateTime? focusedDay;
  final DateTime? selectedDay;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final DateTime? startHour;
  final DateTime? finalHour;
  final List<Field> fieldList;
  final Field selectedField;
  final RangeSelectionMode rangeSelectionMode;
  final FormzStatus formzStatus;
  final SimpleTextValidator description;

  const AvailabilityFieldState(
      {this.screenState = BasicCubitScreenState.initial,
      this.field = Field.empty,
      this.initialDate,
      this.initialHour,
      this.endDate,
      this.endHour,
      this.errorMessage,
      this.detailField = Field.empty,
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
      this.fieldList = const [],
      this.selectedField = Field.empty,
      this.formzStatus = FormzStatus.pure,
      this.description = const SimpleTextValidator.pure(),
      this.rangeSelectionMode = RangeSelectionMode.toggledOff});

  AvailabilityFieldState copyWith({
    Field? field,
    DateTime? initialDate,
    DateTime? initialHour,
    DateTime? endDate,
    DateTime? endHour,
    BasicCubitScreenState? screenState,
    String? errorMessage,
    List<Availability>? availability,
    Field? detailField,
    List<QraEvent>? selectedEvents,
    DateTime? firstDay,
    DateTime? lastDay,
    DateTime? focusedDay,
    DateTime? selectedDay,
    DateTime? rangeStart,
    DateTime? rangeEnd,
    DateTime? startHour,
    DateTime? finalHour,
    List<Field>? fieldList,
    Field? selectedField,
    RangeSelectionMode? rangeSelectionMode,
    FormzStatus? formzStatus,
    SimpleTextValidator? description,
  }) {
    return AvailabilityFieldState(
      field: field ?? this.field,
      initialDate: initialDate ?? this.initialDate,
      initialHour: initialHour ?? this.initialHour,
      endDate: endDate ?? this.endDate,
      endHour: endHour ?? this.endHour,
      screenState: screenState ?? this.screenState,
      errorMessage: errorMessage ?? this.errorMessage,
      availability: availability ?? this.availability,
      detailField: detailField ?? this.detailField,
      selectedEvents: selectedEvents ?? this.selectedEvents,
      firstDay: firstDay ?? this.firstDay,
      lastDay: lastDay ?? this.lastDay,
      focusedDay: focusedDay ?? this.focusedDay,
      selectedDay: selectedDay ?? this.selectedDay,
      rangeStart: rangeStart ?? this.rangeStart,
      rangeEnd: rangeEnd ?? this.rangeEnd,
      startHour: startHour ?? this.startHour,
      finalHour: finalHour ?? this.finalHour,
      fieldList: fieldList ?? this.fieldList,
      selectedField: selectedField ?? this.selectedField,
      rangeSelectionMode: rangeSelectionMode ?? this.rangeSelectionMode,
      formzStatus: formzStatus ?? this.formzStatus,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
        field,
        initialDate,
        initialHour,
        endDate,
        endHour,
        screenState,
        errorMessage,
        availability,
        detailField,
        selectedEvents,
        firstDay,
        lastDay,
        focusedDay,
        selectedDay,
        rangeStart,
        rangeEnd,
        startHour,
        finalHour,
        fieldList,
        selectedField,
        rangeSelectionMode,
        formzStatus,
        description,
      ];
}
