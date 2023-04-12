import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/domain/team/entity/team.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/soccer_team/players/data_player/data_player_content.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/soccer_team/players/team_by_player/team_players_tab.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'cubit/team_players_cubit.dart';

class TeamPlayerPage extends StatelessWidget {
  const TeamPlayerPage({Key? key, required this.team}) : super(key: key);
  final Team team;

  static Route route({required Team team}) =>
      MaterialPageRoute(builder: (_) => TeamPlayerPage(team: team));

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user.person.personId;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text(
          team.teamName ?? '',
          style: const TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
        flexibleSpace: const Image(
          image: AssetImage('assets/images/imageAppBar25.png'),
          fit: BoxFit.cover,
        ),
        elevation: 0.0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(130),
          child: Column(
            children: const [
              DataPlayerContent(),
            ],
          ),
        ),
      ),
      body: BlocProvider(
        create: (_) =>
            locator<TeamPlayersCubit>()..getTeamPlayer(user!, team.teamId!),
        child: _PageContent(
          team: team,
        ),
      ),
    );
  }
}

class _PageContent extends StatelessWidget {
  const _PageContent({
    Key? key,
    required this.team,
  }) : super(key: key);

  final Team team;

  @override
  Widget build(BuildContext context) {
    final person =
        context.select((AuthenticationBloc bloc) => bloc.state.user.person);
    return BlocConsumer<TeamPlayersCubit, TeamPlayerState>(
      listener: (context, state) {
        if (state.screenStatus == ScreenStatus.error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? ''),
              ),
            );
        } else if (state.screenStatus == ScreenStatus.success) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Se ha enviado la solicitud al equipo'),
              ),
            );
        }
      },
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
              state.validationrequet.teamPlayerId == null
                  ? state.validationrequet.lookupName != "SEND"
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                            onPressed: () {
                              context
                                  .read<TeamPlayersCubit>()
                                  .onSendPlayerToTeamRequest(
                                      person.personId ?? 0, team.teamId ?? 0);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                            ),
                            child: const Text('Enviar solicitud'),
                          ),
                        )
                      : Container(
                          child: ElevatedButton(
                            onPressed: () {
                              /*context.read<TeamPlayersCubit>().onSendPlayerToTeamRequest(
                        person.personId ?? 0, team.teamId ?? 0);*/
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.orange),
                            ),
                            child: const Text(
                                'Ya tiene una solicitud enviada a este equipo'),
                          ),
                        )
                  : Container(
                      child: ElevatedButton(
                        onPressed: () {
                          /*context.read<TeamPlayersCubit>().onSendPlayerToTeamRequest(
                        person.personId ?? 0, team.teamId ?? 0);*/
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff358aac)),
                        ),
                        child: const Text('Perteneces a este equipo'),
                      ),
                    ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Mis compañeros",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w900),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                itemCount: state.teamPlayer.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
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
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey[100],
                            backgroundImage: const AssetImage(
                              "assets/images/categoria2.png",
                            ),
                          ),
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
