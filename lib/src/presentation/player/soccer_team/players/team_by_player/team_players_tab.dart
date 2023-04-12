import 'package:flutter/material.dart';
import 'package:ligas_futbol_flutter/src/domain/team_player/entity/team_player.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/soccer_team/players/experiences_player/esperiences_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/soccer_team/players/performance_player/performance_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/soccer_team/players/recommendation/recommendation_player.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/soccer_team/players/team_by_player/team_by_player_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/soccer_team/players/transfer_history/transfer_history_page.dart';

class TeamPlayerTab extends StatefulWidget {
  const TeamPlayerTab({Key? key, required this.teamPlayer}) : super(key: key);
  final TeamPlayer teamPlayer;
  @override
  _TeamPlayerTabState createState() => _TeamPlayerTabState();
}

class _TeamPlayerTabState extends State<TeamPlayerTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          flexibleSpace: const Image(
            image: AssetImage('assets/images/imageAppBar25.png'),
            fit: BoxFit.fill,
          ),
          actions: [
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              InkWell(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.thumb_up_alt_sharp,
                                size: 18, color: Colors.white70),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius:
                                BorderRadius.all(Radius.circular(90))),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RecommendationPlayerPage(
                              teamPlayer: widget.teamPlayer),
                          fullscreenDialog: false),
                    );
                  }),
              SizedBox(
                width: 15,
              ),
            ]),
          ],
          elevation: 0.0,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(130),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Center(
                              child: CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                  radius: 35,
                                  child: Image(
                                    image: AssetImage(
                                      'assets/images/usuario.png',
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                        Column(children: [
                          Text(
                            '${widget.teamPlayer.firstName ?? '-'} ${widget.teamPlayer.lastName ?? '-'}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Alias: ${widget.teamPlayer.fullName ?? '-'}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Posición: -',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ]),
                      ]),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TabBar(
                        indicatorSize: TabBarIndicatorSize.label,
                        unselectedLabelColor: Colors.white70,
                        indicatorWeight: 1.0,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white38),
                        tabs: [
                          Tab(
                            height: 25,
                            iconMargin: const EdgeInsets.all(10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.white70, width: 1.5)),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text("Equipos",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10)),
                              ),
                            ),
                          ),
                          Tab(
                            height: 25,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.white70, width: 1.5)),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text("Experiencia",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10)),
                              ),
                            ),
                          ),
                          Tab(
                            height: 25,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.white70, width: 1.5)),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text("Fichajes",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10)),
                              ),
                            ),
                          ),
                          Tab(
                            height: 25,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.white70, width: 1.5)),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text("Rendimiento",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10)),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 18,
                  )
                ],
              )),
        ),
        body: TabBarView(children: [
          //  ManageMembersPage(),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 40, top: 20),
            color: Colors.grey[200],
            child: TeamByPlayerPage(teamPlayer: widget.teamPlayer),
          ),
          Container(
            color: Colors.grey[200],
            child: ExperiencesPage(
              partyId: widget.teamPlayer.partyId!,
              type: ViewType.teamPlayers,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: 40,
            ),
            color: Colors.grey[200],
            child: TransferHistoryPage(teamPlayer: widget.teamPlayer),
          ),
          Container(
            color: Colors.grey[200],
            child: PerformancePage(teamPlayer: widget.teamPlayer),
          ),
          //   NotificationPage(),
        ]),
      ),
    );
    ;
  }
}
