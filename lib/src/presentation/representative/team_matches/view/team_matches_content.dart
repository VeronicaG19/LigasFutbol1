import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/team_matches/cubit/team_matches_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../player/soccer_team/matches_by_player/matche_detail/match_detail_page.dart';

class TeamMatchesContent extends StatefulWidget {
  const TeamMatchesContent({Key? key, this.teamId}) : super(key: key);
  final int? teamId;

  @override
  State<StatefulWidget> createState() => _TeamMatchesContentState();
}

class _TeamMatchesContentState extends State<TeamMatchesContent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamMatchesCubit, TeamMatchesState>(
      builder: (context, state) {
        if (state.screenStatus == ScreenStatus.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: const Color(0xff358aac),
              size: 50,
            ),
          );
        } else {
          return state.matchesList.isNotEmpty
              ? ListView.builder(
                  itemCount: state.matchesList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.only(right: 8, left: 8),
                            color: Colors.black12,
                            height: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  (state.matchesList[index].fecha == null)
                                      ? "Fecha pendiente por agendar "
                                      : "${state.matchesList[index].fecha}",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Jornada ${state.matchesList[index].jornada}",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: Colors.black,
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
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 90,
                                            child: Text(
                                              "${state.matchesList[index].local}",
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w900),
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
                                            width: 70,
                                            child: Text(
                                              (state.matchesList[index]
                                                          .estado ==
                                                      "Pendiente")
                                                  ? "-"
                                                  : (state.matchesList[index]
                                                              .resultado !=
                                                          null)
                                                      ? "${state.matchesList[index].resultado}"
                                                      : 'vs',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900),
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
                                            width: 90,
                                            child: Text(
                                              "${state.matchesList[index].visitante}",
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${state.matchesList[index].estado}",
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.red[800],
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ]),
                                    Column(
                                      children: [
                                        IconButton(
                                            icon: const CircleAvatar(
                                                radius: 100,
                                                backgroundColor: Colors.white70,
                                                child: Icon(
                                                  Icons.workspaces_filled,
                                                  size: 22,
                                                  color: Color(0xff358aac),
                                                )),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MatchesDetailPage(
                                                    matchId: state
                                                        .matchesList[index]
                                                        .matchId!,
                                                    myTeamId: widget.teamId,
                                                    playerId: 0,
                                                  ),
                                                ),
                                              );
                                            }),
                                        const Text("Detalle",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ],
                    );
                  })
              : const Center(child: Text("Este equipo no tiene partidos."));
        }
      },
    );
  }
}
