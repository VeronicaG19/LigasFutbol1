import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/referee_match.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/cubit/events/events_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/view/match_events/finalize_match_dialog.dart';

import '../../../../../../core/enums.dart';

class FinishMatchButton extends StatelessWidget {
  const FinishMatchButton({
    super.key,
    required this.match,
  });

  final RefereeMatchDTO match;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                print("Valor----------->");
                print(state.matchDetail.scoreLocal);
                print(state.matchDetail.scoreVisit);
                print(state
                    .tournamentSelected.scoringSystemId?.pointsPerWinShootOut);
                print(match.jornada);
                if (match.jornada != 0) {
                  print('match.jornada DIF 0');
                  showDialog(
                    context: context,
                    builder: (_) {
                      if (state.matchDetail.scoreLocal ==
                              state.matchDetail.scoreVisit &&
                          state.tournamentSelected.scoringSystemId
                                  ?.pointsPerWinShootOut !=
                              null) {
                        print('empate shootout');
                        return BlocProvider.value(
                            value: BlocProvider.of<EventsCubit>(context),
                            child: _DialogDesempate(
                              match: match,
                            ));
                      } else {
                        print('sin empate');
                        return BlocProvider.value(
                          value: BlocProvider.of<EventsCubit>(context),
                          child: FinalizeMatchDialog(
                            match: match,
                            matchDetail: state.matchDetail,
                            type: ScreenType.scoreMatch,
                          ),
                        );
                      }
                    },
                  );
                } else {
                  print('ELSE match.jornada DIF 0');
                  showDialog(
                    context: context,
                    builder: (_) {
                      if (state.qualifyingMatchDetail?.tieBreakType == 2 &&
                          state.matchDetail.scoreLocal ==
                              state.matchDetail.scoreVisit) {
                        print('tieBreakType 2');
                        if (state.qualifyingMatchDetail?.roundtrip == 1) {
                          print('roundtrip 1');
                          return BlocProvider.value(
                              value: BlocProvider.of<EventsCubit>(context),
                              child: _DialogDesempate(
                                match: match,
                              ));
                        } else if (state.qualifyingMatchDetail?.scoreLocal ==
                                state.qualifyingMatchDetail?.scoreVisit &&
                            state.qualifyingMatchDetail?.roundtrip ==
                                state.qualifyingMatchDetail?.matchNumber) {
                          print('IDA Y VUELTA + MARCADOR EMPATADO');
                          return BlocProvider.value(
                              value: BlocProvider.of<EventsCubit>(context),
                              child: _DialogDesempate(
                                match: match,
                              ));
                        } else if (state.qualifyingMatchDetail?.rounName ==
                                'Final' &&
                            state.qualifyingMatchDetail?.numberFinalsGame ==
                                1) {
                          print('FINAL IDA + MARCADOR EMPATADO');
                          return BlocProvider.value(
                              value: BlocProvider.of<EventsCubit>(context),
                              child: _DialogDesempate(
                                match: match,
                              ));
                        } else if (state.qualifyingMatchDetail?.rounName ==
                                'Final' &&
                            state.qualifyingMatchDetail?.numberFinalsGame ==
                                2 &&
                            state.qualifyingMatchDetail?.matchNumber == 2) {
                          print('FINAL IDA Y VUELTA + MARCADOR EMPATADO');
                          return BlocProvider.value(
                              value: BlocProvider.of<EventsCubit>(context),
                              child: _DialogDesempate(
                                match: match,
                              ));
                        } else {
                          print('ELSE tieBreakType');
                          return BlocProvider.value(
                            value: BlocProvider.of<EventsCubit>(context),
                            child: FinalizeMatchDialog(
                              match: match,
                              matchDetail: state.matchDetail,
                              type: ScreenType.scoreMatch,
                            ),
                          );
                        }
                      } else {
                        print('ELSE tieBreakType 2');
                        return BlocProvider.value(
                          value: BlocProvider.of<EventsCubit>(context),
                          child: FinalizeMatchDialog(
                            match: match,
                            matchDetail: state.matchDetail,
                            type: ScreenType.scoreMatch,
                          ),
                        );
                      }
                    },
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
                decoration: BoxDecoration(
                  color: Colors.green[800],
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Text(
                  'Terminar partido',
                  style: TextStyle(
                    fontFamily: 'SF Pro',
                    color: Colors.grey[200],
                    fontWeight: FontWeight.w500,
                    fontSize: 10.0,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DialogDesempate extends StatelessWidget {
  const _DialogDesempate({
    super.key,
    required this.match,
  });
  final RefereeMatchDTO match;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      builder: (context, state) {
        return AlertDialog(
          title: const Text('Agregar resultado del shoot out'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'El llamado shoot out consiste en un mano a mano con el portero. Es una manera de desempatar los partidos.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            'Local',
                            style: TextStyle(fontSize: 24),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                color: Colors.red,
                                onPressed: () {
                                  context
                                      .read<EventsCubit>()
                                      .decreaseScore(TypeMatchTem.local);
                                },
                              ),
                              //const SizedBox(width: 10),
                              Text(
                                '${state.scoreShoutOutLocal}',
                                style: const TextStyle(
                                    fontSize: 38, fontWeight: FontWeight.bold),
                              ),
                              //const SizedBox(width: 10),
                              IconButton(
                                icon: const Icon(Icons.add),
                                color: Colors.green,
                                onPressed: () {
                                  context
                                      .read<EventsCubit>()
                                      .increaseScore(TypeMatchTem.local);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            'Visitante',
                            style: TextStyle(fontSize: 24),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                color: Colors.red,
                                onPressed: () {
                                  context
                                      .read<EventsCubit>()
                                      .decreaseScore(TypeMatchTem.vist);
                                },
                              ),
                              //const SizedBox(width: 10),
                              Text(
                                '${state.scoreShoutOutVisit}',
                                style: const TextStyle(
                                    fontSize: 38, fontWeight: FontWeight.bold),
                              ),
                              //const SizedBox(width: 10),
                              IconButton(
                                icon: const Icon(Icons.add),
                                color: Colors.green,
                                onPressed: () {
                                  context
                                      .read<EventsCubit>()
                                      .increaseScore(TypeMatchTem.vist);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey)),
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green)),
              child: const Text('Guardar'),
              onPressed: () {
                if (state.scoreShoutOutLocal == state.scoreShoutOutVisit) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('No se puede empatar'),
                      content:
                          const Text('Los marcadores deben ser diferentes'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return BlocProvider.value(
                        value: BlocProvider.of<EventsCubit>(context),
                        child: FinalizeMatchDialog(
                          match: match,
                          matchDetail: state.matchDetail,
                          type: ScreenType.scoreShoutOut,
                        ),
                      );
                    },
                  ).whenComplete(
                    () => Navigator.of(context).pop(),
                  );
                  // Guardar los marcadores
                }
                //Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
