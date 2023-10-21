import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/domain/team/entity/team.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/requests/request_new_team/view/request_new_team_page.dart';

import '../../../core/constans.dart';
import '../../app/app.dart';
import '../../player/user_menu/user_menu.dart';
import '../../widgets/button_share/button_share_widget.dart';
import '../../widgets/notification_icon/view/notification_icon.dart';
import '../manage_team/view/manage_team_page.dart';
import '../manage_team/view/team_info_bar.dart';
import '../team_matches/view/team_matches_page.dart';
import '../tournaments/view/tournaments_page.dart';

class RepresentativeMainPage extends StatelessWidget {
  const RepresentativeMainPage({
    Key? key,
  }) : super(key: key);

  static Page page() =>
      const MaterialPage<void>(child: RepresentativeMainPage());

  static Route route() =>
      MaterialPageRoute(builder: (_) => const RepresentativeMainPage());

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    final teamId = context
        .select((AuthenticationBloc bloc) => bloc.state.selectedTeam.teamId);
    const double tabSize = 50;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        drawer: Drawer(
          backgroundColor: Colors.grey[200],
          child: const UserMenu(),
        ),
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          title: const _ChangeTeamsOptions(),
          flexibleSpace: const Image(
            image: AssetImage('assets/images/imageAppBar25.png'),
            fit: BoxFit.cover,
            height: 400,
          ),
          actions: [
            SizedBox(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const _ButtonAddTeam(),
                    const ButtonShareWidget(),
                    if (teamId == -1) const SizedBox(),
                    if (teamId != -1)
                      NotificationIcon(
                        applicationRol: user.applicationRol,
                      ),
                  ]),
            )
          ],
          elevation: 0.0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(200),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    //width: 200,
                    height: 140,
                    child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      buildWhen: (previous, current) =>
                          previous.selectedTeam != current.selectedTeam,
                      builder: (context, state) {
                        if (state.selectedTeam.teamId == -1) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return TeamInfoBar(
                          teamId: state.selectedTeam.teamId ?? 0,
                        );
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: TabBar(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: Colors.white70,
                    indicatorWeight: 2.0,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white38,
                    ),
                    tabs: [
                      Tab(
                        key: CoachKey.adminTeamTemM,
                        height: tabSize,
                        child: const _RepresentativeTab(
                          title: 'Equipo',
                          icon: Icons.groups,
                        ),
                      ),
                      Tab(
                        key: CoachKey.myMatchesTemM,
                        height: tabSize,
                        child: const _RepresentativeTab(
                          title: 'Partidos',
                          icon: Icons.scoreboard_outlined,
                        ),
                      ),
                      Tab(
                        key: CoachKey.tournamentTemM,
                        height: tabSize,
                        child: const _RepresentativeTab(
                          title: 'Torneos',
                          icon: Icons.lan,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          buildWhen: (previous, current) =>
              previous.selectedTeam != current.selectedTeam,
          builder: (context, state) {
            if (state.selectedTeam.teamId == -1) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return TabBarView(
              children: [
                ManageTeamPage(teamId: state.selectedTeam.teamId),
                TeamMatchesPage(teamId: state.selectedTeam.teamId),
                TournamentsPage(teamId: state.selectedTeam.teamId),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _RepresentativeTab extends StatelessWidget {
  final String title;
  final IconData icon;

  const _RepresentativeTab({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white70,
          width: 1.5,
        ),
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10),
            ),
            Icon(icon)
          ],
        ),
      ),
    );
  }
}

class _ChangeTeamsOptions extends StatelessWidget {
  const _ChangeTeamsOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final teams = context
        .select((AuthenticationBloc bloc) => bloc.state.teamManagerTeams);
    final items = List.generate(
      teams.length,
      (index) => PopupMenuItem<Team>(
        value: teams[index],
        child: Text(teams[index].teamName ?? '-'),
      ),
    );

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return PopupMenuButton<Team>(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          onSelected: (option) {
            context.read<AuthenticationBloc>().add(ChangeSelectedTeam(option));
          },
          itemBuilder: (context) => items,
          initialValue: state.selectedTeam,
          tooltip: 'Cambiar de equipo',
          child: Row(
            children: [
              Text(
                '${state.selectedTeam.teamName}',
                style: TextStyle(
                  fontFamily: 'SF Pro',
                  color: Colors.grey[100],
                  fontWeight: FontWeight.w900,
                  fontSize: 15.0,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 40,
                color: Colors.grey[100],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ButtonAddTeam extends StatelessWidget {
  const _ButtonAddTeam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white24,
          child: Icon(
            Icons.add,
            size: 18,
            color: Colors.white,
          )),
      onPressed: () async {
        Navigator.push(context, RequestNewTeamPage.route());
      },
    );
  }
}
