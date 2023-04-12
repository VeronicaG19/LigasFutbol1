import 'package:flutter/material.dart';
import 'package:ligas_futbol_flutter/src/domain/category/entity/category.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/entity/tournament.dart';
import 'package:ligas_futbol_flutter/src/presentation/introduction/leagues/classification_by_tournament/classification_by_tournament_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/introduction/leagues/goals_by_tournament/goals_by_tournament.dart';
import 'package:ligas_futbol_flutter/src/presentation/introduction/leagues/matches_by_tournament/matches_by_tournament_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/introduction/leagues/request_team_by_league/request_team_by_league_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/splash/responsive_widget.dart';

class TabBarMatchesPage extends StatefulWidget {
  final Tournament tournament;
  final Category categoryInfo;
  const TabBarMatchesPage(
      {super.key, required this.tournament, required this.categoryInfo});

  @override
  State<TabBarMatchesPage> createState() => _TabBarMatchesPageState();
}

class _TabBarMatchesPageState extends State<TabBarMatchesPage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
          backgroundColor: Colors.blueGrey[50],
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(150),
            child: AppBar(
              flexibleSpace: const Image(
                image: AssetImage('assets/images/imageAppBar.png'),
                fit: BoxFit.fitWidth,
              ),
              title: Text("Categoría ${widget.categoryInfo.categoryName}",
                  style: TextStyle(fontWeight: FontWeight.w900)),
              backgroundColor: const Color(0xff358aac),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    text: ("Partidos"),
                  ),
                  Tab(
                    text: ("Clasif."),
                  ),
                  Tab(
                    text: ("Goleo"),
                  ),
                  Tab(
                    text: ("Reclutar"),
                  )
                ],
              ),
            ),
          ),
          body: ResponsiveWidget.isSmallScreen(context)
              ? TabBarView(children: [
                  MatchesByTournamentPage(
                      tournament: widget.tournament,
                      category: widget.categoryInfo),
                  ClassificationByTournamentPage(
                      tournament: widget.tournament,
                      category: widget.categoryInfo),
                  GoalsByTournamentPage(
                      tournament: widget.tournament,
                      category: widget.categoryInfo),
                  RequestTeamByLeaguePage(
                      tournament: widget.tournament,
                      category: widget.categoryInfo),
                ])
              : TabBarView(children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 250, left: 250, top: 30, bottom: 30),
                    child: MatchesByTournamentPage(
                        tournament: widget.tournament,
                        category: widget.categoryInfo),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 250, left: 250, top: 30, bottom: 30),
                    child: ClassificationByTournamentPage(
                        tournament: widget.tournament,
                        category: widget.categoryInfo),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 250, left: 250, top: 30, bottom: 30),
                    child: GoalsByTournamentPage(
                        tournament: widget.tournament,
                        category: widget.categoryInfo),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 250, left: 250, top: 30, bottom: 30),
                    child: RequestTeamByLeaguePage(
                        tournament: widget.tournament,
                        category: widget.categoryInfo),
                  ),
                ])),
    );
  }
}
