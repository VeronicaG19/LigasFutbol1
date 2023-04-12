import 'package:flutter/material.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/tournaments/view/detail/general_table/tournament_general_table_tab.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/tournaments/view/detail/role_playing/tournament_role_playing_tab.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/tournaments/view/detail/tournament_information/tournament_information_tab.dart';

import '../../../../../domain/tournament/dto/tournament_by_team/tournament_by_team_dto.dart';

class TournamentDetailPage extends StatelessWidget {
  TournamentByTeamDTO tournamentEntity;

  TournamentDetailPage({
    Key? key,
    required this.tournamentEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(130),
            child: AppBar(
              backgroundColor: Colors.grey[200],
              flexibleSpace: const Image(
                image: AssetImage('assets/images/imageAppBar25.png'),
                fit: BoxFit.cover,
              ),
              elevation: 0.0,
              title: Text(
                'Información de torneo',
                style: TextStyle(
                    color: Colors.grey[200], fontWeight: FontWeight.w900),
              ),
              bottom: const TabBar(
                tabs: [
                  Tab(
                      text: "Tabla general",
                      icon: Icon(Icons.calendar_month_outlined)),
                  Tab(
                      text: "Rol de juegos",
                      icon: Icon(Icons.trending_up_outlined)),
                  Tab(
                      text: "Información",
                      icon: Icon(Icons.info_outline)),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              TournamentGeneralTableTab(
                  tournamentId: tournamentEntity.tournament?.tournamentId ?? 0),
              TournamentRolePlayingTab(
                  tournamentId: tournamentEntity.tournament?.tournamentId ?? 0),
              TournamentInformationTab(tournamentEntity: tournamentEntity),
            ],
          ),
        ));
  }
}
