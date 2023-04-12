import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/agenda.dart';
import 'package:ligas_futbol_flutter/src/domain/referee/service/i_referee_service.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../core/enums.dart';
import '../../../../../../core/utils.dart';
import '../../../../../../core/validators/simple_text_validator.dart';
import '../../../../../../domain/agenda/entity/availability.dart';
import '../../../../../../domain/agenda/entity/qra_event.dart';
import '../../../../../../domain/referee/entity/referee.dart';
import '../../../../../../domain/referee/entity/referee_by_league_dto.dart';
import '../../../../../../domain/referee/entity/referee_detail_dto.dart';

part 'availability_referee_state.dart';

@injectable
class AvailabilityRefereeCubit extends Cubit<AvailabilityRefereeState> {
  AvailabilityRefereeCubit(
      this._service, this._agendaService, this._refereeService)
      : super(AvailabilityRefereeState());

  final IRefereeService _service;

  final IAgendaService _agendaService;
  final IRefereeService _refereeService;

  final List<QraEvent> _events = [];
  late final RefereeDetailDTO detailRefereeOwner;
  late final Referee referee;
  Future<void> detailReferee({required int refereeId}) async {
    print("paso 1");
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final response = await _service.getRefereeDetail(refereeId);
    response.fold(
        (l) => emit(state.copyWith(
            screenState: BasicCubitScreenState.error,
            errorMessage: l.errorMessage)), (r) async {
      print("paso 2");

      detailRefereeOwner = r;
      final request = await _agendaService.getRefereeAvailability(r.refereeId);
      request.fold(
          (l) => emit(state.copyWith(
              screenState: BasicCubitScreenState.error,
              errorMessage: l.errorMessage)), (r) {
        print("paso 3");
        emit(state.copyWith(
            screenState: BasicCubitScreenState.loaded,
            detailReferee: detailRefereeOwner,
            availability: r));
      });
    });
  }

  Future<void> onLoadInitialData(
      final Availability availability, final int leagueId) async {
    print("correcto");
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final activeIDD = await _refereeService.getRefereeDetail(detailRefereeOwner.refereeId);
    final events =
        await _agendaService.getRefereesEvents(availability.activeId!.activeId);
    final referees = await _refereeService.getRefereeByLeague(leagueId);
    print('Longitud------> ${events.length}');
    _events.clear();
    _events.addAll(events);
    // _events.addAll(events);
    final f = referees.getOrElse(() => []);
    emit(state.copyWith(
        selectedDay: availability.openingDate,
        focusedDay: availability.openingDate,
        selectedEvents: getEventsForDay(availability.openingDate!),
        firstDay:
            availability.openingDate, //!.subtract(const Duration(days: 1)),
        lastDay: availability.expirationDate, //!.add(const Duration(days: 1)),
        refereeList: f,
        selectedReferee: f.isNotEmpty ? f.first : RefereeByLeagueDTO.empty,
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
