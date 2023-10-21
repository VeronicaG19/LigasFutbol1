import 'dart:collection';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/agenda.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/qra_active.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../core/enums.dart';
import '../../../../../core/utils.dart';
import '../../../../../domain/agenda/entity/availability.dart';

part 'referee_agenda_state.dart';

@Injectable()
class RefereeAgendaCubit extends Cubit<RefereeAgendaState> {
  RefereeAgendaCubit(this._service) : super(const RefereeAgendaState());
  final IAgendaService _service;
  final List<Agenda> _agenda = [];

  void onChangeInitialDate(DateTime dateTime) {
    emit(state.copyWith(initialDate: dateTime));
  }

  void onChangeInitialHour(DateTime dateTime) {
    emit(state.copyWith(initialHour: dateTime));
  }

  void onChangeEndHour(DateTime dateTime) {
    emit(state.copyWith(endHour: dateTime));
  }

  void onChangeFinalDate(DateTime dateTime) {
    emit(state.copyWith(
        endDate: DateTime(dateTime.year, dateTime.month, dateTime.day, 1)));
  }

  void onSelectDay(DaysEnum day) {
    List<DaysEnum> list = [];
    list.addAll(state.selectedDays);
    emit(state.copyWith(selectedDays: []));
    if (list.contains(day)) {
      list.remove(day);
    } else {
      list.add(day);
    }
    emit(state.copyWith(selectedDays: list));
  }

  void setItemsNow() {
    emit(state.copyWith(
      initialDate: DateTime.now(),
      endDate: DateTime.now(),
      initialHour: DateTime.now(),
      endHour: DateTime.now(),
    ));
  }

  Future<void> onLoadInitialData(int refereeId) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final request = await _service.getRefereeAvailability(refereeId);
    request.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.errorMessage,
            screenState: BasicCubitScreenState.error)),
        (r) => emit(state.copyWith(
            availabilityList: r, screenState: BasicCubitScreenState.loaded)));
  }

  Future<void> onLoadAgendaData() async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final request = await _service
        .getRefereeAgenda(state.selectedAvailability.availabilityId);
    _agenda.clear();
    request.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.errorMessage,
            selectedAvailability: Availability.empty,
            screenState: BasicCubitScreenState.error)), (r) {
      _agenda.addAll(r);

      emit(state.copyWith(
          initialDate: state.initialDate!,
          endDate: state.endDate!,
          focusedDay: state.focusedDay!,
          selectedAvailability: Availability.empty,
          agendaList: getEventsForDay(DateTime.now()),
          screenState: BasicCubitScreenState.loaded));
    });
  }

  void onSelectAvailability(Availability availability) {
    emit(state.copyWith(
        selectedAvailability: availability,
        initialDate: availability.openingDate!,
        focusedDay: availability.openingDate!,
        selectedDay: null,
        rangeStart: null,
        rangeEnd: null,
        endDate: availability.expirationDate!));
  }

  List<Agenda> getEventsForDay(DateTime day) {
    final eventSource = {
      for (var event in _agenda)
        DateTime.utc(event.day!.year, event.day!.month, event.day!.day):
            _addEvents(event)
    };
    final events = LinkedHashMap<DateTime, List<Agenda>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(eventSource);

    return events[day] ?? [];
  }

  List<Agenda> _addEvents(Agenda event) {
    return _agenda
        .where((element) =>
            element.day?.year == event.day?.year &&
            element.day?.month == event.day?.month &&
            element.day?.day == event.day?.day)
        .toList();
  }

  List<Agenda> getEventsForRange(DateTime start, DateTime end) {
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
          agendaList: getEventsForDay(selectedDay),
        ),
      );
    }
  }

  void onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    List<Agenda> selectedEvents = state.agendaList;
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
        agendaList: selectedEvents,
      ),
    );
  }

  Future<void> saveAgendaData(int activeId, int refereeId, int partyId) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    if (state.initialDate != null &&
        state.endDate != null &&
        state.initialHour != null &&
        state.endHour != null) {
      bool valDate = state.initialDate!.isBefore(state.endDate!);
      bool valHour = state.initialHour!.isBefore(state.endHour!);
      if (!valDate) {
        emit(state.copyWith(
            screenState: BasicCubitScreenState.error,
            errorMessage:
                'La fecha fin debe de ser mayor que la fecha inicio'));
        return;
      }
      if (!valHour) {
        emit(state.copyWith(
            screenState: BasicCubitScreenState.error,
            errorMessage: 'La hora fin debe de ser mayor que la hora inicio'));
        return;
      }
      Availability availabilityData = Availability(
        partyId: partyId,
        hourClose: state.endHour,
        hourOpen: state.initialHour,
        status: 0,
        activeId: QraActive(activeId: activeId),
        availabilityId: 0,
        openingDate: state.initialDate,
        expirationDate: state.endDate,
      );
      final request = await _service.createAvailability(availabilityData);
      request.fold(
          (l) => emit(state.copyWith(
              errorMessage: _getAvailabilityErrorResponse(
                  jsonDecode(l.data ?? '')['status']),
              screenState: BasicCubitScreenState.error)), (r) {
        _agenda.clear();
        emit(state.copyWith(
          screenState: BasicCubitScreenState.success,
        ));
      });
      onLoadInitialData(refereeId);
    } else {
      emit(state.copyWith(screenState: BasicCubitScreenState.emptyData));
    }
  }

  String _getAvailabilityErrorResponse(final int? status) {
    switch (status) {
      case -1:
        return 'Error al guardar';
      case -2:
        return 'Este rango de fecha ya está ocupado';
      case -3:
        return 'El activo no existe';
      case -4:
        return 'Hay datos faltantes';
      default:
        return 'Ha ocurrido un error';
    }
  }
}
