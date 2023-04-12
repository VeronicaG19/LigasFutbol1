import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/category/category_lm/detail/cubit/category_lm_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GoalsTeamimPage extends StatefulWidget {
  const GoalsTeamimPage({
    Key? key,
  }) : super(key: key);

  @override
  _GoalsTeamimPageState createState() => _GoalsTeamimPageState();
}

class _GoalsTeamimPageState extends State<GoalsTeamimPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryLmCubit, CategoryLmState>(
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
                        width: 180,
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
                        width: 50,
                        child: Text(
                          "Partidos",
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 40,
                                  width: 180,
                                  child: Center(
                                    child: Text(
                                      "${state.goalsTournament[index].player} ",
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
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        "${state.goalsTournament[index].scoringTableId}",
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
    );
  }
}
