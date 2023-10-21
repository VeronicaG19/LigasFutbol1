import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/domain/team/entity/team.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/bloc/authentication_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/teams/cubit/team_league_manager_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/teams/detail_team_content.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/teams/requests_remove_player/request_remove_player_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/teams/team_players_lm/team_playerslm_page.dart';

class DetailTeamTab extends StatefulWidget {
  const DetailTeamTab({
    Key? key,
    required this.team,
  }) : super(key: key);
  final Team team;

  static Route route(
          {required Team team,
          required TeamLeagueManagerCubit value,
          required int leagueId}) =>
      MaterialPageRoute(
          builder: (_) => BlocProvider.value(
                value: value
                  ..getCategoryByTournamentByAndLeagueId(legueId: leagueId),
                child: DetailTeamTab(team: team),
              ));

  @override
  State<DetailTeamTab> createState() => _DetailTeamTabState();
}

class _DetailTeamTabState extends State<DetailTeamTab>
    with TickerProviderStateMixin {
  TabController? _nestedTabController;
  @override
  void initState() {
    _nestedTabController = TabController(length: 3, vsync: this);

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
    // final leagueManager = context.select((AuthenticationBloc bloc) => bloc.state.leagueManager);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.grey[200],
          title: Text(
            'Equipo ${widget.team.teamName}',
          ),
          flexibleSpace: const Image(
            image: AssetImage('assets/images/imageAppBar25.png'),
            fit: BoxFit.cover,
          ),
          elevation: 0.0,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 15, right: 8, left: 8),
        shrinkWrap: true,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                padding: const EdgeInsets.only(
                  right: 10,
                  left: 10,
                ),
                controller: _nestedTabController,
                indicatorColor: const Color(0xff045a74),
                labelColor: Colors.black,
                unselectedLabelColor: const Color(0xff045a74),
                isScrollable: true,
                labelStyle: const TextStyle(color: Colors.black54),
                tabs: const [
                  Tab(
                    text: 'Editar equipo',
                  ),
                  Tab(
                    text: 'Jugadores del equipo',
                  ),
                  Tab(
                    text: 'Eliminar jugador',
                  ),
                ],
              ),
              Container(
                height: screenHeight * 0.85,
                margin: const EdgeInsets.only(top: 20, left: 16.0, right: 16.0),
                child: TabBarView(
                  controller: _nestedTabController,
                  children: [
                    DetailTeamContent(team: widget.team),
                    TeamPlayersLMPage(team: widget.team),
                    RequetsRemovePlayerPage(team: widget.team),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
