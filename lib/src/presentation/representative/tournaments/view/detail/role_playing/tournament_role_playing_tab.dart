import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/tournaments/cubit/tournament_role_playing/tournament_role_playing_cubit.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TournamentRolePlayingTab extends StatelessWidget {
  int tournamentId;

  TournamentRolePlayingTab({
    super.key,
    required this.tournamentId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<TournamentRolePlayingCubit>()
        ..getMatchDetailByTournamnet(tournamentId: tournamentId),
      child:
          BlocBuilder<TournamentRolePlayingCubit, TournamentRolePlayingState>(
        builder: (context, state) {
          if (state.screenStatus == ScreenStatus.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.blue[800]!,
                size: 50,
              ),
            );
          } else {
            return ListView(
              //scrollDirection: Axis.horizontal,
              children: [
                DataTable(
                  columnSpacing: 5,
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Jornada',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Fecha y hora',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Local',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Marcador',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Visitante',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    state.matchmakingList.length,
                    (index) => DataRow(
                      color: MaterialStateProperty.resolveWith<Color?>
                        ((Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                          }
                          if (index.isEven) {
                            return Colors.grey.withOpacity(0.3);
                          }
                          return null;
                        }),
                      cells: <DataCell>[
                        DataCell(
                            Text(
                                '${state.matchmakingList[index].jornada}')
                        ),
                        DataCell(
                            Text(
                              state.matchmakingList[index].fecha == null ? "Pendiente"
                                  : DateFormat('dd-MM-yyyy HH:mm').format(
                                  state.matchmakingList[index].fecha!
                              ),
                              textAlign: TextAlign.center,
                            ),
                        ),
                        DataCell(
                            Text(
                              '${state.matchmakingList[index].equipoLocal}',
                              textAlign: TextAlign.center,
                            )
                        ),
                        DataCell(
                          Text(
                            state.matchmakingList[index].estadoJuego == "Pendiente"
                                ? "vs"
                                : "${state.matchmakingList[index].marcadorLocal??''} -"
                                " ${state.matchmakingList[index].marcadorVisita??''}",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        DataCell(
                          Text(
                            '${state.matchmakingList[index].equipoVisita}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
