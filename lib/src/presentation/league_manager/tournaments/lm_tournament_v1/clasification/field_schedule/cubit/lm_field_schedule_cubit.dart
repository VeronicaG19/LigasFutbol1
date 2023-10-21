import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/availability.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/qra_prices.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../../core/enums.dart';
import '../../../../../../../core/utils.dart';
import '../../../../../../../domain/agenda/agenda.dart';
import '../../../../../../../domain/agenda/entity/qra_event.dart';

part 'lm_field_schedule_state.dart';

@injectable
class LmFieldScheduleCubit extends Cubit<LmFieldScheduleState> {
  LmFieldScheduleCubit(
    this._agendaService,
  ) : super(const LmFieldScheduleState());

  final List<QraEvent> _events = [];
  final IAgendaService _agendaService;

  late int _activeId;

  Future<void> onLoadActiveAvailability(
      int activeId, LMRequestType type) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    _activeId = activeId;
    final request = LMRequestType.fieldOwner == type
        ? await _agendaService.getFieldsAvailability(activeId)
        : await _agendaService.getRefereeAvailability(activeId);
    request.fold(
        (l) => emit(state.copyWith(screenState: BasicCubitScreenState.error)),
        (r) {
      r.sort((a, b) => a.openingDate!.compareTo(b.openingDate!));
      emit(state.copyWith(
          availabilityList: r, screenState: BasicCubitScreenState.loaded));
      if (r.isNotEmpty) {
        onLoadEvents(r.first, type);
      }
    });
  }

  Future<void> onLoadEvents(
      final Availability availability, final LMRequestType type) async {
    if (state.screenState == BasicCubitScreenState.sending) return;
    emit(state.copyWith(
      screenState: BasicCubitScreenState.sending,
      selectedAvailability: availability,
    ));
    _activeId = availability.activeId?.activeId ?? 0;
    final events = LMRequestType.fieldOwner == type
        ? await _agendaService.getFieldsEvents(_activeId)
        : await _agendaService.getRefereesEvents(_activeId);
    _events.clear();
    _events.addAll(events);
    emit(state.copyWith(
        selectedDay: availability.openingDate,
        focusedDay: availability.openingDate,
        selectedEvents: getEventsForDay(availability.openingDate!),
        firstDay: availability.openingDate,
        lastDay: availability.expirationDate,
        rangeStart: availability.openingDate,
        rangeEnd: availability.expirationDate,
        screenState: BasicCubitScreenState.success));
  }

  Future<void> onLoadPrices(int activeId) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    _activeId = activeId;
    final request = await _agendaService.getPricesByActive(activeId);
    request.fold(
        (l) => emit(state.copyWith(screenState: BasicCubitScreenState.error)),
        (r) {
      emit(state.copyWith(
          pricesbyActive: r, screenState: BasicCubitScreenState.loaded));
    });
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
}
