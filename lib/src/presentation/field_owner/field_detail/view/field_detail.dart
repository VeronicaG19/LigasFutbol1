import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
//import 'package:time_pickerr/time_pickerr.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/enums.dart';
import '../../../../domain/field/entity/field.dart';
import '../../../app/bloc/authentication_bloc.dart';
import '../cubit/fo_field_detail_cubit.dart';

class FieldDetail extends StatelessWidget {
  const FieldDetail({Key? key, required this.field}) : super(key: key);

  final Field field;

  @override
  Widget build(BuildContext context) {
    final Color? color = Colors.blue[800];
    final Color? color2 = Colors.green[800];
    return BlocListener<FoFieldDetailCubit, FoFieldDetailState>(
      listenWhen: (previous, current) =>
          previous.screenState != current.screenState,
      listener: (context, state) {
        if (state.screenState == BasicCubitScreenState.success) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              backgroundColor: color2!,
              textScaleFactor: 1.0,
              message: "Se creo correctamente el nuevo horario",
            ),
          );
          context
              .read<FoFieldDetailCubit>()
              .getFieldsAvailability(field.activeId!);
          Navigator.pop(context);
        } else if (state.screenState == BasicCubitScreenState.error) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              backgroundColor: color2!,
              textScaleFactor: 1.0,
              message: state.errorMessage!,
            ),
          );
        } else if (state.screenState == BasicCubitScreenState.emptyData) {
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
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                child: Text(
                  'Crear nuevo horario',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(
                child: Text(
                  field.fieldName ?? '-',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(
                child: Text(
                  'Seleccione los siguientes campos para crear una nueva disponibilidad',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
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
                              .read<FoFieldDetailCubit>()
                              .onChangeInitialDate(selected!);
                        },
                        label: const _DateLabel(
                          type: _DateType.initialDate,
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
                              .read<FoFieldDetailCubit>()
                              .onChangeFinalDate(selected!);
                        },
                        label: const _DateLabel(
                          type: _DateType.finalDate,
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
                          final TimeOfDay? time = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                          if (time != null) {
                            context
                                .read<FoFieldDetailCubit>()
                                .onChangeInitialHour(DateTime(
                                    2000, 1, 1, time.hour, time.minute));
                          }
                          /*showDialog(
                            context: context,
                            builder: (_) {
                              return BlocProvider.value(
                                value: BlocProvider.of<FoFieldDetailCubit>(
                                    context),
                                child: CustomHourPicker(
                                  title: "Hora inicio",
                                  initDate: now,
                                  elevation: 2,
                                  onPositivePressed: (context, time) {
                                    context
                                        .read<FoFieldDetailCubit>()
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
                        label: const _DateLabel(
                          type: _DateType.initialHour,
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
                          final TimeOfDay? time = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                          if (time != null) {
                            context.read<FoFieldDetailCubit>().onChangeEndHour(
                                DateTime(2000, 1, 1, time.hour, time.minute));
                          }
                          /*showDialog(
                            context: context,
                            builder: (_) {
                              return BlocProvider.value(
                                value: BlocProvider.of<FoFieldDetailCubit>(
                                    context),
                                child: CustomHourPicker(
                                  title: "Hora fin",
                                  initDate: now,
                                  elevation: 2,
                                  onPositivePressed: (context, time) {
                                    context
                                        .read<FoFieldDetailCubit>()
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
                        label: const _DateLabel(
                          type: _DateType.finalHour,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const _SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}

enum _DateType { initialDate, finalDate, initialHour, finalHour }

class _DateLabel extends StatelessWidget {
  const _DateLabel({Key? key, required this.type}) : super(key: key);
  final _DateType type;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoFieldDetailCubit, FoFieldDetailState>(
      builder: (context, state) {
        switch (type) {
          case _DateType.initialDate:
            return Text(
              'Fecha inicio: \n${state.initialDate != null ? DateFormat('dd-MM-yyyy').format(state.initialDate!) : 'Sin asignar'}',
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            );
          case _DateType.finalDate:
            return Text(
              'Fecha fin: \n${state.endDate != null ? DateFormat('dd-MM-yyyy').format(state.endDate!) : 'Sin asignar'}',
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            );
          case _DateType.initialHour:
            return Text(
              'Hora inicio: \n${state.initialHour != null ? DateFormat('HH:mm').format(state.initialHour!) : 'Sin asignar'}',
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            );
          case _DateType.finalHour:
            return Text(
              'Hora fin: \n${state.endHour != null ? DateFormat('HH:mm').format(state.endHour!) : 'Sin asignar'}',
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            );
        }
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final person =
        context.select((AuthenticationBloc bloc) => bloc.state.user.person);
    return BlocBuilder<FoFieldDetailCubit, FoFieldDetailState>(
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
              context
                  .read<FoFieldDetailCubit>()
                  .onCreateNewAvailability(person.personId ?? 0);
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
