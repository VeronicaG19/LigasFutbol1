import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';

import '../../../edit_game_rol/cubit/edit_game_rol_cubit.dart';
import '../../cubit/tournament_main_cubit.dart';

class RescheduleDialog extends StatelessWidget {
  const RescheduleDialog({Key? key}) : super(key: key);

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
    return Row(
      children: [
        Container(
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
                context
                    .read<EditGameRolCubit>()
                    .onChangeHour(DateTime(2000, 1, 1, time.hour, time.minute));
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
      ],
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
