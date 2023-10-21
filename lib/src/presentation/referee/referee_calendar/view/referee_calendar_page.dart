import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/enums.dart';
import '../../../../core/utils.dart';
import '../../../../domain/matches/dto/referee_match.dart';
import '../../../../service_locator/injection.dart';
import '../../../app/bloc/authentication_bloc.dart';
import '../cubit/referee_calendar_cubit.dart';

class RefereeCalendarPage extends StatelessWidget {
  const RefereeCalendarPage({super.key});

  static Route route() =>
      MaterialPageRoute(builder: (_) => const RefereeCalendarPage());

  @override
  Widget build(BuildContext context) {
    final referee =
        context.select((AuthenticationBloc bloc) => bloc.state.refereeData);
    return BlocProvider(
      create: (_) => locator<RefereeCalendarCubit>(),
      // ..onLoadInitialData(referee.refereeId ?? 0),
      child: _PageContent(
        refereeId: referee.refereeId ?? 0,
      ),
    );
  }
}

class _PageContent extends StatefulWidget {
  const _PageContent({Key? key, required this.refereeId}) : super(key: key);

  final int refereeId;

  @override
  State<_PageContent> createState() => _PageContentState();
}

class _PageContentState extends State<_PageContent> {
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    context.read<RefereeCalendarCubit>().onLoadInitialData(widget.refereeId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showMatchDetail(RefereeMatchDTO match) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 250,
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: ListTile(
                          title: const Text('Fecha'),
                          subtitle: Text(match.getDate),
                        ),
                      ),
                      Flexible(
                        child: ListTile(
                          title: const Text('Hora'),
                          subtitle: Text(match.getTime),
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    title: const Text('Campo'),
                    subtitle: Text(match.getFieldName),
                  ),
                  ListTile(
                    title: const Text('Encuentro'),
                    subtitle:
                        //Text('${match.getFirstTeam} VS ${match.getSecondTeam}'),
                        Text(match.partido),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

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
      body: BlocBuilder<RefereeCalendarCubit, RefereeCalendarState>(
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
              TableCalendar<RefereeMatchDTO>(
                firstDay: kFirstDay,
                locale: 'es_ES',
                lastDay: kLastDay,
                focusedDay: state.focusedDay ?? DateTime.now(),
                calendarFormat: _calendarFormat,
                rangeStartDay: state.rangeStart,
                rangeEndDay: state.rangeEnd,
                rangeSelectionMode: state.rangeSelectionMode,
                eventLoader:
                    context.read<RefereeCalendarCubit>().getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                onRangeSelected:
                    context.read<RefereeCalendarCubit>().onRangeSelected,
                calendarStyle: const CalendarStyle(
                  outsideDaysVisible: false,
                ),
                selectedDayPredicate: (day) =>
                    isSameDay(state.selectedDay, day),
                onDaySelected:
                    context.read<RefereeCalendarCubit>().onDaySelected,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged:
                    context.read<RefereeCalendarCubit>().onPageChanged,
              ),
              Expanded(
                child: ListView.builder(
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
                            onTap: () =>
                                showMatchDetail(state.selectedEvents[index]),
                            title: Text(state.selectedEvents[index].ligayTorneo,
                                style: const TextStyle(fontSize: 15)),
                            subtitle: Text(
                                state.selectedEvents[index].getFieldName,
                                style: const TextStyle(fontSize: 12)),
                            trailing: Text(
                              (state.selectedEvents[index].matchDate == null)
                                  ? "Fecha pendiente por agendar"
                                  : DateFormat('dd-MM-yyyy HH:mm').format(
                                      state.selectedEvents[index].matchDate!),
                              //: "${state.matchesList[index].fecha}",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 10),
                            ),
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
        },
      ),
    );
  }
}
