part of 'field_owner_schedule_cubit.dart';

class FieldOwnerScheduleState extends Equatable {
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
  final List<Field> fieldList;
  final List<QualificationByMatch> quaLifications;
  final Field selectedField;
  final RangeSelectionMode rangeSelectionMode;
  final FormzStatus formzStatus;
  final SimpleTextValidator description;
  final String? errorMessage;

  const FieldOwnerScheduleState({
    this.quaLifications = const [],
    this.selectedEvents = const [],
    this.screenState = BasicCubitScreenState.initial,
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
    this.rangeSelectionMode = RangeSelectionMode.toggledOff,
    this.errorMessage,
  });

  FieldOwnerScheduleState copyWith({
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
    List<Field>? fieldList,
    Field? selectedField,
    RangeSelectionMode? rangeSelectionMode,
    FormzStatus? formzStatus,
    SimpleTextValidator? description,
    String? errorMessage,
    List<QualificationByMatch>? quaLifications
  }) {
    return FieldOwnerScheduleState(
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
      fieldList: fieldList ?? this.fieldList,
      selectedField: selectedField ?? this.selectedField,
      rangeSelectionMode: rangeSelectionMode ?? this.rangeSelectionMode,
      formzStatus: formzStatus ?? this.formzStatus,
      description: description ?? this.description,
      errorMessage: errorMessage ?? this.errorMessage,
      quaLifications: quaLifications ?? this.quaLifications
    );
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
        fieldList,
        selectedField,
        rangeSelectionMode,
        formzStatus,
        description,
        quaLifications
      ];
}
