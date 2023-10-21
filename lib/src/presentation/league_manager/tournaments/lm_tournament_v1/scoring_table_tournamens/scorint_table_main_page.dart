// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ligas_futbol_flutter/src/domain/team_tournament/entity/team_tournament.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/entity/tournament.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../../domain/team_player/dto/player_into_team_dto.dart';
import '../../../../../service_locator/injection.dart';
import 'cubit/scoring_table_cubit.dart';

class ScoringTableMainPage extends StatelessWidget {
  final Tournament tournament;
  const ScoringTableMainPage({
    Key? key,
    required this.tournament,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<ScoringTableCubit>()
        ..getScoringTableData(tournament: tournament),
      child: BlocConsumer<ScoringTableCubit, ScoringTableState>(
        listener: (context, state) {
          if (state.screenStatus == ScreenStatus.playersGeted) {
            showTopSnackBar(
              context,
              CustomSnackBar.info(
                backgroundColor: Colors.blue,
                textScaleFactor: 0.9,
                message: 'Tienes ${state.goalsPending} goles por asignar',
                maxLines: 3,
                textStyle: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            );
          } else if (state.status == FormzStatus.submissionFailure) {
            showTopSnackBar(
              context,
              CustomSnackBar.info(
                backgroundColor: Colors.red,
                textScaleFactor: 0.9,
                message: 'Favor de revisar la información',
                maxLines: 3,
                textStyle: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            );
          } else if (state.status == FormzStatus.submissionSuccess) {
            showTopSnackBar(
              context,
              CustomSnackBar.info(
                backgroundColor: Colors.blue,
                textScaleFactor: 0.9,
                message: 'Se agrego el goleador correctamente',
                maxLines: 3,
                textStyle: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.screenStatus == ScreenStatus.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.blue[800]!,
                size: 50,
              ),
            );
          } else {
            return SizedBox(
              height: 500,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),

                  Visibility(
                    visible: state.isAddScoring,
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<TeamTournament>(
                            //value: state.roundList[0],
                            decoration: const InputDecoration(
                              label: Text('Equipo'),
                              border: OutlineInputBorder(),
                            ),
                            //icon: const Icon(Icons.sports_soccer),
                            isExpanded: true,
                            hint: const Text('Selecciona un equipo'),
                            items: List.generate(
                              state.listOfTeams.length,
                              (index) {
                                final content =
                                    state.listOfTeams[index].teamId?.teamName ??
                                        '-';
                                return DropdownMenuItem(
                                  child: Text(content.trim().isEmpty
                                      ? 'Selecciona un equipo'
                                      : content),
                                  value: state.listOfTeams[index],
                                );
                              },
                            ),
                            onChanged: (value) {
                              context
                                  .read<ScoringTableCubit>()
                                  .onChangeTeam(value!);

                              context
                                  .read<ScoringTableCubit>()
                                  .getPlayersForTeam(teamTournament: value);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: DropdownButtonFormField<PlayerIntoTeamDTO>(
                            //value: state.roundList[0],
                            decoration: const InputDecoration(
                              label: Text('Jugador'),
                              border: OutlineInputBorder(),
                            ),
                            //icon: const Icon(Icons.sports_soccer),
                            isExpanded: true,
                            hint: const Text('Selecciona un jugador'),
                            items: List.generate(
                              state.palyersList.length,
                              (index) {
                                final content =
                                    state.palyersList[index].fullName ?? '-';
                                return DropdownMenuItem(
                                  child: Text(content.trim().isEmpty
                                      ? 'Selecciona un jugador'
                                      : content),
                                  value: state.palyersList[index],
                                );
                              },
                            ),
                            onChanged: (value) {
                              context
                                  .read<ScoringTableCubit>()
                                  .onChangePlayer(value!.partyId!);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextFormField(
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              errorText: state.goals.invalid
                                  ? "Datos no válidos"
                                  : null,
                              border: const OutlineInputBorder(),
                              labelText: 'Goles anotados.',
                            ),
                            initialValue: '0',
                            onChanged: (val) {
                              context
                                  .read<ScoringTableCubit>()
                                  .onChangeGoals(val);
                            },
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              ElevatedButton.icon(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.green)),
                                onPressed: () {
                                  context
                                      .read<ScoringTableCubit>()
                                      .saveScoringTable();
                                },
                                icon: const Icon(
                                  Icons.save_alt, // <-- Icon
                                  size: 24.0,
                                ),
                                label: const Text('Guardar'), // <-- Text
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              ElevatedButton.icon(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.grey)),
                                onPressed: () {
                                  context
                                      .read<ScoringTableCubit>()
                                      .addScoring();
                                },
                                icon: const Icon(
                                  Icons.close, // <-- Icon
                                  size: 24.0,
                                ),
                                label: const Text('Cerrar'), // <-- Text
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: false, //state.isAddScoring,
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.green)),
                            onPressed: () {
                              context.read<ScoringTableCubit>().addScoring();
                            },
                            icon: const Icon(
                              Icons.sports_soccer_rounded, // <-- Icon
                              size: 24.0,
                            ),
                            label: const Text('Agregar goleador'), // <-- Text
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Stack(children: [
                      Container(
                        padding: EdgeInsets.only(right: 7, left: 7),
                        height: 45,
                        color: Color(0xff358aac),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  "Pos",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[200],
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                child: Text(
                                  "Jugador",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[200],
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                child: Text(
                                  "Equipo",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[200],
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  "Goles",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[200],
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            ]),
                      ),
                      ListView.builder(
                          itemCount: state.listScoringTableData.length,
                          padding: EdgeInsets.only(top: 40, bottom: 65),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  color: Colors.grey,
                                  height: 1,
                                ),
                                Container(
                                  height: 40,
                                  padding: EdgeInsets.only(right: 7, left: 7),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 100,
                                          child: Center(
                                            child: Text(
                                              "${index + 1}°",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            width: 200,
                                            color: Colors.black12,
                                            height: 40,
                                            child: Center(
                                              child: Text(
                                                state
                                                        .listScoringTableData[
                                                            index]
                                                        .fullName ??
                                                    '-',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            )),
                                        Container(
                                            width: 200,
                                            height: 40,
                                            child: Center(
                                              child: Text(
                                                state
                                                        .listScoringTableData[
                                                            index]
                                                        .teamName ??
                                                    '-',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            )),
                                        Container(
                                            width: 100,
                                            height: 40,
                                            color: Colors.black12,
                                            child: Center(
                                              child: Text(
                                                "${state.listScoringTableData[index].numberGoalsScored}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            )),
                                      ]),
                                ),
                              ],
                            );
                          }),
                    ]),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
