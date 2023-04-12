import 'package:flutter/material.dart';

import 'available/tournaments_available_tab.dart';
import 'invites/tournaments_invites_tab.dart';

class TournamentSearchPage extends StatelessWidget {
  TournamentSearchPage({super.key, required this.teamId});

  final int teamId;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
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
                'Busqueda de torneos',
                style: TextStyle(
                    color: Colors.grey[200], fontWeight: FontWeight.w900),
              ),
              bottom: const TabBar(
                tabs: [
                  Tab(
                      text: "Torneos disponibles",
                      icon: Icon(Icons.arrow_circle_up_outlined)),
                  Tab(
                      text: "Invitaciones a torneos",
                      icon: Icon(Icons.arrow_circle_down_outlined)),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              TournamentsAvailableTab(teamId: teamId),
              TournamentsInvitesTab(teamId: teamId),
            ],
          ),
        ));
  }
}
