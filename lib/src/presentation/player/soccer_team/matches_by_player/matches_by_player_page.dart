import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/bloc/authentication_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/soccer_team/matches_by_player/matche_detail/match_detail_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/soccer_team/matches_by_player/team_list_page.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'cubit/matches_cubit.dart';

class MatchesByPlayerPage extends StatefulWidget {
  const MatchesByPlayerPage({Key? key, required this.playerId})
      : super(key: key);
  final int playerId;

  static Route route(int playerId) => MaterialPageRoute(
      builder: (_) => MatchesByPlayerPage(playerId: playerId));

  @override
  _MatchesByPlayerPageState createState() => _MatchesByPlayerPageState();
}

class _MatchesByPlayerPageState extends State<MatchesByPlayerPage> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user.person.personId;
    final playerInfo = context
        .select((AuthenticationBloc bloc) => bloc.state.playerData.playerid);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.grey[200],
          title: Text(
            'Mis partidos',
          ),
          flexibleSpace: Image(
            image: AssetImage('assets/images/imageAppBar25.png'),
            fit: BoxFit.cover,
          ),
          elevation: 0.0,
        ),
      ),
      body: BlocProvider(
        create: (_) =>
            locator<MatchesCubit>()..getTeamByPlayer(personId: user!),
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            TeamListPage(),
            SizedBox(
              height: 15,
            ),
            MatchesByPlayerContent(playerId: playerInfo ?? 0)
          ],
        ),
      ),
    );
  }
}

class MatchesByPlayerContent extends StatefulWidget {
  const MatchesByPlayerContent({Key? key, required this.playerId})
      : super(key: key);
  final int playerId;

  @override
  _MatchesByPlayerContentState createState() => _MatchesByPlayerContentState();
}

class _MatchesByPlayerContentState extends State<MatchesByPlayerContent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchesCubit, MatchesState>(
      builder: (context, state) {
        if (state.screenStatus == ScreenStatus.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: const Color(0xff358aac),
              size: 50,
            ),
          );
        } else {
          return state.matchesList.isEmpty
              ? const Center(
                  child: Text("Sin partidos"),
                )
              : ListView.builder(
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
                                      ? "Fecha pendiente por agendar"
                                      : DateFormat('dd-MM-yyyy HH:mm').format(
                                          state.matchesList[index].fecha!),
                                  //: "${state.matchesList[index].fecha}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Jornada ${state.matchesList[index].jornada}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black,
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 85,
                                      child: Text(
                                        "${state.matchesList[index].visitante}",
                                        textAlign: TextAlign.end,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
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
                                        (state.matchesList[index].resultado ==
                                                null)
                                            ? "-"
                                            : "${state.matchesList[index].resultado}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 13,
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
                                      width: 85,
                                      child: Text(
                                        "${state.matchesList[index].local}",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                  ],
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
                                                    myTeamId: state.myTeam,
                                                    playerId: widget.playerId),
                                          ),
                                        );
                                      }),
                                  Text("Detalle",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                    //     TablePage()
                  });
        }
      },
    );
  }
}
