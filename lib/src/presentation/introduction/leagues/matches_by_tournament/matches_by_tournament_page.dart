import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ligas_futbol_flutter/src/domain/category/category.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/entity/tournament.dart';
import 'package:ligas_futbol_flutter/src/presentation/introduction/leagues/matches_by_tournament/field_location_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/splash/responsive_widget.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'cubit/matches_by_tournament_cubit.dart';

class MatchesByTournamentPage extends StatefulWidget {
  const MatchesByTournamentPage(
      {Key? key, required this.tournament, required this.category})
      : super(key: key);
  final Tournament tournament;
  final Category category;

  @override
  _MatchesByTournamentPageState createState() =>
      _MatchesByTournamentPageState();
}

class _MatchesByTournamentPageState extends State<MatchesByTournamentPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<MatchesByTournamentCubit>()
        ..getFindByNameAndCategory(
            category: widget.category, tournament: widget.tournament),
      child: BlocBuilder<MatchesByTournamentCubit, MatchesByTournamentState>(
        builder: (context, state) {
          if (state.screenStatus == ScreenStatus.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: const Color(0xff358aac),
                size: 50,
              ),
            );
          } else {
            return Stack(
              children: [
                ResponsiveWidget.isSmallScreen(context)
                    ? ListView.builder(
                        itemCount: state.matchesList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.only(right: 10, left: 10),
                                  color: Color(0xff358aac),
                                  height: 20,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        (state.matchesList[index].fecha == null)
                                            ? "Fecha pendiente por agendar"
                                            : DateFormat('dd-MM-yyyy HH:mm')
                                                .format(state
                                                    .matchesList[index].fecha!),
                                        //: "${state.matchesList[index].fecha}",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.grey[200],
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "Jornada ${state.matchesList[index].jornada}",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.grey[200],
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )),
                              Container(
                                  color: Colors.white38,
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    SizedBox(
                                                      width: 85,
                                                      child: Text(
                                                        "${state.matchesList[index].equipoVisita}",
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    const SizedBox(
                                                      width: 30,
                                                      child: Image(
                                                        image: AssetImage(
                                                            'assets/images/playera4.png'),
                                                        fit: BoxFit.fitWidth,
                                                        height: 25,
                                                        width: 25,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 30,
                                                      child: Text(
                                                        (state.matchesList[index]
                                                                    .estadoJuego ==
                                                                "Pendiente")
                                                            ? "0"
                                                            : "${state.matchesList[index].marcadorVisita}",
                                                        /*: state.matchesList[index]
                                                                        .marcadorVisita ==
                                                                    null
                                                                ? '0'
                                                                : "${state.matchesList[index].marcadorVisita}"
                                                                    """${state.matchesList[index].shooutOutVisita == null ? '' : state.matchesList[index].shooutOutVisita == 0 ? state.matchesList[index].shooutOutLocal == 0 ? '' : '' : "(${state.matchesList[index].shooutOutVisita})"}""",*/
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                      child: Text(
                                                        " - ",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 30,
                                                      child: Text(
                                                        (state.matchesList[index]
                                                                    .estadoJuego ==
                                                                "Pendiente")
                                                            ? "0"
                                                            : "${state.matchesList[index].marcadorLocal}",
                                                        /*: state.matchesList[index]
                                                                        .shooutOutLocal ==
                                                                    null
                                                                ? '0'
                                                                : "${state.matchesList[index].marcadorLocal}"
                                                                    """${state.matchesList[index].shooutOutLocal == null ? '' : state.matchesList[index].shooutOutVisita == 0 ? state.matchesList[index].shooutOutLocal == 0 ? '' : '' : "(${state.matchesList[index].shooutOutLocal})"}""",*/
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 30,
                                                      child: Image(
                                                        image: AssetImage(
                                                            'assets/images/playera4.png'),
                                                        height: 25,
                                                        width: 25,
                                                        fit: BoxFit.fitWidth,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    SizedBox(
                                                      width: 85,
                                                      child: Text(
                                                        "${state.matchesList[index].equipoLocal}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "${state.matchesList[index].estadoJuego}",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.red[800],
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              ]),
                                          Column(
                                            children: [
                                              IconButton(
                                                icon: const CircleAvatar(
                                                    radius: 100,
                                                    backgroundColor:
                                                        Colors.white70,
                                                    child: Icon(
                                                      Icons.pin_drop,
                                                      size: 22,
                                                      color: Color(0xff358aac),
                                                    )),
                                                onPressed: () async {
                                                  await Navigator.push(
                                                    context,
                                                    FieldLocationPage.route(
                                                      match: state
                                                          .matchesList[index],
                                                      value: BlocProvider.of<
                                                              MatchesByTournamentCubit>(
                                                          context),
                                                    ),
                                                  );
                                                },
                                              ),
                                              const Text("Campo",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  )),
                            ],
                          );
                          //     TablePage()
                        },
                      )
                    : ListView.builder(
                        itemCount: state.matchesList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.only(right: 8, left: 8),
                                  color: Color(0xff358aac),
                                  height: 20,
                                  child: Row(
                                    children: [
                                      Text(
                                        (state.matchesList[index].fecha == null)
                                            ? "Fecha pendiente por agendar"
                                            : DateFormat('dd-MM-yyyy HH:mm')
                                                .format(state
                                                    .matchesList[index].fecha!),
                                        //: "${state.matchesList[index].fecha}",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.grey[200],
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "Jornada ${state.matchesList[index].jornada}",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.grey[200],
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )),
                              Container(
                                  color: Colors.white38,
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    SizedBox(
                                                      width: 90,
                                                      child: Text(
                                                        "${state.matchesList[index].equipoVisita}",
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 30,
                                                    ),
                                                    const SizedBox(
                                                      width: 30,
                                                      child: Image(
                                                        image: AssetImage(
                                                            'assets/images/playera4.png'),
                                                        fit: BoxFit.fitWidth,
                                                        height: 25,
                                                        width: 25,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 30,
                                                    ),
                                                    SizedBox(
                                                      width: 30,
                                                      child: Text(
                                                        (state.matchesList[index]
                                                                    .estadoJuego ==
                                                                "Pendiente")
                                                            ? "0"
                                                            : "${state.matchesList[index].marcadorVisita}",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 30,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                      child: Text(
                                                        " - ",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 30,
                                                    ),
                                                    SizedBox(
                                                      width: 30,
                                                      child: Text(
                                                        (state.matchesList[index]
                                                                    .estadoJuego ==
                                                                "Pendiente")
                                                            ? "0"
                                                            : "${state.matchesList[index].marcadorLocal}",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 30,
                                                    ),
                                                    const SizedBox(
                                                      width: 30,
                                                      child: Image(
                                                        image: AssetImage(
                                                            'assets/images/playera4.png'),
                                                        height: 25,
                                                        width: 25,
                                                        fit: BoxFit.fitWidth,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 30,
                                                    ),
                                                    SizedBox(
                                                      width: 90,
                                                      child: Text(
                                                        "${state.matchesList[index].equipoLocal}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "${state.matchesList[index].estadoJuego}",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.red[800],
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              ]),
                                          Column(
                                            children: [
                                              IconButton(
                                                icon: const CircleAvatar(
                                                    radius: 100,
                                                    backgroundColor:
                                                        Colors.white70,
                                                    child: Icon(
                                                      Icons.pin_drop,
                                                      size: 22,
                                                      color: Color(0xff358aac),
                                                    )),
                                                onPressed: () async {
                                                  await Navigator.push(
                                                    context,
                                                    FieldLocationPage.route(
                                                      match: state
                                                          .matchesList[index],
                                                      value: BlocProvider.of<
                                                              MatchesByTournamentCubit>(
                                                          context),
                                                    ),
                                                  );
                                                },
                                              ),
                                              const Text("Campo",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  )),
                            ],
                          );
                          //     TablePage()
                        },
                      ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Visibility(
                    visible: state.statusTournament == 'true' &&
                        state.nameCh.isNotEmpty,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue[300])),
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('El equipo campeón es:'),
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
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
