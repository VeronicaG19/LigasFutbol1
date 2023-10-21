import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/core/constans.dart';
import 'package:ligas_futbol_flutter/src/domain/team_player/entity/team_player.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'cubit/recommendation_cubit.dart';

class RecommendationPlayerPage extends StatelessWidget {
  const RecommendationPlayerPage({Key? key, required this.teamPlayer})
      : super(key: key);
  final TeamPlayer teamPlayer;
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user.person.personId;
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            backgroundColor: Colors.grey[200],
            title: Text(
              '${teamPlayer.firstName ?? '-'} ${teamPlayer.lastName ?? '-'}',
            ),
            flexibleSpace: Image(
              image: AssetImage('assets/images/imageAppBar25.png'),
              fit: BoxFit.cover,
            ),
            elevation: 0.0,
          ),
        ),
        body: BlocProvider(
            create: (_) => locator<RecommendationCubit>()
              ..getsAllTeamsPlayer(partyId: user!),
            child: RecommendationPlayerContent(
              teamPlayer: teamPlayer,
            )));
  }
}

class RecommendationPlayerContent extends StatelessWidget {
  const RecommendationPlayerContent({Key? key, required this.teamPlayer})
      : super(key: key);
  final TeamPlayer teamPlayer;
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user.person.personId;
    void recommendationPlayerTeam({teamId}) {
      context.read<RecommendationCubit>().postRecommendations(
          teamId: teamId,
          recommendedBy: user!,
          recommendedId: teamPlayer.partyId!);
    }

    return BlocConsumer<RecommendationCubit, RecommendationState>(
      listener: (context, state) {
        if (state.screenStatus == ScreenStatus.succes) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Se recomendo al jugador correctamente")));
        }else if(state.screenStatus == ScreenStatus.error){
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text(state.errorMessage??'')));
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
          return state.teamList.isEmpty
              ? Container()
              : ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 35),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Column(
                                children: <Widget>[
                                  Icon(Icons.check_circle,
                                      size: 90, color: Color(0xff358aac)),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Recomendar Jugador",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                ],
                              ),
                              Row(
                                children: const [
                                  SizedBox(
                                    width: 40,
                                    height: 30,
                                    child: Text(
                                      "*",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 350,
                                    child: Text(
                                      "Seleccione un equipo para recomendar al jugador",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              GridView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(
                                      top: 15, left: 15, right: 15),
                                  itemCount: state.teamList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              radius: 35,
                                              backgroundColor: Colors.grey[100],
                                              backgroundImage: state
                                                          .teamList[index]
                                                          .logoId
                                                          ?.document ==
                                                      null
                                                  ? const AssetImage(
                                                      kDefaultAvatarImagePath)
                                                  : Image.memory(
                                                      base64Decode(state
                                                          .teamList[index]
                                                          .logoId!
                                                          .document
                                                          .toString()),
                                                    ).image,
                                            ),
                                            Text(
                                              '${state.teamList[index].teamName}',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w900),
                                            )
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        showDialog<void>(
                                          context: context,
                                          barrierDismissible:
                                              false, // user must tap button!
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(
                                                        "¿Deseas recomendar al jugador ${teamPlayer.firstName ?? '-'} "
                                                        "${teamPlayer.lastName ?? '-'} al equipo "
                                                        "${state.teamList[index].teamName}?"),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text(
                                                    "Salir",
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text(
                                                    "Aceptar",
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    recommendationPlayerTeam(
                                                        teamId: state
                                                            .teamList[index]
                                                            .teamId);
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    );
                                  })
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        }
      },
    );
  }
}
