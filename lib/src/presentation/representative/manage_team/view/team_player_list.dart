import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/soccer_team/players/team_by_player/team_players_tab.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/soccer_team/players/team_players/cubit/team_players_cubit.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/constans.dart';
import '../../player/create_new_player/view/create_new_player_page.dart';

class TeamPlayerList extends StatelessWidget {
  const TeamPlayerList({
    Key? key,
    this.teamId,
  }) : super(key: key);

  final int? teamId;

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user;
    return BlocProvider(
      create: (_) => locator<TeamPlayersCubit>()
        ..getTeamPlayer(user.person.personId!, teamId ?? 0),
      child: Column(
        children: [
          _ButtonNewPlayer(
            teamId: teamId,
          ),
          _TeamPlayerListContent(
            teamId: teamId,
          ),
        ],
      ),
    );
  }
}

class _TeamPlayerListContent extends StatelessWidget {
  const _TeamPlayerListContent({
    Key? key,
    this.teamId,
  }) : super(key: key);
  final int? teamId;
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user;
    return BlocListener<NotificationBloc, NotificationState>(
      listenWhen: (previous, current) =>
          previous.notificationCount != current.notificationCount,
      listener: (context, state) {
        context
            .read<TeamPlayersCubit>()
            .getTeamPlayer(user.person.personId!, teamId ?? 0);
      },
      child: BlocBuilder<TeamPlayersCubit, TeamPlayerState>(
        builder: (context, state) {
          if (state.screenStatus == ScreenStatus.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: const Color(0xff358aac),
                size: 50,
              ),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.teamPlayer.length,
              itemBuilder: (BuildContext ctx, index) {
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding:
                            const EdgeInsets.fromLTRB(15, 10, 25, 10),
                        title: Text(
                          '${state.teamPlayer[index].firstName} '
                          '${state.teamPlayer[index].lastName}',
                          style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 15,
                              fontWeight: FontWeight.w900),
                        ),
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.grey[100],
                          backgroundImage:
                              const AssetImage('assets/images/categoria2.png'),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TeamPlayerTab(
                                teamPlayer: state.teamPlayer[index],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class _ButtonNewPlayer extends StatelessWidget {
  const _ButtonNewPlayer({
    Key? key,
    required this.teamId,
  }) : super(key: key);

  final int? teamId;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Plantilla",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<TeamPlayersCubit>(context),
                        child: CreateNewPlayerPage(teamId: teamId),
                      )),
            );
          },
          child: Container(
            key: CoachKey.newPlayerTemM,
            padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
            decoration: const BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            child: const Row(
              children: [
                Text(
                  'Nuevo jugador',
                  style: TextStyle(
                    fontFamily: 'SF Pro',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Icon(
                    Icons.person_add,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
