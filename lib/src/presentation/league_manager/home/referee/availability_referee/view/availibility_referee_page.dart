import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/qra_event.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';
import 'package:ligas_futbol_flutter/src/presentation/widgets/app_bar_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../service_locator/injection.dart';
import '../cubit/availability_referee_cubit.dart';

class AvailabilityRefereePage extends StatelessWidget {
  const AvailabilityRefereePage({Key? key, required this.refereeId})
      : super(key: key);
  final int? refereeId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: const PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBarPage(
          title: "Disponibilidad de árbitro",
          size: 100,
        ),
      ),
      body: DetailRefereeContent(refereeId: refereeId!),
    );
  }
}

class DetailRefereeContent extends StatelessWidget {
  const DetailRefereeContent({Key? key, required this.refereeId})
      : super(key: key);
  final int refereeId;
  @override
  Widget build(BuildContext context) {
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
    return BlocProvider(
      create: (_) => locator<AvailabilityRefereeCubit>()
        ..detailReferee(refereeId: refereeId),
      child: BlocBuilder<AvailabilityRefereeCubit, AvailabilityRefereeState>(
          builder: (context, state) {
        if (state.screenState == BasicCubitScreenState.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: const Color(0xff358aac),
              size: 50,
            ),
          );
        }
        return ListView(shrinkWrap: true, children: [
          Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    left: 30,
                    right: 30,
                    bottom: 8,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text("Nombre: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800)),
                              Text(
                                  //state.detailField!.fieldName ??
                                  state.detailReferee?.refereeName ??
                                      'Sin nombre',
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: AvailabilityList(),
                  ),
                  SizedBox(width: 40),
                  Expanded(
                    flex: 3,
                    child: PageContent(leagueId: leagueManager.leagueId),
                  )
                ],
              ),
            ],
          ),
        ]);
      }),
    );
  }
}

class AvailabilityList extends StatefulWidget {
  const AvailabilityList({Key? key}) : super(key: key);

  @override
  State<AvailabilityList> createState() => _AvailabilityListState();
}

class _AvailabilityListState extends State<AvailabilityList> {
  String? selectedValue1;
  @override
  Widget build(BuildContext context) {
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
    return BlocConsumer<AvailabilityRefereeCubit, AvailabilityRefereeState>(
      listener: (context, state) {
        if (state.screenState == BasicCubitScreenState.error) {
          AnimatedSnackBar.rectangle(
            'Error',
            'No se pudo cargar la información',
            type: AnimatedSnackBarType.error,
            brightness: Brightness.light,
          ).show(
            context,
          );
        }
      },
      builder: (context, state) {
        const noDateLabel = 'Sin fecha asignada';

        return state.availability!.isEmpty
            ? const Center(
                child: Text('Sin disponibilidad'),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: state.availability!.length,
                itemBuilder: (context, index) {
                  final item = state.availability![index];
                  const noDateLabel = 'Sin fecha asignada';
                  final firstDate = item.openingDate == null
                      ? noDateLabel
                      : DateFormat('dd-MM-yyyy HH:mm')
                          .format(item.openingDate!);
                  final secondDate = item.expirationDate == null
                      ? noDateLabel
                      : DateFormat('dd-MM-yyyy HH:mm')
                          .format(item.expirationDate!);
                  return Column(
                    children: [
                      const Divider(),
                      ListTile(
                        title: const Text('Periodo de fecha disponible'),
                        subtitle: Text('$firstDate a $secondDate'),
                        onTap: () {
                          context
                              .read<AvailabilityRefereeCubit>()
                              .onLoadInitialData(state.availability![index],
                                  leagueManager.leagueId);
                        },
                      ),
                      const Divider()
                    ],
                  );
                },
              );
      },
    );
  }
}

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
    return BlocBuilder<AvailabilityRefereeCubit, AvailabilityRefereeState>(
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
                    context.read<AvailabilityRefereeCubit>().getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                onRangeSelected:
                    context.read<AvailabilityRefereeCubit>().onRangeSelected,
                calendarStyle: const CalendarStyle(
                  outsideDaysVisible: false,
                ),
                selectedDayPredicate: (day) =>
                    isSameDay(state.selectedDay, day),
                onDaySelected:
                    context.read<AvailabilityRefereeCubit>().onDaySelected,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged:
                    context.read<AvailabilityRefereeCubit>().onPageChanged,
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
