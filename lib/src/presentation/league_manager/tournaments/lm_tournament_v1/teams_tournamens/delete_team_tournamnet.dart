// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/team_tournament/dto/team_tournament_dto.dart';
import '../../../../../domain/tournament/entity/tournament.dart';
import '../teams_by_tournament/cubit/teams_cubit.dart';

class DeleteTeamTournamentModal extends StatelessWidget {
  DeleteTeamTournamentModal({
    Key? key,
    required this.teamTournament,
    required this.tournament,
  }) : super(key: key);

  TeamTournamentDto teamTournament;
  final Tournament tournament;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Eliminar equipo'),
      children: [
        BlocBuilder<TeamsLMCubit, TeamsLMState>(
          builder: (context, state) {
            return Column(
              children: [
                Text('Deseas eliminar al equipo ${teamTournament.teamName}'),
                const SizedBox(
                  height: 25,
                ),
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
                        onPressed: () async {
                          await context.read<TeamsLMCubit>().unSuscribeTeams(
                              teamTournament.teamTournamentId!);
                          await context
                              .read<TeamsLMCubit>()
                              .getTournamentTeamDataBytournament(
                                  tournament: tournament);
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          // <-- Icon
                          Icons.save,
                          size: 24.0,
                        ),
                        label: const Text('Eliminar equipo'), // <-- Text
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
