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
    return SimpleDialog(
        title:
            const Text('Seleccione los equipos que quiere agregar al torneo'),
        children: [
          Card(
            child: Column(
              children: [
                Text('Torneo: ${tournament.tournamentName}'),
                Text('Categoria: ${tournament.categoryId!.categoryName!}'),
              ],
            ),
          ),
          BlocBuilder<TeamsLMCubit, TeamsLMState>(builder: (context, state) {
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
                        'Equipos inscritos: ${state.inscribedTeams.coundt1} de ${state.tournament.maxTeams}'),
                    Text('Equipos seleccionados: ${state.countSelected}'),
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 350,
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
                                !state.cardTeamsSlc[index].isSelected!, index);
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          }),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  onPressed: () {
                    context
                        .read<TeamsLMCubit>()
                        .getTournamentTeamDataBytournament(
                            tournament: tournament);
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
                          MaterialStateProperty.all(Colors.greenAccent)),
                  onPressed: () async {
                    await context.read<TeamsLMCubit>().suscribeTeams();
                    await context
                        .read<TeamsLMCubit>()
                        .getTournamentTeamDataBytournament(
                            tournament: tournament);
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    // <-- Icon
                    Icons.save,
                    size: 24.0,
                  ),
                  label: const Text('Agregar equipo'), // <-- Text
                ),
              ),
            ],
          ),
        ]);
  }
}
