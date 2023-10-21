// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';

import '../../lm_tournament_v2/main_page/cubit/tournament_main_cubit.dart';

class FinalizeMatchModal extends StatelessWidget {
  final String local, visit;
  const FinalizeMatchModal({Key? key, required this.visit, required this.local})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(35),
      child: SimpleDialog(
        contentPadding: const EdgeInsets.all(25),
        title: const Text('Marcador del partido'),
        children: [
          BlocConsumer<TournamentMainCubit, TournamentMainState>(
            listenWhen: (previous, current) =>
                previous.screenStatus != current.screenStatus,
            listener: (context, state) {
              if (state.screenStatus == CLScreenStatus2.matchFinalized) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              if (state.screenStatus == CLScreenStatus2.loadingDataToFinish) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  const Center(child: Text('Marcador')),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Local',
                          ),
                          initialValue: local,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                      const SizedBox(
                        width: 35,
                      ),
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          style: const TextStyle(fontSize: 15),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Visitante',
                          ),
                          initialValue: visit,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.do_disturb_on_sharp,
                              size: 20,
                              color: Colors.red,
                            ),
                            tooltip: 'Disminuir puntuación',
                            onPressed: () {
                              context.read<TournamentMainCubit>().decreaseScore(
                                    typeTeam: TypeMatchTem.local,
                                    isShoutout: false,
                                  );
                            },
                          ),
                          Text(
                              '${state.qualifyingMatchDetail?.scoreLocal != null ? '(${state.qualifyingMatchDetail!.scoreLocal})' : ''} ${state.finalizeMatchDTO.scoreLocal}',
                              style: const TextStyle(fontSize: 25)),
                          IconButton(
                            icon: const Icon(
                              size: 20,
                              Icons.add,
                              color: Colors.green,
                            ),
                            tooltip: 'Incrementar puntuación',
                            onPressed: () {
                              context.read<TournamentMainCubit>().increaseScore(
                                    typeTeam: TypeMatchTem.local,
                                    isShoutout: false,
                                  );
                            },
                          ),
                        ],
                      )),
                      const SizedBox(
                        width: 35,
                      ),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.do_disturb_on_sharp,
                                color: Colors.red, size: 20),
                            tooltip: 'Disminuir puntuación',
                            onPressed: () {
                              context.read<TournamentMainCubit>().decreaseScore(
                                    typeTeam: TypeMatchTem.vist,
                                    isShoutout: false,
                                  );
                            },
                          ),
                          Text(
                              '${state.qualifyingMatchDetail?.scoreVisit != null ? '(${state.qualifyingMatchDetail!.scoreVisit})' : ''} ${state.finalizeMatchDTO.scoreVist}',
                              style: const TextStyle(fontSize: 25)),
                          IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.green,
                              size: 20,
                            ),
                            tooltip: 'Incrementar puntuación',
                            onPressed: () {
                              context.read<TournamentMainCubit>().increaseScore(
                                    typeTeam: TypeMatchTem.vist,
                                    isShoutout: false,
                                  );
                            },
                          ),
                        ],
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  (state.tiebreakerRequired)
                      ? const Row(children: [
                          Text('Agregar resultado del shoot out'),
                        ])
                      : const SizedBox(height: 0),
                  SizedBox(
                    height: (state.tiebreakerRequired) ? 25 : 0,
                  ),
                  (state.tiebreakerRequired)
                      ? Row(
                          children: [
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.do_disturb_on_sharp,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                  tooltip: 'Disminuir puntuación',
                                  onPressed: () {
                                    context
                                        .read<TournamentMainCubit>()
                                        .decreaseScore(
                                          typeTeam: TypeMatchTem.local,
                                          isShoutout: true,
                                        );
                                  },
                                ),
                                Text(
                                    '${state.finalizeMatchDTO.scoreShoutoutLocal}',
                                    style: const TextStyle(fontSize: 25)),
                                IconButton(
                                  icon: const Icon(
                                    size: 20,
                                    Icons.add,
                                    color: Colors.green,
                                  ),
                                  tooltip: 'Incrementar puntuación',
                                  onPressed: () {
                                    context
                                        .read<TournamentMainCubit>()
                                        .increaseScore(
                                          typeTeam: TypeMatchTem.local,
                                          isShoutout: true,
                                        );
                                  },
                                ),
                              ],
                            )),
                            const SizedBox(
                              width: 35,
                            ),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.do_disturb_on_sharp,
                                      color: Colors.red, size: 20),
                                  tooltip: 'Disminuir puntuación',
                                  onPressed: () {
                                    context
                                        .read<TournamentMainCubit>()
                                        .decreaseScore(
                                          typeTeam: TypeMatchTem.vist,
                                          isShoutout: true,
                                        );
                                  },
                                ),
                                Text(
                                    '${state.finalizeMatchDTO.scoreShoutoutVisit}',
                                    style: const TextStyle(fontSize: 25)),
                                IconButton(
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                  tooltip: 'Incrementar puntuación',
                                  onPressed: () {
                                    context
                                        .read<TournamentMainCubit>()
                                        .increaseScore(
                                          typeTeam: TypeMatchTem.vist,
                                          isShoutout: true,
                                        );
                                  },
                                ),
                              ],
                            )),
                          ],
                        )
                      : const SizedBox(
                          height: 0,
                        ),
                  SizedBox(
                    height: (state.tiebreakerRequired) ? 25 : 0,
                  ),
                  Row(
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
                            Icons.arrow_back_outlined, // <-- Icon
                            size: 24.0,
                          ),
                          label: const Text('Regresar',
                              style: TextStyle(fontSize: 13)), // <-- Text
                        ),
                      ),
                      const SizedBox(
                        width: 35,
                      ),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  state.canFinish
                                      ? Colors.green[300]
                                      : Colors.grey)),
                          onPressed: () {
                            if (!state.canFinish) return;
                            context.read<TournamentMainCubit>().finalizeMatch();
                          },
                          icon: const Icon(
                            Icons.save_alt, // <-- Icon
                            size: 24.0,
                          ),
                          label: const Text(
                            'Guardar',
                            style: TextStyle(fontSize: 13),
                          ), // <-- Text
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
