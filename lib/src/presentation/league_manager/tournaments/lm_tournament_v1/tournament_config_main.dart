import 'package:flutter/material.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/tournaments/lm_tournament_v1/tournaments_widgets/clasification.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/tournaments/lm_tournament_v1/tournaments_widgets/tournament_configuration.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/tournaments/lm_tournament_v1/tournaments_widgets/tournaments_teams.dart';

class TournamentConfigMain extends StatefulWidget {
  @override
  _TournamentConfigMainState createState() => _TournamentConfigMainState();
}

class _TournamentConfigMainState extends State<TournamentConfigMain>
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
            text: 'Configuracion',
          ),
          Tab(
            text: 'Equipos',
          ),
          Tab(
            text: 'Clasificación',
          ),
          /* Tab(
              text: 'Sanciones',
            ),*/
        ],
      ),
      Container(
        height: screenHeight * 0.70,
        color: Colors.grey[200],
        margin: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: TabBarView(
          controller: _nestedTabController,
          children: [
            ConfigurationTournament(),
            Card(
              color: Colors.grey[200],
              child: TournamentsTeams(),
            ),
            Clasification(),
            /*Center(
                child: Text('Calls Page'),
              ),*/
          ],
        ),
      ),
    ]);
  }
}
