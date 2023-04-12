import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/tournament_cubit.dart';

class DeleteTournamentModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title:const  Text('Eliminar equipo'),
      children: [
        BlocBuilder<TournamentCubit, TournamentState>(
          builder: (context, state) {
            return Column(
              children: [
                Text('Deseas eliminar el torneo ${state.tournamentSelected.tournamentName}'),
                const SizedBox(
                height: 25,
              ),
                Row(
                  children: [
                     Expanded(
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    // <-- Icon
                    Icons.backspace,
                    size: 24.0,
                  ),
                  label: const Text('Regresar'), // <-- Text
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              Expanded(
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red)),
                  onPressed: () {
                    context.read<TournamentCubit>().deleteTournamnet();
                     Navigator.of(context).pop();
                  },
                  icon: Icon(
                    // <-- Icon
                    Icons.save,
                    size: 24.0,
                  ),
                  label: const Text('Eliminar torneo'), // <-- Text
                ),
              ),
                  ],
                )
              ],
            );
          },
        )
      ],
    );
  }
}