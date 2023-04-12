import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/home/availability_field/cubit/availability_field_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/enums.dart';
import '../../../../domain/agenda/entity/qra_event.dart';

class PageContent extends StatefulWidget {
  const PageContent({Key? key, required this.leagueId}) : super(key: key);

  final int leagueId;

  @override
  State<PageContent> createState() => PageContentState();
}

class PageContentState extends State<PageContent> {
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvailabilityFieldCubit, AvailabilityFieldState>(
      builder: (context, state) {
        if (state.screenState == BasicCubitScreenState.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: Colors.blue[800]!,
              size: 50,
            ),
          );
        } else if (state.screenState == BasicCubitScreenState.success) {
          return ListView(
            shrinkWrap: true,
            children: [
              TableCalendar<QraEvent>(
                locale: 'es_ES',
                firstDay: state.firstDay!,
                lastDay: state.lastDay!,
                focusedDay: state.focusedDay ?? DateTime.now(),
                calendarFormat: _calendarFormat,
                rangeStartDay: state.rangeStart,
                rangeEndDay: state.rangeEnd,
                rangeSelectionMode: state.rangeSelectionMode,
                eventLoader:
                    context.read<AvailabilityFieldCubit>().getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                onRangeSelected:
                    context.read<AvailabilityFieldCubit>().onRangeSelected,
                calendarStyle: const CalendarStyle(
                  outsideDaysVisible: false,
                ),
                selectedDayPredicate: (day) =>
                    isSameDay(state.selectedDay, day),
                onDaySelected:
                    context.read<AvailabilityFieldCubit>().onDaySelected,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged:
                    context.read<AvailabilityFieldCubit>().onPageChanged,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 15),
                  itemCount: state.selectedEvents.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Evento",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w900),
                          ),
                          ListTile(
                            onTap: () => print('evento'),
                            title: Text(
                              state.selectedEvents[index].fieldName ?? '',
                              style: const TextStyle(fontSize: 15),
                            ),
                            subtitle: Text(
                              state.selectedEvents[index].information,
                              style: const TextStyle(fontSize: 12),
                            ),
                            trailing: Text(
                              '${state.selectedEvents[index].startHourString} - ${state.selectedEvents[index].endHourString}',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
