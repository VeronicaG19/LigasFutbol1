import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/domain/team/entity/team.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/teams/team_players_lm/cubit/team_players_lm_cubit.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TeamPlayersLMPage extends StatelessWidget {
  const TeamPlayersLMPage({super.key, required this.team});
  final Team team;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          locator<TeamPlayersLmCubit>()..getTeamPlayer(teamId: team.teamId!),
      child: const TeamPlayersLMContent(),
    );
  }
}

class TeamPlayersLMContent extends StatelessWidget {
  const TeamPlayersLMContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamPlayersLmCubit, TeamPlayersLMState>(
      builder: (context, state) {
        if (state.screenStatus == ScreenStatus.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: const Color(0xff358aac),
              size: 50,
            ),
          );
        }
        return state.teamPlayer.length <= 0
            ? Center(
                child: const Text("No hay datos",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              )
            : ListView(
                shrinkWrap: true,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Compañeros de equipo",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.only(top: 15, left: 15, right: 15),
                    itemCount: state.teamPlayer.length,
                    physics: const NeverScrollableScrollPhysics(),
                    //physics: const ScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            childAspectRatio: 1,
                            crossAxisSpacing: 12.0,
                            mainAxisSpacing: 12.0),
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                        child: Card(
                          color: Colors.grey[100],
                          elevation: 3.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white10,
                                child: Image.asset(
                                    "assets/images/categoria2.png",
                                    height: 60,
                                    width: 60),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                '${state.teamPlayer[index].playerName}',
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
                          /*  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TeamPlayerTab(teamPlayer: state.teamPlayer[index]),
                      ),
                    );*/
                        },
                      );
                    },
                  ),
                ],
              );
      },
    );
    ;
  }
}
