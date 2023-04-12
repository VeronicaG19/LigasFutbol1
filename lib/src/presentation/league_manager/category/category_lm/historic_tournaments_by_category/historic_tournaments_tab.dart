import 'package:flutter/material.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/category/category_lm/goals_team_lm.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/category/current_tournament_page.dart';

class HistoricTournamentsTab extends StatefulWidget {
  const HistoricTournamentsTab({
    Key? key,
  }) : super(key: key);

  @override
  State<HistoricTournamentsTab> createState() => _HistoricTournamentsTabState();
}

class _HistoricTournamentsTabState extends State<HistoricTournamentsTab>
    with TickerProviderStateMixin {
  TabController? _nestedTabController;
  @override
  void initState() {
    _nestedTabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return ListView(
      padding: EdgeInsets.only(
        top: 25,
      ),
      children: [
        Text( "Torneo Municipal 2023" ,
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        SizedBox(
          height: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              padding: EdgeInsets.only(left: 25, right: 25),
              controller: _nestedTabController,
              indicatorColor: Color(0xff045a74),
              labelColor: Colors.black,
              unselectedLabelColor: Color(0xff045a74),
              isScrollable: true,
              labelStyle: TextStyle(color: Colors.black54),
              tabs: const [
                Tab(
                  text: 'Tabla de posiciones',
                ),
                Tab(
                  text: 'Tabla de Goleo',
                ),
              ],
            ),
            Container(
              height: screenHeight * 0.70,
              margin: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: TabBarView(
                controller: _nestedTabController,
                children: [CurrentTournamentPage(), GoalsTeamimPage()],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
