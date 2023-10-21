import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/bloc/authentication_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/soccer_team/matches_by_player/matches_by_player_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/soccer_team/players/team_players/team_player_page.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';

import '../../../../core/constans.dart';
import '../../../app/notification_bloc/notification_bloc.dart';
import '../players/experiences_player/esperiences_page.dart';
import 'cubit/team_cubit.dart';

enum ScreenType { mainPage, profile }

class TeamPage extends StatelessWidget {
  const TeamPage({
    super.key,
    required this.type,
    required this.playerId,
  });

  final int playerId;

  final ScreenType type;

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user.person.personId;
    print("Person Id---->$user");
    return BlocProvider(
      create: (_) => locator<TeamCubit>()..getsAllTeamsPlayer(partyId: user!),
      child: BlocListener<NotificationBloc, NotificationState>(
      listenWhen: (previous, current) =>
          previous.notificationCount != current.notificationCount,
      listener: (context, state) {
        context.read<TeamCubit>().getsAllTeamsPlayer(partyId: user!);
      },
        child: BlocBuilder<TeamCubit, TeamState>(
          builder: (context, state) {
          return ListView(
            shrinkWrap: true,
            children: [
              PlayerProfileButton(
                key: CoachKey.myMatchPlayer,
                title: 'Ver mis partidos',
                onPressed: () => Navigator.push(
                  context,
                  MatchesByPlayerPage.route(playerId),
                ),
              ),
              if (type == ScreenType.profile)
                Column(
                  children: [
                    const Divider(),
                    PlayerProfileButton(
                      title: 'Ver mi experiencia',
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => ExperiencesPage(
                                    partyId: user!,
                                    type: ViewType.profile,
                                  ))),
                    ),
                    const Divider(),
                    const Text(
                      "Mis Equipos",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w900,
                          fontSize: 16.0),
                    ),
                  ],
                ),
              // if (type == ScreenType.mainPage)
              //   PlayerProfileButton(
              //     key: CoachKey.myMatchPlayer,
              //     title: 'Ver mis partidos',
              //     onPressed: () => Navigator.push(
              //       context,
              //       MatchesByPlayerPage.route(playerId),
              //     ),
              //   ),
              if (state.teamList.isNotEmpty)
                SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                    itemCount: state.teamList.length,
                    physics: const ScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0),
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                        child: Card(
                          color: Colors.grey[100],
                          elevation: 3.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 3,
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[100],
                                  child: Image.asset(
                                    'assets/images/equipo2.png',
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  state.teamList[index].teamName!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TeamPlayerPage(team: state.teamList[index]),
                                fullscreenDialog: false),
                          );
                        },
                      );
                    },
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}

class PlayerProfileButton extends StatelessWidget {
  const PlayerProfileButton(
      {Key? key, required this.title, required this.onPressed})
      : super(key: key);

  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      height: 55.0,
      color: Colors.blueGrey[600],
      child: ListTile(
        onTap: () => onPressed(),
        leading: const Image(
            image: AssetImage(
              "assets/images/categoria.png",
            ),
            height: 28,
            width: 28),
        title: Text(
          title,
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Colors.grey[200],
              fontSize: 15,
              fontWeight: FontWeight.w500),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 20,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
