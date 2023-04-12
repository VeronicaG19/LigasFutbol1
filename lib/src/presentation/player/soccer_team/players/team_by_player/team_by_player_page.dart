import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/domain/team/entity/team.dart';
import 'package:ligas_futbol_flutter/src/domain/team_player/entity/team_player.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/soccer_team/players/team_by_player/cubit/team_by_cubit.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TeamByPlayerPage extends StatefulWidget {
  const TeamByPlayerPage({Key? key, required this.teamPlayer})
      : super(key: key);
  final TeamPlayer teamPlayer;
  @override
  _TeamByPlayerPageState createState() => _TeamByPlayerPageState();
}

class _TeamByPlayerPageState extends State<TeamByPlayerPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<TeamByPlayersCubit>()
        ..getsAllTeamsPlayer(partyId: widget.teamPlayer.partyId!),
      child: BlocBuilder<TeamByPlayersCubit, TeamByPlayerState>(
        builder: (context, state) {
          if (state.screenStatus == ScreenStatus.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: const Color(0xff358aac),
                size: 50,
              ),
            );
          } else {
            return state.teamList.isEmpty
                ? Container()
                : ListView(
                    shrinkWrap: true,
                    children: [
                      Divider(),
                      GridView.builder(
                        itemCount: state.teamList.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 1,
                                crossAxisSpacing: 5.0,
                                mainAxisSpacing: 5.0),
                        itemBuilder: (BuildContext ctx, index) {
                          return InkWell(
                            child: Card(
                              color: Colors.grey[100],
                              elevation: 3.0,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                    radius: 28,
                                    backgroundColor: Colors.grey[100],
                                    backgroundImage: state.teamList[index]
                                                .logoId?.document ==
                                            null
                                        ? const AssetImage(
                                            "assets/images/equipo.png")
                                        : Image.memory(
                                            base64Decode(state.teamList[index]
                                                .logoId!.document
                                                .toString()),
                                          ).image,
                                  ),
                                  Text(
                                    '${state.teamList[index].teamName}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w900),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              /*  showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                context: context,
                                builder: (contextS) {
                                  return StaticsTeamByPlayer(
                                    team: state.teamList[index],
                                  );
                                },
                              );*/
                            },
                          );
                        },
                      ),
                    ],
                  );
          }
        },
      ),
    );
  }
}

class StaticsTeamByPlayer extends StatelessWidget {
  const StaticsTeamByPlayer({Key? key, this.team}) : super(key: key);
  final Team? team;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: EdgeInsets.only(top: 35, right: 15, left: 15),
            height: 450,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey[100],
                          backgroundImage: team?.logoId?.document == null
                              ? const AssetImage("assets/images/equipo.png")
                              : Image.memory(
                                  base64Decode(team!.logoId?.document ?? ''),
                                ).image,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "México",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            width: 40,
                            height: 40,
                            color: Color(0xff41ac35),
                            child: Icon(
                              Icons.sports_volleyball,
                              color: Colors.white70,
                            )),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          height: 40,
                          padding: EdgeInsets.only(top: 10),
                          width: 250,
                          child: Text(
                            "Goles anotados:",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            "3",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w900),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                            width: 40,
                            height: 40,
                            color: Color(0xff358aac),
                            child: Icon(
                              Icons.accessibility,
                              color: Colors.white70,
                            )),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          height: 40,
                          padding: EdgeInsets.only(top: 10),
                          width: 250,
                          child: Text(
                            "Partidos jugados:",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            "3",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w900),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                            width: 40,
                            height: 40,
                            color: Color(0xffac3535),
                            child: Icon(
                              Icons.workspaces_filled,
                              color: Colors.white70,
                            )),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          height: 40,
                          padding: EdgeInsets.only(top: 10),
                          width: 250,
                          child: Text(
                            "Tarjetas rojas:",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            "1",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w900),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                            width: 40,
                            height: 40,
                            color: Color(0xffaca035),
                            child: Icon(
                              Icons.adjust_sharp,
                              color: Colors.white70,
                            )),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          height: 40,
                          padding: EdgeInsets.only(top: 10),
                          width: 250,
                          child: Text(
                            "Tarjetas amarillas:",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            "4",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w900),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 280.0,
          top: 10,
          right: 0.0,
          child: TextButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
              decoration: const BoxDecoration(
                color: Color(0xff740408),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              child: Text(
                'Salir',
                style: TextStyle(
                  fontFamily: 'SF Pro',
                  color: Colors.grey[200],
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
