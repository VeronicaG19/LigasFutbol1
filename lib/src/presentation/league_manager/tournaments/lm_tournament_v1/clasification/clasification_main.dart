import 'package:flutter/material.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/entity/tournament.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/tournaments/lm_tournament_v1/clasification/role_games.dart';

import '../scoring_table_tournamens/scorint_table_main_page.dart';

class ClasificationMain extends StatefulWidget {
  final Tournament? tournament;

  const ClasificationMain({super.key, required this.tournament});
  @override
  _ClasificationMainState createState() => _ClasificationMainState();
}

class _ClasificationMainState extends State<ClasificationMain>
    with TickerProviderStateMixin {
  late TabController _nestedTabController;

  @override
  void initState() {
    _nestedTabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      TabBar(
        controller: _nestedTabController,
        indicatorColor: Colors.black,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.blue[300],
        isScrollable: true,
        tabs: const [
          Tab(
            text: 'Rol de juegos',
            icon: Icon(Icons.calendar_month_outlined),
          ),
          Tab(
            text: 'Clasificación',
            icon: Icon(Icons.insert_chart_outlined_outlined),
          ),
          Tab(
            text: 'Tabla de goleo',
            icon: Icon(Icons.perm_contact_calendar_rounded),
          ),
        ],
      ),
      Container(
        height: screenHeight * 0.55,
        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: TabBarView(
          controller: _nestedTabController,
          children: [
            const Center(
              child: RoleGames(screen: 1),
            ),
            const Center(
              child: RoleGames(screen: 2),
            ),
            Center(
              child: ScoringTableMainPage(tournament: widget.tournament!),
            ),
          ],
        ),
      ),
    ]);
  }
}
