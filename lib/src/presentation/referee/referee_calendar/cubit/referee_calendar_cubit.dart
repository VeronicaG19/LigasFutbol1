import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/enums.dart';
import '../../../../core/utils.dart';
import '../../../../domain/matches/dto/referee_match.dart';
import '../../../../domain/matches/service/i_matches_service.dart';

part 'referee_calendar_state.dart';

@injectable
class RefereeCalendarCubit extends Cubit<RefereeCalendarState> {
  RefereeCalendarCubit(this._matchService)
      : super(const RefereeCalendarState());

  final IMatchesService _matchService;
  late final List<RefereeMatchDTO> _matches;

  Future<void> onLoadInitialData(int refereeId) async {
    print("id del referee $refereeId");
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    _matches =
        await _matchService.getCalendarRefereeMatches(refereeId: refereeId);
    emit(state.copyWith(
        selectedDay: kToday,
        focusedDay: kToday,
        selectedEvents: getEventsForDay(kToday),
        screenState: BasicCubitScreenState.loaded));
  }

  List<RefereeMatchDTO> getEventsForDay(DateTime day) {
    final eventSource = {
      for (var event in _matches)
        DateTime.utc(event.matchDate!.year, event.matchDate!.month,
                event.matchDate!.day):
            // List.generate(2, (index) => RefereeMatchDTO.empty)
            _addEvents(event)
    };
    final events = LinkedHashMap<DateTime, List<RefereeMatchDTO>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(eventSource);

    return events[day] ?? [];
  }

  List<RefereeMatchDTO> _addEvents(RefereeMatchDTO event) {
    return _matches
        .where((element) =>
            element.matchDate?.year == event.matchDate?.year &&
            element.matchDate?.month == event.matchDate?.month &&
            element.matchDate?.day == event.matchDate?.day)
        .toList();
  }

  List<RefereeMatchDTO> getEventsForRange(DateTime start, DateTime end) {
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
    List<RefereeMatchDTO> selectedEvents = state.selectedEvents;
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
