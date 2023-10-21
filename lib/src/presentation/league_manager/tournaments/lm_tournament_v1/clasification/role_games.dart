import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/tournaments/lm_tournament_v1/clasification/cubit/clasification_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/tournaments/lm_tournament_v1/clasification/scoring_sistem_modal.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/tournaments/lm_tournament_v1/clasification/statics_tournament_clasification.dart';

import '../../../../../domain/countResponse/entity/register_count_interface.dart';
import 'matches_report.dart';

class RoleGames extends StatelessWidget {
  final int screen;

  const RoleGames({super.key, required this.screen});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClasificationCubit, ClasificationState>(
        builder: (contextL, state) {
      return Container(
        height: 500,
        color: Colors.grey[200],
        child: Column(
          children: [
            /*   const Text('Los criterios de puntaje definido son:'),
            Text(
                'Al equipo ganador de un partido se le otorgan ${state.scoringSystem.pointsPerWin ?? 0} puntos.'),
            Text(
                'En caso de empate en un partido, se le otorgan ${state.scoringSystem.pointPerTie ?? 0} punto a cada equipo.'),
            Text(
                'En caso de empate al equipo ganador de un partido en shoot out se le otorgan ${state.scoringSystem.pointsPerWinShootOut ?? 0} puntos.'),
            Text(
                'En caso de empate al equipo perdedor de un partido en shoot out se le otorgan ${state.scoringSystem.pointPerLossShootOut ?? 0} puntos.'),
           */
            const SizedBox(
              height: 25,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10, left: 10, right: 10, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blueGrey)),
                        onPressed: () {
                          showDialog(
                              context: contextL,
                              builder: (_) {
                                return SimpleDialog(
                                  contentPadding: const EdgeInsets.all(25),
                                  title: const Text('Información'),
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                        'Los criterios de puntaje definido son:'),
                                    Text(
                                        'Al equipo ganador de un partido se le otorgan ${state.scoringSystem.pointsPerWin ?? 0} puntos.'),
                                    Text(
                                        'En caso de empate en un partido, se le otorgan ${state.scoringSystem.pointPerTie ?? 0} punto a cada equipo.'),
                                    Text(
                                        'En caso de empate al equipo ganador de un partido en shoot out se le otorgan ${state.scoringSystem.pointsPerWinShootOut ?? 0} puntos.'),
                                    Text(
                                        'En caso de empate al equipo perdedor de un partido en shoot out se le otorgan ${state.scoringSystem.pointPerLossShootOut ?? 0} puntos.'),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton.icon(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.blueGrey)),
                                            onPressed: () {
                                              Navigator.pop(_);
                                            },
                                            icon: const Icon(
                                              // <-- Icon
                                              Icons.arrow_back_outlined,
                                              size: 20.0,
                                            ),
                                            label: const Text('Regresar',
                                                style: TextStyle(
                                                    fontSize: 13)), // <-- Text
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              });
                        },
                        icon: const Icon(
                          Icons.style, // <-- Icon
                          size: 18.0,
                        ),
                        label: const Text('Ver información',
                            style: TextStyle(fontSize: 14)), // <-- Text
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue[800])),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                final exampleCubit =
                                    context.read<ClasificationCubit>();
                                return BlocProvider<ClasificationCubit>.value(
                                    value: exampleCubit,
                                    child: ScoringSystemDialog());
                              });
                        },
                        icon: const Icon(
                          Icons.settings_sharp, // <-- Icon
                          size: 18.0,
                        ),
                        label: const Text('Configuración',
                            style: TextStyle(fontSize: 14)), // <-- Text
                      ),
                    ],
                  )),
            ]),
            (screen == 1)
                ? Card(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Visibility(
                                visible: state.dailMaitch.length > 0,
                                child: DropdownButtonFormField<
                                    ResgisterCountInterface>(
                                  //value: state.roundList[0],
                                  decoration: const InputDecoration(
                                    label: Text('Jornada'),
                                    border: OutlineInputBorder(),
                                  ),
                                  //icon: const Icon(Icons.sports_soccer),
                                  isExpanded: true,
                                  hint: const Text('Selecciona una jornada'),
                                  items: List.generate(
                                    state.roundList.length,
                                    (index) {
                                      final content =
                                          'J${state.roundList[index].coundt1!} - Por jugar: ${state.roundList[index].type!}';
                                      return DropdownMenuItem(
                                        child: Text(content.trim().isEmpty
                                            ? 'Selecciona una jornada'
                                            : content),
                                        value: state.roundList[index],
                                      );
                                    },
                                  ),
                                  onChanged: (value) {
                                    context
                                        .read<ClasificationCubit>()
                                        .getMatchDetailByTournamnet(
                                            roundNumber: value?.coundt1);
                                  },
                                ),
                              ),
                            ),
                            _ButtonCreateRoles(
                              matchLength: state.dailMaitch.length,
                            ),
                            if (state.statusTournament == 'true' &&
                                state.nameCh.isEmpty)
                              Visibility(
                                visible:
                                    true, //state.statusTournament == 'true' &&state.nameCh.isNotEmpty
                                child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blue[300])),
                                  onPressed: () {
                                    /*showDialog(
                                        context: context,
                                        builder: (_) {
                                          return BlocProvider.value(
                                              value: BlocProvider.of<
                                                      ClasificationCubit>(
                                                  context), //exampleCubit,
                                              child:
                                                  FinalizeTournamentDialog());
                                        });*/
                                  },
                                  icon: const Icon(
                                    Icons.add_box_rounded, // <-- Icon
                                    size: 24.0,
                                  ),
                                  label: const Text(
                                      'Finalizar torneo'), // <-- Text
                                ),
                              ),
                            Visibility(
                              visible: state.statusTournament == 'true' &&
                                  state.nameCh.isNotEmpty,
                              child: ElevatedButton.icon(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.blue[300])),
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title:
                                          const Text('El equipo campeón es:'),
                                      content: Text(state.nameCh),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.add_box_rounded, // <-- Icon
                                  size: 24.0,
                                ),
                                label: const Text('Ver campeon'), // <-- Text
                              ),
                            ), /*
                            ElevatedButton.icon(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blue[300])),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MatchLRolesMain(
                                        tournament: state.tournament, rondaL: 1,
                                      )),
                                );
                              },
                              icon: const Icon(
                                Icons.add_box_rounded, // <-- Icon
                                size: 24.0,
                              ),
                              label: const Text(
                                  'Crear partidos de liguilla'), // <-- Text
                            ),*/
                            /*ElevatedButton.icon(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blue[300])),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MatchRolesMain(
                                            tournament: state.tournament,
                                          )),
                                );
                              },
                              icon: const Icon(
                                Icons.add_box_rounded, // <-- Icon
                                size: 24.0,
                              ),
                              label: const Text(
                                  'Editar rol de juegos'), // <-- Text
                            ),*/
                          ],
                        ),
                      ],
                    ),
                  )
                : Container(),
            (screen == 1)
                ? const Expanded(child: MatchesReport())
                : const Expanded(child: StatcisTournamentClasificacion())
          ],
        ),
      );
    });
  }
}

class _ButtonCreateRoles extends StatelessWidget {
  const _ButtonCreateRoles({Key? key, required this.matchLength})
      : super(key: key);
  final int matchLength;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClasificationCubit, ClasificationState>(
      listener: (context, state) {
        if (state.screenStatus == CLScreenStatus.createdRoleGame) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  content: Text('Rol de juegos creado correctamente'),
                  duration: Duration(seconds: 5)),
            );
        } else if (state.errorMessage == 'El torneo tiene menos de 3 equipos') {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  content: Text(state.errorMessage ?? ''),
                  duration: const Duration(seconds: 5)),
            );
        }
      },
      builder: (context, state) {
        return Visibility(
          visible: matchLength <= 0,
          child: ElevatedButton.icon(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue[300])),
            onPressed: () {
              context.read<ClasificationCubit>().createRoleGame();
            },
            icon: const Icon(
              Icons.add_box_rounded, // <-- Icon
              size: 24.0,
            ),
            label: const Text('Crear rol de juegos'), // <-- Text
          ),
        );
      },
    );
  }
}
