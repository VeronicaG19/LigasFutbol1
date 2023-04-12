import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/tournaments/cubit/tournament_general_table/tournament_general_table_cubit.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TournamentGeneralTableTab extends StatelessWidget {
  int tournamentId;

  TournamentGeneralTableTab({
    super.key,
    required this.tournamentId,
  });

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (_) => locator<TournamentGeneralTableCubit>()
        ..getGeneralTable(tournamentId: tournamentId),
      child:
          BlocBuilder<TournamentGeneralTableCubit, TournamentGeneralTableState>(
        builder: (context, state) {
          if (state.screenStatus == ScreenStatus.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.blue[800]!,
                size: 50,
              ),
            );
          } else {
            //return Text("Tabla general $tournamentId $widthScreen");

            return ListView(
              children: [
                DataTable(
                  columnSpacing: 5,
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Equipo',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'PJ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'PG',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'PE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'PP',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'GF',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'GC',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'DIF',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'PTS',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    state.generalTable.length,
                    (index) => DataRow(
                      cells: <DataCell>[
                        DataCell(
                            Text('${state.generalTable[index].team ?? '-'}')),
                        DataCell(Text('${state.generalTable[index].pj ?? 0}')),
                        DataCell(Text('${state.generalTable[index].pg ?? 0}')),
                        DataCell(Text('${state.generalTable[index].pe ?? 0}')),
                        DataCell(Text('${state.generalTable[index].pp ?? 0}')),
                        DataCell(Text('${state.generalTable[index].gf ?? 0}')),
                        DataCell(Text('${state.generalTable[index].gc ?? 0}')),
                        DataCell(Text('${state.generalTable[index].dif ?? 0}')),
                        DataCell(Text('${state.generalTable[index].pts ?? 0}')),
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
