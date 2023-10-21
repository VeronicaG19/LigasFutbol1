import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../lm_tournament_v2/main_page/cubit/tournament_main_cubit.dart';

class FinalizeTournamentDialog extends StatelessWidget {
  const FinalizeTournamentDialog({super.key, required this.ttInt});
  final int ttInt;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      child: SimpleDialog(
        contentPadding: const EdgeInsets.all(25),
        title: const Text('Finalizar Torneo'),
        children: [
          const Text(
              "¿Desea finalizar el torneo?"),
          const SizedBox(
            height: 35,
          ),
          BlocBuilder<TournamentMainCubit, TournamentMainState>(
            builder: (context, state) {
              return Column(
                children: [
                  /*Row(
                    children: [

                      Expanded(
                        child: TextFormField(
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Ganador del Torneo',
                            ),
                            initialValue: 'America'
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),

                  const SizedBox(
                    height: 35,
                  ),*/
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
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
                              MaterialStateProperty.all(Colors.green)
                          ),
                          onPressed: () async {
                            print("id tor ${state.selectedTournament.tournamentId}");
                            await context
                                .read<TournamentMainCubit>()
                                .onUpdateTournamentFinished(
                                tournamentId: state.selectedTournament.tournamentId ?? 0
                            );
                            await context
                                .read<TournamentMainCubit>()
                                .getTournamentFinishedStatus(
                                tournamentId: state.selectedTournament.tournamentId ?? 0
                            );
                            await context
                                .read<TournamentMainCubit>()
                                .getTournamentChampion(
                                tournamentId: state.selectedTournament.tournamentId ?? 0
                            );
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            // <-- Icon
                            Icons.save,
                            size: 24.0,
                          ),
                          label: const Text('Finalizar Torneo'), // <-- Text
                        ),
                      ),
                    ],
                  ),
                ],
              );
            })],
     ),
    );
  }
}
