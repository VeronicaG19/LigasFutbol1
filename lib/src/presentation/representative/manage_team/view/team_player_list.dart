import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/soccer_team/players/team_by_player/team_players_tab.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/soccer_team/players/team_players/cubit/team_players_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/splash/responsive_widget.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:user_repository/user_repository.dart';

import '../../player/create_new_player/view/create_new_player_page.dart';

class TeamPlayerList extends StatelessWidget {
  const TeamPlayerList({Key? key, this.teamId,}) : super(key: key);

  final int? teamId;

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user;
    //final teamId = context.read<AuthenticationBloc>().state.teamManager.teamId;
    return BlocProvider(
      create: (_) => locator<TeamPlayersCubit>()
        ..getTeamPlayer(user.person.personId!, teamId!),
      child: _TeamPlayerListContent(teamId: teamId!),
    );
  }
}

class _TeamPlayerListContent extends StatelessWidget{
  const _TeamPlayerListContent({Key? key, this.teamId,}) : super(key: key);
  final int? teamId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamPlayersCubit, TeamPlayerState>(
      builder: (context, state) {
        if (state.screenStatus == ScreenStatus.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: const Color(0xff358aac),
              size: 50,
            ),
          );
        } else {
          return ListView(
            shrinkWrap: true,
            children: [
              Row(
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
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      print('Id equipo--> $teamId');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                BlocProvider.value(
                                  value: BlocProvider.of<TeamPlayersCubit>(context),
                                  child: CreateNewPlayerPage(teamId: teamId),
                                )
                        ),
                      );
                    },
                    child: Container(
                      padding:
                      const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                      decoration: const BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius:
                        BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Text(
                        'Nuevo jugador',
                        style: TextStyle(
                          fontFamily: 'SF Pro',
                          color: Colors.grey[200],
                          fontWeight: FontWeight.w500,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                itemCount: state.teamPlayer.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent:
                  ResponsiveWidget.getMaxCrossAxisExtent(context),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 140,
                ),
                itemBuilder: (BuildContext ctx, index) {
                  return InkWell(
                    child: Card(
                      color: Colors.grey[100],
                      elevation: 3.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 15),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey[100],
                            backgroundImage: const AssetImage(
                              "assets/images/categoria2.png",
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${state.teamPlayer[index].firstName} ${state.teamPlayer[index].lastName}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 12,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TeamPlayerTab(
                              teamPlayer: state.teamPlayer[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }
}