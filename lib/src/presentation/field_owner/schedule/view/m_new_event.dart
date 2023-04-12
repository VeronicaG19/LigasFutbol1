import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
//import 'package:time_pickerr/time_pickerr.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/enums.dart';
import '../../../../domain/field/entity/field.dart';
import '../cubit/field_owner_schedule_cubit.dart';

class NewEvent extends StatelessWidget {
  const NewEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color? color = Colors.blue[800];
    final Color? color2 = Colors.green[800];
    final selectedDay = context
        .select((FieldOwnerScheduleCubit cubit) => cubit.state.selectedDay);
    return BlocConsumer<FieldOwnerScheduleCubit, FieldOwnerScheduleState>(
        listenWhen: (previous, current) =>
            previous.formzStatus != current.formzStatus,
        listener: (context, state) {
          if (state.formzStatus.isSubmissionSuccess) {
            showTopSnackBar(
              context,
              CustomSnackBar.success(
                backgroundColor: color2!,
                textScaleFactor: 1.0,
                message: "El evento se ha creado correctamente",
              ),
            );
            context.read<FieldOwnerScheduleCubit>().onReloadEvents();
            Navigator.pop(context);
          } else if (state.formzStatus.isSubmissionFailure) {
            if (state.screenState == BasicCubitScreenState.emptyData) {
              showTopSnackBar(
                context,
                CustomSnackBar.info(
                  backgroundColor: color!,
                  textScaleFactor: 1.0,
                  message: "Favor de llenar todos los datos",
                ),
              );
            } else {
              showTopSnackBar(
                context,
                CustomSnackBar.success(
                  backgroundColor: color2!,
                  textScaleFactor: 1.0,
                  message: state.errorMessage ?? 'Error al crear el evento',
                ),
              );
            }
          }
        },
        buildWhen: (previous, current) =>
            current.screenState == BasicCubitScreenState.validating ||
            current.screenState == BasicCubitScreenState.loaded,
        builder: (context, state) {
          if (state.screenState == BasicCubitScreenState.validating) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: const Color(0xff358aac),
                size: 50,
              ),
            );
          }
          if (state.fieldList.isEmpty) {
            return const Center(
              child: Text('No tienes campos asignados'),
            );
          }
          return SizedBox(
            height: 700,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      child: Text(
                        'Crear nuevo Evento para la fecha ${DateFormat('dd-MM-yyyy').format(selectedDay!)}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    //const _FieldSelectionBox(),
                    const _EventDescription(),
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
                                final TimeOfDay? time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now());
                                print(time);
                                if (time != null) {
                                  context
                                      .read<FieldOwnerScheduleCubit>()
                                      .onChangeInitialHour(DateTime(
                                          2000, 1, 1, time.hour, time.minute));
                                }
                                /*showDialog(
                                  context: context,
                                  builder: (_) {
                                    return BlocProvider.value(
                                      value: BlocProvider.of<
                                          FieldOwnerScheduleCubit>(context),
                                      child: CustomHourPicker(
                                        title: "Hora inicio",
                                        initDate: now,
                                        elevation: 2,
                                        onPositivePressed: (context, time) {
                                          context
                                              .read<FieldOwnerScheduleCubit>()
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
                                    context: context,
                                    initialTime: TimeOfDay.now());
                                if (time != null) {
                                  context
                                      .read<FieldOwnerScheduleCubit>()
                                      .onChangeEndHour(DateTime(
                                          2000, 1, 1, time.hour, time.minute));
                                }
                                /*showDialog(
                                  context: context,
                                  builder: (_) {
                                    return BlocProvider.value(
                                      value: BlocProvider.of<
                                          FieldOwnerScheduleCubit>(context),
                                      child: CustomHourPicker(
                                        title: "Hora fin",
                                        initDate: now,
                                        elevation: 2,
                                        onPositivePressed: (context, time) {
                                          context
                                              .read<FieldOwnerScheduleCubit>()
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
        });
  }
}

enum _DateType { initialHour, finalHour }

class _DateLabel extends StatelessWidget {
  const _DateLabel({Key? key, required this.type}) : super(key: key);
  final _DateType type;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FieldOwnerScheduleCubit, FieldOwnerScheduleState>(
      builder: (context, state) {
        switch (type) {
          case _DateType.initialHour:
            return Text(
              'Hora inicio: \n${state.startHour != null ? DateFormat('HH:mm').format(state.startHour!) : 'Sin asignar'}',
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            );
          case _DateType.finalHour:
            return Text(
              'Hora fin: \n${state.finalHour != null ? DateFormat('HH:mm').format(state.finalHour!) : 'Sin asignar'}',
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
    return BlocBuilder<FieldOwnerScheduleCubit, FieldOwnerScheduleState>(
      builder: (context, state) {
        if (state.formzStatus.isSubmissionInProgress) {
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
              context.read<FieldOwnerScheduleCubit>().onSubmitEvent();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                const Color(0xff358aac),
              ),
            ),
            child: const Text('Crear nuevo evento'),
          ),
        );
      },
    );
  }
}

class _FieldSelectionBox extends StatelessWidget {
  const _FieldSelectionBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FieldOwnerScheduleCubit, FieldOwnerScheduleState>(
      builder: (context, state) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: const Text(
              'Campos disponibles',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            items: state.fieldList
                .map((item) => DropdownMenuItem<Field>(
                      value: item,
                      child: Text(
                        item.fieldName ?? 'Sin nombre',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[200],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              context.read<FieldOwnerScheduleCubit>().onChangeField(value!);
            },
            value: state.selectedField,
            icon: const Icon(
              Icons.arrow_forward_ios_outlined,
            ),
            iconSize: 14,
            iconEnabledColor: Colors.white70,
            itemHighlightColor: Colors.white70,
            iconDisabledColor: Colors.white70,
            buttonHeight: 40,
            buttonWidth: double.infinity,
            buttonPadding: const EdgeInsets.only(left: 14, right: 14),
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.blueGrey,
              ),
              color: Colors.blueGrey,
            ),
            buttonElevation: 2,
            itemHeight: 40,
            itemPadding: const EdgeInsets.only(left: 14, right: 14),
            dropdownPadding: null,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xff358aac),
              ),
              color: Colors.black54,
            ),
            dropdownElevation: 8,
            scrollbarRadius: const Radius.circular(40),
            scrollbarThickness: 6,
            selectedItemHighlightColor: const Color(0xff358aac),
            scrollbarAlwaysShow: true,
            offset: const Offset(-20, 0),
          ),
        );
      },
    );
  }
}

class _EventDescription extends StatelessWidget {
  const _EventDescription({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FieldOwnerScheduleCubit, FieldOwnerScheduleState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) {
        return TextFormField(
          key: const Key('name_field'),
          onChanged:
              context.read<FieldOwnerScheduleCubit>().onDescriptionChanged,
          decoration: InputDecoration(
            labelText: 'Breve descripción del evento',
            labelStyle: const TextStyle(fontSize: 13),
            errorText: state.description.invalid
                ? 'Escribe una descripción del evento'
                : null,
          ),
          style: const TextStyle(fontSize: 13),
        );
      },
    );
  }
}
