import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/domain/category/category.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/entity/tournament.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'cubit/goals_by_tournament_cubit.dart';

class GoalsByTournamentPage extends StatefulWidget {
  const GoalsByTournamentPage(
      {Key? key, required this.tournament, required this.category})
      : super(key: key);
  final Tournament tournament;
  final Category category;
  @override
  _GoalsByTournamentPageState createState() => _GoalsByTournamentPageState();
}

class _GoalsByTournamentPageState extends State<GoalsByTournamentPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<GoalsByTournamentCubit>()
        ..getFindByNameAndCategory(
            tournament: widget.tournament, category: widget.category),
      child: BlocBuilder<GoalsByTournamentCubit, GoalsByTournamentState>(
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
                Container(
                  padding: EdgeInsets.only(right: 8, left: 8),
                  height: 40,
                  color: Color(0xff358aac),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 30,
                          child: Text(
                            "Pos",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[200],
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            "Jugador",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[200],
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        SizedBox(
                          width: 70,
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
                            "Goles",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[200],
                                fontWeight: FontWeight.w900),
                          ),
                        )
                      ]),
                ),
                ListView.builder(
                    itemCount: state.goalsTournament.length,
                    padding: EdgeInsets.only(top: 40),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            color: Colors.grey,
                            height: 1,
                          ),
                          Container(
                            height: 50,
                            padding: EdgeInsets.only(right: 8, left: 8),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    child: Center(
                                      child: Text(
                                        "${index+1} ",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      width: 50,
                                      height: 180,
                                      child: Center(
                                        child: Text(
                                          "${state.goalsTournament[index].player}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                  Container(
                                    height: 40,
                                    width: 70,
                                    child: Center(
                                      child: Text(
                                        "${state.goalsTournament[index].team}",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 35,
                                    child: Center(
                                        child: Text(
                                      "${state.goalsTournament[index].goals}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    )),
                                  ),
                                ]),
                          ),
                        ],
                      );
                      //     TablePage()
                    })
              ],
            );
          }
        },
      ),
    );
  }
}
