import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/home/fields/fields_league_manager_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/home/referee/referee_league_manager_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/home/tournaments/tournament_league_manager_page.dart';

import '../../app/bloc/authentication_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
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
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.leagueManager);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TabBar(
          controller: _nestedTabController,
          indicatorColor: Colors.blue,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.black54,
          isScrollable: true,
          tabs: const [
            Tab(
              text: 'Torneos',
            ),
            Tab(
              text: 'Arbitros',
            ),
            Tab(
              text: 'Campos',
            ),
          ],
        ),
        Container(
          height: screenHeight * 0.50,
          margin: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: TabBarView(
            controller: _nestedTabController,
            children: const [
              TournamentLeagueManegerPage(),
              RefereeLeagueManagerPage(),
              FieldsLeagueManagerPage(),
            ],
          ),
        ),
      ],
    );
  }
}
