import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/tournaments/lm_tournament_v1/clasification/cubit/clasification_cubit.dart';

import '../../../../../domain/field/entity/field.dart';
import '../../../../../domain/referee/entity/referee_by_league_dto.dart';

class EditRolGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(35),
      child: SimpleDialog(
          contentPadding: const EdgeInsets.all(25),
          title: const Text('Editar rol'),
          children: [
            BlocBuilder<ClasificationCubit, ClasificationState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton.icon(
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(), //get today's date
                              firstDate: DateTime(DateTime.now().year -
                                  50), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(DateTime.now().year + 2),
                            );
                            final DateFormat formatter =
                                DateFormat('yyyy-MM-dd hh:mm:ss');
                            final String formatted =
                                formatter.format(pickedDate ?? DateTime.now());
                            context
                                .read<ClasificationCubit>()
                                .onChangeDateMatch(pickedDate!);
                          },
                          icon: const Icon(Icons.date_range),
                          label: Text(
                            'Fecha ${DateFormat('yyyy-MM-dd').format(
                              state.editMatchObj.dateMatch == null
                                  ? DateTime.now()
                                  : state.editMatchObj.dateMatch!,
                            )}',
                          ),
                        )
                            /* TextFormField(
                            initialValue:(state.editMatchObj.dateMatch != null) ?  DateFormat('yyyy-MM-dd').format(state.editMatchObj!.dateMatch!) :
                                DateFormat('yyyy-MM-dd').format(DateTime.now()),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Fecha',
                            ),
                            readOnly: true,
                            onChanged: (value) {
                              //context.read<ClasificationCubit>().onChangeDateMatch(value);
                            },
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(), //get today's date
                                firstDate: DateTime(DateTime.now().year -
                                    50), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(DateTime.now().year + 2),
                              );
                              context.read<ClasificationCubit>().onChangeDateMatch(pickedDate!);
                            },
                          ),*/
                            ),
                        const SizedBox(
                          width: 35,
                        ),
                        Expanded(
                            child: ElevatedButton.icon(
                          onPressed: () async {
                            TimeOfDay? pickedHour = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            final DateFormat formatter =
                                DateFormat('yyyy-MM-dd');
                            DateTime dte = DateTime(
                                state.editMatchObj.dateMatch!.year,
                                state.editMatchObj.dateMatch!.month,
                                state.editMatchObj.dateMatch!.day,
                                pickedHour!.hour,
                                pickedHour.minute);
                            context
                                .read<ClasificationCubit>()
                                .onChangeHourMatch(dte);
                          },
                          icon: const Icon(Icons.date_range),
                          label: Text(
                            'Hora ${DateFormat('HH:mm:ss').format(
                              state.editMatchObj.dateMatch == null
                                  ? DateTime.now()
                                  : state.editMatchObj.dateMatch!,
                            )}',
                          ),
                        )
                            /*TextFormField(
                            initialValue:(state.editMatchObj.hourMatch != null )?  DateFormat('HH:mm:ss').format(state.editMatchObj.hourMatch!) :
                            DateFormat('HH:mm:ss').format(DateTime( TimeOfDay.now().hour, TimeOfDay.now().minute)),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Hora',
                            ),
                            readOnly: true,
                            onChanged: (value) {
                              //context.read<ClasificationCubit>().onChangeField(value!.fieldId!);
                            },
                            onTap: () async {
                              TimeOfDay? pickedHour = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),

                              );
                              DateTime dte =  DateTime(state.editMatchObj.dateMatch!.year, state.editMatchObj.dateMatch!.month, state.editMatchObj.dateMatch!.day, pickedHour!.hour, pickedHour.minute, 00, 00, 00);
                              context.read<ClasificationCubit>().onChangeHourMatch(dte);
                            },
                          ),*/
                            ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<Field>(
                            /* value:(state.fieldtList.isNotEmpty && state.editMatchObj
                                                    .fieldId != 0) ? state.fieldtList[state
                                            .fieldtList
                                            .indexWhere((element) =>
                                                element.fieldId ==
                                                state.editMatchObj
                                                    .fieldId)] : null,*/
                            decoration: const InputDecoration(
                              label: Text('Campo'),
                              border: OutlineInputBorder(),
                            ),
                            //icon: const Icon(Icons.sports_soccer),
                            isExpanded: true,
                            hint: const Text('Selecciona un campo'),
                            items: List.generate(
                              state.fieldtList.length,
                              (index) {
                                final content =
                                    state.fieldtList[index].fieldName!;
                                return DropdownMenuItem(
                                  value: state.fieldtList[index],
                                  child: Text(content.trim().isEmpty
                                      ? 'Selecciona un campo'
                                      : content),
                                );
                              },
                            ),
                            onChanged: (value) {
                              context
                                  .read<ClasificationCubit>()
                                  .onChangeField(value!.fieldId!);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 35,
                        ),
                        Expanded(
                          child: DropdownButtonFormField<RefereeByLeagueDTO>(
                            /* value:(state.refereetList.isNotEmpty && state.editMatchObj
                                                    .refereeId !=0)  ? state.refereetList[state
                                            .refereetList
                                            .indexWhere((element) =>
                                                element.refereeId ==
                                                state.editMatchObj
                                                    .refereeId)] : null,*/
                            decoration: const InputDecoration(
                              label: Text('Arbítro'),
                              border: OutlineInputBorder(),
                            ),
                            //icon: const Icon(Icons.sports_soccer),
                            isExpanded: true,
                            hint: const Text('Selecciona un arbítro'),
                            items: List.generate(
                              state.refereetList.length,
                              (index) {
                                final content =
                                    state.refereetList[index].refereeName;
                                return DropdownMenuItem(
                                  value: state.refereetList[index],
                                  child: Text(content.trim().isEmpty
                                      ? 'Selecciona un arbítro'
                                      : content),
                                );
                              },
                            ),
                            onChanged: (value) {
                              context
                                  .read<ClasificationCubit>()
                                  .onChangeReferee(value!.refereeId);
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.grey[300])),
                            onPressed: () {
                              context
                                  .read<ClasificationCubit>()
                                  .cleanDataToObjEditMatch();
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.close, // <-- Icon
                              size: 24.0,
                            ),
                            label: const Text('Cerrar'), // <-- Text
                          ),
                        ),
                        const SizedBox(
                          width: 35,
                        ),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red[300])),
                            onPressed: () {
                              context.read<ClasificationCubit>().deleteMatch();
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.save, // <-- Icon
                              size: 24.0,
                            ),
                            label: const Text('Eliminar'), // <-- Text
                          ),
                        ),
                        const SizedBox(
                          width: 35,
                        ),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.green[300])),
                            onPressed: () {
                              context.read<ClasificationCubit>().updateMatch();
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.save, // <-- Icon
                              size: 24.0,
                            ),
                            label: const Text('Guardar'), // <-- Text
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
            )
          ]),
    );
  }
}
