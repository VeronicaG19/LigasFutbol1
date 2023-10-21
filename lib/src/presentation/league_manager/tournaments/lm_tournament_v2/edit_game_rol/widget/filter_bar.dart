import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';

import '../../../../../../core/constans.dart';
import '../../main_page/cubit/tournament_main_cubit.dart';
import '../cubit/edit_game_rol_cubit.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final match =
        context.select((TournamentMainCubit bloc) => bloc.state.selectedMatch);
    final selectedState =
        context.select((EditGameRolCubit bloc) => bloc.state.selectedState);
    final mapVisible =
        context.select((EditGameRolCubit bloc) => bloc.state.isMapVisible);
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        bottom: 15,
      ),
      child: Container(
        width: 790,
        height: 45,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.grey[100], //blue
          border: Border.all(
            color: Colors.black12,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(45),
        ),
        child: Row(
          children: [
            Container(
              key: CoachKey.dateRoleGame,
              width: 200,
              height: 90,
              decoration: const BoxDecoration(
                color: Colors.transparent, //light blue
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  bottomLeft: Radius.circular(45),
                ),
              ),
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () async {
                  if (match.dateMatch != null &&
                      (match.requestFieldId != null ||
                          match.requestRefereeId != null)) return;
                  final selected = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2025),
                  );
                  const mounted = true;
                  if (!mounted) return;
                  context.read<EditGameRolCubit>().onChangeDate(selected!);
                },
                child: const _DateLabel(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 5),
              child: Container(
                width: 1,
                height: 80,
                color: Colors.black12,
              ),
            ),
            Container(
              key: CoachKey.hourRoleGame,
              width: 200,
              height: 90,
              decoration: const BoxDecoration(
                color: Colors.transparent, //light blue
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  bottomLeft: Radius.circular(45),
                ),
              ),
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () async {
                  if (match.dateMatch != null &&
                      (match.requestFieldId != null ||
                          match.requestRefereeId != null)) return;
                  DateTime now = DateTime.now();
                  final TimeOfDay? time = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  if (time != null) {
                    context.read<EditGameRolCubit>().onChangeHour(
                        DateTime(2000, 1, 1, time.hour, time.minute));
                  }
                },
                child: const _HourLabel(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 5),
              child: Container(
                width: 1,
                height: 80,
                color: Colors.black12,
              ),
            ),
            Container(
              key: CoachKey.placeRolGame,
              width: 200,
              height: 90,
              decoration: const BoxDecoration(
                color: Colors.transparent, //light blue
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  bottomLeft: Radius.circular(45),
                ),
              ),
              alignment: Alignment.center,
              child: DropdownButtonFormField<String>(
                value: selectedState,
                elevation: 0,
                focusColor: Colors.blueGrey,
                items: mexicoStates
                    .map((key, value) {
                      return MapEntry(
                        key,
                        DropdownMenuItem<String>(
                          value: key,
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              value,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      );
                    })
                    .values
                    .toList(),
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500),
                onChanged: (value) {
                  context.read<EditGameRolCubit>().onChangeState(value);
                },
                isDense: true,
                isExpanded: true,
              ),
            ),
            Container(
              width: 90,
              height: 35,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: mapVisible ? Colors.blue : Colors.black12,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(45),
              ),
              child: Center(
                child: InkWell(
                  onTap: () =>
                      context.read<EditGameRolCubit>().onChangeMapVisibility(),
                  child: const Text(
                    'Ver mapa',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 5,
                top: 5,
                left: 5,
              ),
              child: Container(
                key: CoachKey.searchButtonRoleGame,
                width: 90,
                height: 45,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: const Color(0xff740404), //blue
                  border: Border.all(
                    color: Colors.black12,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(45),
                ),
                child: InkWell(
                  onTap: () {
                    context.read<EditGameRolCubit>().onFilterLists();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        size: 20,
                        color: Colors.grey[200],
                      ),
                      Text(
                        'Buscar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[200],
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateLabel extends StatelessWidget {
  const _DateLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditGameRolCubit, EditGameRolState>(
      builder: (context, state) {
        return Text(
          state.selectedDate != null
              ? 'Fecha: ${DateFormat('dd-MM-yyyy').format(state.selectedDate!)}'
              : 'Fecha',
          style: const TextStyle(
              fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500),
        );
      },
    );
  }
}

class _HourLabel extends StatelessWidget {
  const _HourLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditGameRolCubit, EditGameRolState>(
      builder: (context, state) {
        return Text(
          state.selectedHour != null
              ? 'Hora: ${DateFormat('HH:mm').format(state.selectedHour!)}'
              : 'Hora',
          style: const TextStyle(
              fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500),
        );
      },
    );
  }
}
