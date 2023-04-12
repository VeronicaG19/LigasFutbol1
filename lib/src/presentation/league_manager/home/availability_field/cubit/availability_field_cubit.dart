import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/core/utils.dart';
import 'package:ligas_futbol_flutter/src/core/validators/simple_text_validator.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/agenda.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/availability.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/qra_event.dart';
import 'package:ligas_futbol_flutter/src/domain/field/entity/field.dart';
import 'package:ligas_futbol_flutter/src/domain/field/service/i_field_service.dart';
import 'package:table_calendar/table_calendar.dart';

part 'availability_field_state.dart';

@injectable
class AvailabilityFieldCubit extends Cubit<AvailabilityFieldState> {
  AvailabilityFieldCubit(this._agendaService, this._service, this._fieldService)
      : super(AvailabilityFieldState());

  final IAgendaService _agendaService;
  final IFieldService _service;
  final List<QraEvent> _events = [];
  final IFieldService _fieldService;
  late final Field detailFieldOwner;
  Future<void> detailField({required int fieldId}) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final response = await _service.getFieldByFieldId(fieldId);
    response.fold(
        (l) => emit(state.copyWith(
            screenState: BasicCubitScreenState.error,
            errorMessage: l.errorMessage)), (r) async {
      print("Datos ${r}");
      detailFieldOwner = r;
      final request = await _agendaService.getFieldsAvailability(r.activeId!);
      request.fold(
          (l) => emit(state.copyWith(
              screenState: BasicCubitScreenState.error,
              errorMessage: l.errorMessage)), (r) {
        emit(state.copyWith(
            screenState: BasicCubitScreenState.loaded,
            detailField: detailFieldOwner,
            availability: r));
      });
    });
  }

  Future<void> onLoadInitialData(
      final Availability availability, final int leagueId) async {
    print("correcto");
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));

    final events =
        await _agendaService.getFieldsEvents(detailFieldOwner.activeId!);
    final fields = await _fieldService.getFieldsByLeagueId(leagueId);
    print('Longitud------> ${events.length}');
    _events.clear();
    _events.addAll(events);
    final f = fields.getOrElse(() => []);
    emit(state.copyWith(
        selectedDay: availability.openingDate,
        focusedDay: availability.openingDate,
        selectedEvents: getEventsForDay(availability.openingDate!),
        firstDay:
            availability.openingDate, //!.subtract(const Duration(days: 1)),
        lastDay: availability.expirationDate, //!.add(const Duration(days: 1)),
        fieldList: f,
        selectedField: f.isNotEmpty ? f.first : Field.empty,
        screenState: BasicCubitScreenState.success));
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

    return events[day] ?? [];
  }

  List<QraEvent> _addEvents(QraEvent event) {
    return _events
        .where((element) =>
            element.dateEvent?.year == event.dateEvent?.year &&
            element.dateEvent?.month == event.dateEvent?.month &&
            element.dateEvent?.day == event.dateEvent?.day)
        .toList();
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

  List<QraEvent> getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    return [
      for (final d in days) ...getEventsForDay(d),
    ];
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

  void onPageChanged(DateTime focusedDay) {
    emit(state.copyWith(focusedDay: focusedDay));
  }
}
