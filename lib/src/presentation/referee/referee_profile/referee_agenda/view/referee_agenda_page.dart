import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
//import 'package:time_pickerr/time_pickerr.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../../core/enums.dart';
import '../../../../../service_locator/injection.dart';
import '../../../../app/bloc/authentication_bloc.dart';
import '../cubit/referee_agenda_cubit.dart';
import 'calendar_schedule.dart';

class RefereeAgendaPage extends StatelessWidget {
  const RefereeAgendaPage({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (_) => const RefereeAgendaPage());

  @override
  Widget build(BuildContext context) {
    final referee =
        context.select((AuthenticationBloc bloc) => bloc.state.refereeData);
    return BlocProvider(
      create: (_) => locator<RefereeAgendaCubit>()
        ..onLoadInitialData(referee.refereeId ?? 0),
      child: const _AgendaContent(),
    );
  }
}

class _AgendaContent extends StatelessWidget {
  const _AgendaContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color? color = Colors.blue[800];
    final Color? color2 = Colors.green[800];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mi agenda',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        flexibleSpace: const Image(
          image: AssetImage('assets/images/imageAppBar25.png'),
          fit: BoxFit.fill,
        ),
        elevation: 0.0,
      ),
      body: BlocConsumer<RefereeAgendaCubit, RefereeAgendaState>(
        listenWhen: (previous, current) =>
            previous.selectedAvailability != current.selectedAvailability,
        listener: (context, state) {
          if (state.selectedAvailability.isNotEmpty) {
            Navigator.push(
                context,
                CalendarSchedule.route(
                    BlocProvider.of<RefereeAgendaCubit>(context)));
          }
        },
        builder: (context, state) {
          if (state.screenState == BasicCubitScreenState.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: const Color(0xff358aac),
                size: 50,
              ),
            );
          }
          return state.availabilityList.isEmpty
              ? const Center(
                  child: Text('Sin contenido'),
                )
              : ListView.builder(
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
                          title: const Text('Periodo de fecha disponible'),
                          subtitle: Text('$firstDate a $secondDate'),
                          onTap: () {
                            context
                                .read<RefereeAgendaCubit>()
                                .onSelectAvailability(item);
                          },
                        ),
                        const Divider()
                      ],
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff358aac),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) {
              return BlocProvider.value(
                value: BlocProvider.of<RefereeAgendaCubit>(context),
                child: BlocConsumer<RefereeAgendaCubit, RefereeAgendaState>(
                  listenWhen: (previous, current) =>
                      previous.screenState != current.screenState,
                  listener: (context, state) {
                    if (state.screenState == BasicCubitScreenState.success) {
                      showTopSnackBar(
                        context,
                        CustomSnackBar.success(
                          backgroundColor: color2!,
                          textScaleFactor: 1.0,
                          message:
                              "Se creo correctamente el nuevo horario del árbitro",
                        ),
                      );
                      context.read<RefereeAgendaCubit>().setItemsNow();
                      Navigator.pop(context);
                    } else if (state.screenState ==
                        BasicCubitScreenState.error) {
                      showTopSnackBar(
                        context,
                        CustomSnackBar.success(
                          backgroundColor: color2!,
                          textScaleFactor: 1.0,
                          message: state.errorMessage!,
                        ),
                      );
                    } else if (state.screenState ==
                        BasicCubitScreenState.emptyData) {
                      showTopSnackBar(
                        context,
                        CustomSnackBar.info(
                          backgroundColor: color!,
                          textScaleFactor: 1.0,
                          message: "Favor de llenar todos los datos",
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const SizedBox(
                            height: 25,
                            child: Text('Crear nuevo horario',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900)),
                          ),
                          const SizedBox(
                            height: 35,
                            child: Text(
                                'Seleccione los siguientes campos para crear un nuevo horario del árbitro',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                          ),
                          // const _DaysListContainer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: TextButton.icon(
                                    icon: const Icon(Icons.date_range,
                                        color: Color(0xff358aac)),
                                    onPressed: () async {
                                      final selected = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2025),
                                      );
                                      const mounted = true;
                                      if (!mounted) return;
                                      context
                                          .read<RefereeAgendaCubit>()
                                          .onChangeInitialDate(selected!);
                                    },
                                    label: BlocBuilder<RefereeAgendaCubit,
                                        RefereeAgendaState>(
                                      builder: (context, state) {
                                        return Text(
                                          'Fecha inicio: \n${state.initialDate != null ? DateFormat('dd-MM-yyyy').format(state.initialDate!) : 'Sin asignar'}',
                                          style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: TextButton.icon(
                                    icon: const Icon(Icons.date_range,
                                        color: Color(0xff358aac)),
                                    onPressed: () async {
                                      final selected = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2025),
                                      );
                                      const mounted = true;
                                      if (!mounted) return;
                                      context
                                          .read<RefereeAgendaCubit>()
                                          .onChangeFinalDate(selected!);
                                    },
                                    label: BlocBuilder<RefereeAgendaCubit,
                                        RefereeAgendaState>(
                                      builder: (context, state) {
                                        return Text(
                                          'Fecha fin: \n${state.endDate != null ? DateFormat('dd-MM-yyyy').format(state.endDate!) : 'Sin asignar'}',
                                          style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: TextButton.icon(
                                    icon: const Icon(Icons.hourglass_top,
                                        color: Color(0xff358aac)),
                                    onPressed: () async {
                                      DateTime now = DateTime.now();
                                      final TimeOfDay? time =
                                          await showTimePicker(
                                              initialEntryMode:
                                                  TimePickerEntryMode.input,
                                              context: context,
                                              initialTime: TimeOfDay.now());
                                      if (time != null) {
                                        context
                                            .read<RefereeAgendaCubit>()
                                            .onChangeInitialHour(DateTime(2000,
                                                1, 1, time.hour, time.minute));
                                      }
                                      /*showDialog(
                                        context: context,
                                        builder: (_) {
                                          return BlocProvider.value(
                                            value: BlocProvider.of<
                                                RefereeAgendaCubit>(context),
                                            child: CustomHourPicker(
                                              title: "Hora inicio",
                                              initDate: now,
                                              elevation: 2,
                                              onPositivePressed:
                                                  (context, time) {
                                                context
                                                    .read<RefereeAgendaCubit>()
                                                    .onChangeInitialHour(time);
                                                Navigator.pop(context);
                                              },
                                              onNegativePressed: (context) {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          );
                                        },
                                      );*/
                                    },
                                    label: BlocBuilder<RefereeAgendaCubit,
                                        RefereeAgendaState>(
                                      builder: (context, state) {
                                        return Text(
                                            'Hora inicio:\n${state.initialHour != null ? DateFormat('HH:mm').format(state.initialHour!) : 'Sin asignar'}',
                                            style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 14));
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: TextButton.icon(
                                    icon: const Icon(Icons.hourglass_bottom,
                                        color: Color(0xff358aac)),
                                    onPressed: () async {
                                      DateTime now = DateTime.now();
                                      final TimeOfDay? time =
                                          await showTimePicker(
                                              initialEntryMode:
                                                  TimePickerEntryMode.input,
                                              context: context,
                                              initialTime: TimeOfDay.now());
                                      if (time != null) {
                                        context
                                            .read<RefereeAgendaCubit>()
                                            .onChangeEndHour(DateTime(2000, 1,
                                                1, time.hour, time.minute));
                                      }
                                      /*showDialog(
                                        context: context,
                                        builder: (_) {
                                          return BlocProvider.value(
                                            value: BlocProvider.of<
                                                RefereeAgendaCubit>(context),
                                            child: CustomHourPicker(
                                              title: "Hora fin",
                                              initDate: now,
                                              elevation: 2,
                                              onPositivePressed:
                                                  (context, time) {
                                                context
                                                    .read<RefereeAgendaCubit>()
                                                    .onChangeEndHour(time);
                                                Navigator.pop(context);
                                              },
                                              onNegativePressed: (context) {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          );
                                        },
                                      );*/
                                    },
                                    label: BlocBuilder<RefereeAgendaCubit,
                                        RefereeAgendaState>(
                                      builder: (context, state) {
                                        return Text(
                                          'Hora fin:\n${state.endHour != null ? DateFormat('HH:mm').format(state.endHour!) : 'Sin asignar'}',
                                          style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const ButtonClass(),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ButtonClass extends StatelessWidget {
  const ButtonClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final referee =
        context.select((AuthenticationBloc bloc) => bloc.state.refereeData);

    return BlocBuilder<RefereeAgendaCubit, RefereeAgendaState>(
      builder: (context, state) {
        if (state.screenState == BasicCubitScreenState.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: const Color(0xff358aac),
              size: 50,
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: () {
              context.read<RefereeAgendaCubit>().saveAgendaData(
                  referee.activeId!, referee.refereeId!, referee.partyId!);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                const Color(0xff358aac),
              ),
            ),
            child: const Text('Crear nuevo horario'),
          ),
        );
      },
    );
  }
}
