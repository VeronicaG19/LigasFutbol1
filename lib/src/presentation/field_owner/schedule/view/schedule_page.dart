import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/schedule/view/widgets/ratting_row.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/enums.dart';
import '../../../../domain/agenda/entity/availability.dart';
import '../../../../domain/agenda/entity/qra_event.dart';
import '../../../../service_locator/injection.dart';
import '../../../app/app.dart';
import '../../matchs_info/match_detail_page.dart';
import '../cubit/field_owner_schedule_cubit.dart';
import 'm_new_event.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key, required this.availability}) : super(key: key);

  static Route route(final Availability availability) => MaterialPageRoute(
      builder: (_) => SchedulePage(
            availability: availability,
          ));

  final Availability availability;

  @override
  Widget build(BuildContext context) {
    final leagueId =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
    return BlocProvider(
      create: (_) => locator<FieldOwnerScheduleCubit>(),
      child: _PageContent(
        leagueId: leagueId.leagueId,
        activeId: availability,
      ),
    );
  }
}

class _PageContent extends StatefulWidget {
  const _PageContent({Key? key, required this.leagueId, required this.activeId})
      : super(key: key);

  final int leagueId;
  final Availability activeId;

  @override
  State<_PageContent> createState() => _PageContentState();
}

class _PageContentState extends State<_PageContent> {
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    context
        .read<FieldOwnerScheduleCubit>()
        .onLoadInitialData(widget.activeId, widget.leagueId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const Image(
          image: AssetImage('assets/images/imageAppBar25.png'),
          fit: BoxFit.fill,
        ),
        title: const Text('Partidos reservados'),
      ),
      body: BlocBuilder<FieldOwnerScheduleCubit, FieldOwnerScheduleState>(
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
                    context.read<FieldOwnerScheduleCubit>().getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                onRangeSelected:
                    context.read<FieldOwnerScheduleCubit>().onRangeSelected,
                calendarStyle: const CalendarStyle(
                  outsideDaysVisible: false,
                ),
                selectedDayPredicate: (day) =>
                    isSameDay(state.selectedDay, day),
                onDaySelected:
                    context.read<FieldOwnerScheduleCubit>().onDaySelected,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged:
                    context.read<FieldOwnerScheduleCubit>().onPageChanged,
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
                          const SizedBox(width: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    RattingRow(
                                        rating: context
                                            .read<FieldOwnerScheduleCubit>()
                                            .getQualificationPerEventAndType(
                                                state.selectedEvents[index]
                                                    .eventId!,
                                                'PLAYER_TO_FIELD'),
                                        subTitle: 'Jugadores'),
                                    const SizedBox(height: 5),
                                    RattingRow(
                                        rating: context
                                            .read<FieldOwnerScheduleCubit>()
                                            .getQualificationPerEventAndType(
                                                state.selectedEvents[index]
                                                    .eventId!,
                                                'REFEREE_TO_FIELD'),
                                        subTitle: 'Arbitro'),
                                    const SizedBox(height: 19),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: (context
                                        .read<FieldOwnerScheduleCubit>()
                                        .getMatchId(state
                                            .selectedEvents[index].eventId!)) >
                                    0,
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      int matchiD = context
                                          .read<FieldOwnerScheduleCubit>()
                                          .getMatchId(state
                                              .selectedEvents[index].eventId!);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MatchDetailTabBar(
                                            matchId: matchiD,
                                            fieldId: state
                                                .selectedEvents[index].fieldId!,
                                            eventId: state
                                                .selectedEvents[index].eventId!,
                                          ),
                                        ),
                                      );
                                    },
                                    child: CircleAvatar(
                                      child: Icon(
                                        Icons.info,
                                        color: Colors.white,
                                      ),
                                      backgroundColor: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 19),
                            ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            builder: (_) {
              return BlocProvider.value(
                value: BlocProvider.of<FieldOwnerScheduleCubit>(context),
                child: const NewEvent(),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
