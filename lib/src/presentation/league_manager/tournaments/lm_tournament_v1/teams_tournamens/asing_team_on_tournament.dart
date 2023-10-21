import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/entity/tournament.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/teams/widgets/card_selection.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/tournaments/lm_tournament_v1/teams_by_tournament/cubit/teams_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AssingTeamOnTournament extends StatelessWidget {
  final Tournament tournament;

  const AssingTeamOnTournament({super.key, required this.tournament});
  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((TeamsLMCubit bloc) => bloc.state.screenStatus) ==
            ScreenStatus.teamsGetting;
    return SimpleDialog(
      title: const Text('Seleccione los equipos para agregar al torneo',
          style: TextStyle(fontWeight: FontWeight.w900)),
      children: [
        BlocConsumer<TeamsLMCubit, TeamsLMState>(
            listenWhen: (previous, current) =>
                previous.screenStatus != current.screenStatus,
            listener: (context, state) {
              if (state.screenStatus == ScreenStatus.success) {
                context
                    .read<TeamsLMCubit>()
                    .getTournamentTeamDataBytournament(tournament: tournament);
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              if (state.screenStatus == ScreenStatus.teamsGetting) {
                return Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                    color: Colors.blue[800]!,
                    size: 50,
                  ),
                );
              } else if (state.screenStatus == ScreenStatus.teamsGetted) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 7,
                  child: Column(
                    children: [
                      Text(
                          'Equipos inscritos: ${state.inscribedTeams.coundt1} de ${state.tournament.maxTeams} / Equipos seleccionados: ${state.countSelected}',
                          textAlign: TextAlign.end,
                          style: const TextStyle(fontSize: 15)),
                      const SizedBox(
                        height: 15,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 160,
                                childAspectRatio: 3 / 2,
                                crossAxisSpacing: 80,
                                mainAxisSpacing: 85),
                        itemCount: state.cardTeamsSlc.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: CardSelection(
                              imageTeam: state.cardTeamsSlc[index].imageTeam!,
                              teamName: state.cardTeamsSlc[index].teamName!,
                              isSelected: state.cardTeamsSlc[index].isSelected!,
                            ),
                            onTap: () {
                              context.read<TeamsLMCubit>().markTeamToSuscribe(
                                  !state.cardTeamsSlc[index].isSelected!,
                                  index);
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }),
        if (!isLoading)
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
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
                            MaterialStateProperty.all(Colors.green)),
                    onPressed: () {
                      context.read<TeamsLMCubit>().subscribeTeams();
                    },
                    icon: const Icon(
                      // <-- Icon
                      Icons.save,
                      size: 20.0,
                    ),
                    label: const Text('Agregar equipo',
                        style: TextStyle(fontSize: 12)), // <-- Text
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
