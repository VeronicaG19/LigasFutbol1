import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/core/utils.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../../domain/agenda/entity/qra_event.dart';
import '../cubit/lm_field_schedule_cubit.dart';

class FieldScheduleDialog extends StatelessWidget {
  const FieldScheduleDialog({Key? key, required this.type}) : super(key: key);
  final LMRequestType type;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(25),
      title: Text(
          'Disponibilidad del ${type.name == LMRequestType.fieldOwner.name ? 'campo' : 'árbitro'}'),
      content: BlocBuilder<LmFieldScheduleCubit, LmFieldScheduleState>(
        builder: (context, state) {
          if (state.screenState == BasicCubitScreenState.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.blue[800]!,
                size: 50,
              ),
            );
          }
          return state.availabilityList.isEmpty
              ? const Center(
                  child: Text('No hay disponibilidad'),
                )
              : type.name == LMRequestType.fieldOwner.name
                  ? Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 600,
                            width: 400,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.availabilityList.length,
                              itemBuilder: (context, index) {
                                final item = state.availabilityList[index];
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
                                      title: const Text(
                                          'Periodo de fecha disponible'),
                                      subtitle:
                                          Text('$firstDate a $secondDate'),
                                      onTap: () => context
                                          .read<LmFieldScheduleCubit>()
                                          .onLoadEvents(item),
                                    ),
                                    const Divider()
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        const Expanded(
                          child: SizedBox(
                            height: 600,
                            width: 800,
                            child: _CalendarSchedule(),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 600,
                            width: 400,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.availabilityList.length,
                              itemBuilder: (context, index) {
                                final item = state.availabilityList[index];
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
                                      title: const Text(
                                          'Periodo de fecha disponible'),
                                      subtitle:
                                          Text('$firstDate a $secondDate'),
                                      onTap: () => context
                                          .read<LmFieldScheduleCubit>()
                                          .onLoadEvents(item),
                                    ),
                                    const Divider()
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        const Expanded(
                          child: SizedBox(
                            height: 600,
                            width: 800,
                            child: _CalendarSchedule(),
                          ),
                        ),
                      ],
                    );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('ACEPTAR'),
        ),
      ],
    );
  }
}

class _CalendarSchedule extends StatefulWidget {
  const _CalendarSchedule({Key? key}) : super(key: key);

  @override
  State<_CalendarSchedule> createState() => _CalendarScheduleState();
}

class _CalendarScheduleState extends State<_CalendarSchedule> {
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
    return BlocBuilder<LmFieldScheduleCubit, LmFieldScheduleState>(
      builder: (context, state) {
        if (BasicCubitScreenState.sending == state.screenState) {
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
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: state.focusedDay ?? DateTime.now(),
              calendarFormat: _calendarFormat,
              rangeStartDay: state.rangeStart,
              rangeEndDay: state.rangeEnd,
              rangeSelectionMode: state.rangeSelectionMode,
              eventLoader: context.read<LmFieldScheduleCubit>().getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              onRangeSelected:
                  context.read<LmFieldScheduleCubit>().onRangeSelected,
              calendarStyle: const CalendarStyle(
                outsideDaysVisible: false,
              ),
              selectedDayPredicate: (day) => isSameDay(state.selectedDay, day),
              onDaySelected: context.read<LmFieldScheduleCubit>().onDaySelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: context.read<LmFieldScheduleCubit>().onPageChanged,
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
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
