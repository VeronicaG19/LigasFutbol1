import 'dart:collection';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/validators/simple_text_validator.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/availability.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/enums.dart';
import '../../../../core/utils.dart';
import '../../../../domain/agenda/agenda.dart';
import '../../../../domain/agenda/entity/qra_event.dart';
import '../../../../domain/field/entity/field.dart';
import '../../../../domain/field/service/i_field_service.dart';
import '../../../../domain/topic_evaluation/qualificationByMatchEntity/QualificationByMatch.dart';
import '../../../../domain/topic_evaluation/service/i_topic_evaluation_service.dart';

part 'field_owner_schedule_state.dart';

@injectable
class FieldOwnerScheduleCubit extends Cubit<FieldOwnerScheduleState> {
  FieldOwnerScheduleCubit(this._fieldService, this._agendaService, this._topicEvaluationService)
      : super(const FieldOwnerScheduleState());

  final List<QraEvent> _events = [];
  final IFieldService _fieldService;
  final IAgendaService _agendaService;
  final ITopicEvaluationService _topicEvaluationService;

  late int activeId;

  Future<void> onLoadInitialData(
      final Availability availability, final int leagueId) async {
    print("correcto");
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    activeId = availability.activeId?.activeId ?? 0;
    final events = await _agendaService.getFieldsEvents(activeId);
    final fields = await _fieldService.getFieldsByLeagueId(leagueId);
    print('Longitud------> ${events.length}');
    _events.clear();
    _events.addAll(events);
    final f = fields.getOrElse(() => []);
    events.forEach((element) {
      onGetQalifications(element.eventId!);
     });
    emit(state.copyWith(
        selectedDay: availability.openingDate,
        focusedDay: availability.openingDate,
        selectedEvents: getEventsForDay(availability.openingDate!),
        firstDay:
            availability.openingDate, //!.subtract(const Duration(days: 1)),
        lastDay: availability.expirationDate, //!.add(const Duration(days: 1)),
        fieldList: f,
        selectedField: f.isNotEmpty ? f.first : Field.empty,
        screenState: BasicCubitScreenState.loaded));
  }

  Future<void> onReloadEvents() async {
    _events.clear();
    emit(state.copyWith(
        screenState: BasicCubitScreenState.loading, selectedEvents: []));
    final events = await _agendaService.getFieldsEvents(activeId);

    _events.addAll(events);
    
    emit(state.copyWith(
        selectedEvents: getEventsForDay(state.focusedDay!),
        screenState: BasicCubitScreenState.loaded));
  }

  Future<void> onGetQalifications(int eventId) async{
     //emit(state.copyWith(screenState: BasicCubitScreenState.loading));
     final calficicatiosn = await _topicEvaluationService.getTopicsEvaluationByTypeId(eventId, typeId: 'EVENT');
      List<QualificationByMatch> cals = List.from(state.quaLifications) ;
     calficicatiosn.fold((l) => {}, (r) {
       for (var calification in r) { 
         calification = calification.copyWith(
            eventId: eventId
          );
          cals.add(calification);
          //cals.add(calification);
       }
        
     });
     emit(state.copyWith(quaLifications :cals));
  }



  // Future<void> onLoadCalendarData(int activeId) async {
  //   emit(state.copyWith(screenState: BasicCubitScreenState.loading));
  //   final request = await _agendaService.getFieldsEvents(activeId);
  //   _events.clear();
  //   _events.addAll(request);
  //   emit(state.copyWith(
  //       focusedDay: state.firstDay!.add(const Duration(days: 1)),
  //       selectedEvents: getEventsForDay(DateTime.now()),
  //       screenState: BasicCubitScreenState.loaded));
  // }

  void onChangeField(Field field) {
    emit(state.copyWith(selectedField: field));
  }

  void onDescriptionChanged(String value) {
    final description = SimpleTextValidator.dirty(value);
    emit(state.copyWith(
        description: description, formzStatus: Formz.validate([description])));
  }

  Future<void> onSubmitEvent() async {
    if (!state.formzStatus.isValidated) {
      emit(state.copyWith(
          formzStatus: FormzStatus.submissionFailure,
          screenState: BasicCubitScreenState.emptyData));
      return;
    }
    emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));
    if (state.startHour != null && state.finalHour != null) {
      bool valHour = state.startHour!.isBefore(state.finalHour!);
      if (!valHour) {
        emit(state.copyWith(
            formzStatus: FormzStatus.submissionFailure,
            errorMessage: 'La hora fin debe de ser mayor que la hora inicio'));
        return;
      }
      // if (state.selectedField == Field.empty) {
      //   emit(state.copyWith(
      //       formzStatus: FormzStatus.submissionFailure,
      //       errorMessage: 'Selecciona un campo'));
      //   return;
      // }
      final event = QraEvent.empty.copyWith(
        activeId: activeId,
        assignmentStatus: 'SEND',
        pediod: TimeType.MONTHLY,
        currency: Currency.MXN,
        endDate: state.selectedDay,
        endHour: state.finalHour,
        information: state.description.value,
        startDate: state.selectedDay,
        startHour: state.startHour,
        status: 1,
        subject: state.description.value,
      );
      final request = await _agendaService.createQraEvents(event);
      request.fold(
          (l) => emit(state.copyWith(
              formzStatus: FormzStatus.submissionFailure,
              screenState: BasicCubitScreenState.error,
              errorMessage: l.errorMessage)),
          (r) =>
              emit(state.copyWith(formzStatus: FormzStatus.submissionSuccess)));
    } else {
      emit(state.copyWith(
          formzStatus: FormzStatus.submissionFailure,
          screenState: BasicCubitScreenState.emptyData));
    }
  }

  List<QraEvent> getEventsForDay(DateTime day) {
    final eventSource = {
      for (var event in _events)
        DateTime.utc(event.dateEvent!.year, event.dateEvent!.month,
            event.dateEvent!.day): _addEvents(event)
    };
   
    final events = LinkedHashMap<DateTime, List<QraEvent>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(eventSource);

    print('events ${events[day]?? []}');
    return events[day] ?? [];
  }

  double getQualificationPerEventAndType(int eventId, String qualType) {
    int index = state.quaLifications.indexWhere((calification) => calification.eventId == eventId && calification.typeEvaluation ==qualType );

    if(index >= 0){
      return state.quaLifications[index].qualification!;
    }else{
      return 0.0;
    }
  }


  int getMatchId(int eventId) {
    int index = state.quaLifications.indexWhere((calification) => calification.eventId == eventId );

    if(index >= 0){
      return state.quaLifications[index].matchId!;
    }else{
      return 0;
    }
  }

  

  List<QraEvent> _addEvents(QraEvent event) {
    return _events
        .where((element) =>
            element.dateEvent?.year == event.dateEvent?.year &&
            element.dateEvent?.month == event.dateEvent?.month &&
            element.dateEvent?.day == event.dateEvent?.day)
        .toList();
  }

  List<QraEvent> getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    return [
      for (final d in days) ...getEventsForDay(d),
    ];
  }

  void onPageChanged(DateTime focusedDay) {
    emit(state.copyWith(focusedDay: focusedDay));
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(state.selectedDay, selectedDay)) {
      emit(
        state.copyWith(
          selectedDay: selectedDay,
          focusedDay: focusedDay,
          rangeStart: null,
          rangeEnd: null,
          selectedEvents: getEventsForDay(selectedDay),
        ),
      );
    }
  }

  void onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    List<QraEvent> selectedEvents = state.selectedEvents;
    if (start != null && end != null) {
      selectedEvents = getEventsForRange(start, end);
    } else if (start != null) {
      selectedEvents = getEventsForDay(start);
    } else if (end != null) {
      selectedEvents = getEventsForDay(end);
    }
    emit(
      state.copyWith(
        selectedDay: null,
        focusedDay: focusedDay,
        rangeStart: start,
        rangeEnd: end,
        rangeSelectionMode: RangeSelectionMode.toggledOn,
        selectedEvents: selectedEvents,
      ),
    );
  }

  void onChangeInitialHour(DateTime dateTime) {
    emit(state.copyWith(startHour: dateTime));
  }

  void onChangeEndHour(DateTime dateTime) {
    emit(state.copyWith(finalHour: dateTime));
  }
}
