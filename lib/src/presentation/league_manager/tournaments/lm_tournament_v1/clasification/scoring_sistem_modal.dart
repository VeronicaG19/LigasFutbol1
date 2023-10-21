import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/tournaments/lm_tournament_v1/clasification/cubit/clasification_cubit.dart';

class ScoringSystemDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      child: SimpleDialog(
        contentPadding: const EdgeInsets.all(25),
        title: const Text('Sistema de puntuaciones'),
        children: [
          const Text(
              "Para que el sistema de puntuación aplicado en las clasificaciones se adapte a tus necesidades, te permitimos personalizar los criterios. \nPodrás ver los puntos que se otorgan por defecto a cada partido:"),
          const Text('1.- Ganado.'),
          const Text("2.- Empatado."),
          const Text("3.- Ganado en shoot out."),
          const Text("Perdido en shoot out."),
          const Text(
              "Para editar los valores, simplemente introduce la nueva puntuación y haz clic en Guardar."),
          const SizedBox(
            height: 35,
          ),
          BlocBuilder<ClasificationCubit, ClasificationState>(
            builder: (context, state) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Puntos por partido ganado.',
                          ),
                          initialValue:
                              '${state.scoringSystem.pointsPerWin ?? 0}',
                          onChanged: (val) {
                            context.read<ClasificationCubit>().updateWin(val);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 35,
                      ),
                      Expanded(
                        child: TextFormField(
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Puntos por partido empatado.',
                          ),
                          initialValue:
                              '${state.scoringSystem.pointPerTie ?? 0}',
                          onChanged: (val) {
                            context.read<ClasificationCubit>().updateTie(val);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  const Text("¿Habrá desempate por shoot out?"),
                  SwitchListTile(
                      activeThumbImage:
                          const AssetImage('assets/images/unlocked.png'),
                      inactiveThumbImage:
                          const AssetImage('assets/images/padlock.png'),
                      activeColor: Colors.green[300],
                      title: (state.shootout)
                          ? const Text('Si')
                          : const Text('No'),
                      value: state.shootout,
                      onChanged: (val) {
                        context.read<ClasificationCubit>().onchangeShooOut(val);
                      }),
                  const SizedBox(
                    height: 35,
                  ),
                  Visibility(
                    visible: state.shootout,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Ganado en shoot out.',
                            ),
                            initialValue:
                                '${state.scoringSystem.pointsPerWinShootOut ?? 0}',
                            onChanged: (val) {
                              context
                                  .read<ClasificationCubit>()
                                  .updateWinShoot(val);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 35,
                        ),
                        Expanded(
                          child: TextFormField(
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Perdido en shoot out.',
                            ),
                            initialValue:
                                '${state.scoringSystem.pointPerLossShootOut ?? 0}',
                            onChanged: (val) {
                              context
                                  .read<ClasificationCubit>()
                                  .updateLoosShootout(val);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blueGrey)),
                          onPressed: () {
                            context.read<ClasificationCubit>().onCancelUpdate();
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            // <-- Icon
                            Icons.arrow_back_outlined,
                            size: 20.0,
                          ),
                          label: const Text('Regresar',
                              style: TextStyle(fontSize: 13)), // <-- Text
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
                            context.read<ClasificationCubit>().onUpdateSoring();
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            // <-- Icon
                            Icons.save_alt,
                            size: 20.0,
                          ),
                          label: const Text('Guardar',
                              style: TextStyle(fontSize: 13)), // <-- Text
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
