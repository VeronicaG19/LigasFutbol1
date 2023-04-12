import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/category/category_lm/detail/cubit/category_lm_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CurrentTournamentPage extends StatefulWidget {
  CurrentTournamentPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CurrentTournamentPage> createState() => _CurrentTournamentPageState();
}

class _CurrentTournamentPageState extends State<CurrentTournamentPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CategoryLmCubit>().getGoalsTournamentId();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryLmCubit, CategoryLmState>(
      builder: (context, state) {
        if (state.screenStatus == ScreenStatus.tournamentloaded) {
          return state.scoringTournamentDTO.length <= 0
              ? Center(
                  child: const Text("No hay datos",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                )
              : ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 15),
                  children: [
                    Container(
                      height: 50.0,
                      color: Colors.black87,
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Center(
                        child: Text(
                          'PJ:Partidos jugados.      PG:Partidos ganados.      PE:Partidos empatados.      PP:Partidos perdidos.      GF:Goles a favor.      GC:Goles en contra.      DIF:Diferencia de goles.      PTS:Puntos.      PGS: Partidos Ganados por shootouts.      PPS: Partidos Perdidos por shootouts.',
                          style:
                              TextStyle(color: Colors.grey[200], fontSize: 10),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 8, left: 8),
                      height: 40,
                      color: Color(0xff358aac),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 150,
                              child: Text(
                                "Equipo",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[200],
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            SizedBox(
                              width: 35,
                              child: Text(
                                "PJ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[200],
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            SizedBox(
                              width: 35,
                              child: Text(
                                "PG",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[200],
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            SizedBox(
                              width: 35,
                              child: Text(
                                "PE",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[200],
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            SizedBox(
                              width: 35,
                              child: Text(
                                "PP",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[200],
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            SizedBox(
                              width: 35,
                              child: Text(
                                "GF",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[200],
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            SizedBox(
                              width: 35,
                              child: Text(
                                "GC",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[200],
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            SizedBox(
                              width: 35,
                              child: Text(
                                "DIF",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[200],
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            SizedBox(
                              width: 35,
                              child: Text(
                                "PTS",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[200],
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ]),
                    ),
                    ListView(shrinkWrap: true, children: [
                      Column(
                        children: [
                          Container(
                            color: Colors.grey,
                            height: 1,
                          ),
                          Container(
                            height: 40,
                            padding: EdgeInsets.only(right: 8, left: 8),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 150,
                                    child: Center(
                                      child: Text(
                                        "Reino Unido",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      width: 35,
                                      child: Center(
                                        child: Text(
                                          "8",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                  Container(
                                      width: 35,
                                      child: Center(
                                        child: Text(
                                          "8",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                  Container(
                                      width: 35,
                                      child: Center(
                                        child: Text(
                                          "8",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                  Container(
                                      width: 35,
                                      child: Center(
                                        child: Text(
                                          "8",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                  Container(
                                      width: 35,
                                      child: Center(
                                        child: Text(
                                          "8",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                  Container(
                                      width: 35,
                                      child: Center(
                                        child: Text(
                                          "8",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                  Container(
                                      width: 35,
                                      child: Center(
                                        child: Text(
                                          "8",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                  Container(
                                      width: 35,
                                      child: Center(
                                        child: Text(
                                          "8",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                ]),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Divider(),
                          Container(
                            height: 40,
                            padding: EdgeInsets.only(right: 8, left: 8),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 150,
                                    child: Center(
                                      child: Text(
                                        "Barcelona",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      width: 35,
                                      child: Center(
                                        child: Text(
                                          "8",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                  Container(
                                      width: 35,
                                      child: Center(
                                        child: Text(
                                          "8",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                  Container(
                                      width: 35,
                                      child: Center(
                                        child: Text(
                                          "8",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                  Container(
                                      width: 35,
                                      child: Center(
                                        child: Text(
                                          "8",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                  Container(
                                      width: 35,
                                      child: Center(
                                        child: Text(
                                          "8",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                  Container(
                                      width: 35,
                                      child: Center(
                                        child: Text(
                                          "8",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                  Container(
                                      width: 35,
                                      child: Center(
                                        child: Text(
                                          "8",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                  Container(
                                      width: 35,
                                      child: Center(
                                        child: Text(
                                          "8",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                ]),
                          ),
                        ],
                      )
                    ]),
                  ],
                );
        } else if (state.screenStatus == ScreenStatus.tournamentloading ||
            state.screenStatus == ScreenStatus.infoLoading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: const Color(0xff358aac),
              size: 50,
            ),
          );
        } else if (state.screenStatus == ScreenStatus.inSelectCategory) {
          return Center(
            child: const Text("Seleccione una categoria",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
