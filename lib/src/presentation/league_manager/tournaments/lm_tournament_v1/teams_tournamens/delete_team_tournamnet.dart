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
      title: const Text('Eliminar equipo',
          style: TextStyle(fontWeight: FontWeight.w900)),
      children: [
        BlocConsumer<TeamsLMCubit, TeamsLMState>(
          listenWhen: (previous, current) =>
              previous.screenStatus != current.screenStatus,
          listener: (context, state) {
            if (state.screenStatus == ScreenStatus.success) {
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  '¿Deseas eliminar al equipo ${teamTournament.teamName}?',
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  height: 30,
                ),
                if (state.screenStatus == ScreenStatus.teamsGetting)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, bottom: 10, right: 15),
                  child: Visibility(
                    visible: state.screenStatus != ScreenStatus.teamsGetting,
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blueGrey)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              // <-- Icon
                              Icons.arrow_back_outlined,
                              size: 20.0,
                            ),
                            label: const Text('Regresar',
                                style: TextStyle(fontSize: 12)), // <-- Text
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
                              context.read<TeamsLMCubit>().unSuscribeTeams(
                                  teamTournament.teamTournamentId!);
                            },
                            icon: const Icon(
                              // <-- Icon
                              Icons.delete,
                              size: 20.0,
                            ),
                            label: const Text('Eliminar equipo',
                                style: TextStyle(fontSize: 12)), // <-- Text
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        )
      ],
    );
  }
}
