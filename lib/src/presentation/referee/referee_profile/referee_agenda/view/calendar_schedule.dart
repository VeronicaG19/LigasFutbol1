import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../core/enums.dart';
import '../../../../../domain/agenda/agenda.dart';
import '../cubit/referee_agenda_cubit.dart';

class CalendarSchedule extends StatelessWidget {
  const CalendarSchedule({Key? key}) : super(key: key);

  static Route route(RefereeAgendaCubit cubit) => MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: const CalendarSchedule(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const Image(
          image: AssetImage('assets/images/imageAppBar25.png'),
          fit: BoxFit.fill,
        ),
        title: const Text('Partidos por arbitrar'),
      ),
      body: const _PageContent(),
    );
  }
}

class _PageContent extends StatefulWidget {
  const _PageContent({Key? key}) : super(key: key);

  @override
  State<_PageContent> createState() => _PageContentState();
}

class _PageContentState extends State<_PageContent> {
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    context.read<RefereeAgendaCubit>().onLoadAgendaData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RefereeAgendaCubit, RefereeAgendaState>(
        builder: (context, state) {
      if (state.screenState == BasicCubitScreenState.loading) {
        return Center(
          child: LoadingAnimationWidget.fourRotatingDots(
            color: Colors.blue[800]!,
            size: 50,
          ),
        );
      }
      return Column(
        children: [
          TableCalendar<Agenda>(
            locale: 'es_ES',
            firstDay: state.initialDate!,
            lastDay: state.endDate!,
            focusedDay: state.focusedDay!,
            calendarFormat: _calendarFormat,
            rangeStartDay: state.rangeStart,
            rangeEndDay: state.rangeEnd,
            rangeSelectionMode: state.rangeSelectionMode,
            eventLoader: context.read<RefereeAgendaCubit>().getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            onRangeSelected: context.read<RefereeAgendaCubit>().onRangeSelected,
            calendarStyle: const CalendarStyle(
              outsideDaysVisible: false,
            ),
            selectedDayPredicate: (day) => isSameDay(state.selectedDay, day),
            onDaySelected: context.read<RefereeAgendaCubit>().onDaySelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: context.read<RefereeAgendaCubit>().onPageChanged,
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 15),
              itemCount: state.agendaList.length,
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
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Evento",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w900)),
                      const SizedBox(
                        height: 5,
                      ),
                      ListTile(
                        //onTap: () => print('${value[index]}'),
                        onTap: () => print('selected date'),
                        //showMatchDetail(state.selectedEvents[index]),
                        title: Text(
                            'Día ${(state.agendaList[index].day == null) ? "Sin fecha asignada" : DateFormat('dd-MM-yyyy ').format(state.agendaList[index].day!)}',
                            style: const TextStyle(fontSize: 15)),
                        subtitle: Text(
                          'Horario de ${DateFormat('HH:mm').format(state.agendaList[index].startHour!)} a ${DateFormat('HH:mm').format(state.agendaList[index].endHour!)}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        // trailing: Text(
                        //   (state.selectedEvents[index].matchDate == null)
                        //       ? "Fecha pendiente por agendar"
                        //       : DateFormat('dd-MM-yyyy HH:mm').format(state
                        //           .selectedEvents[index].matchDate as DateTime),
                        //   //: "${state.matchesList[index].fecha}",
                        //   textAlign: TextAlign.left,
                        //   style: const TextStyle(
                        //       fontWeight: FontWeight.w500, fontSize: 10),
                        // ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
