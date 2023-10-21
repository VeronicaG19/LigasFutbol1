import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../player_profile/player_experience/view/player_experiece_page.dart';
import 'cubit/experiences_cubit.dart';

enum ViewType { profile, teamPlayers }

class ExperiencesPage extends StatelessWidget {
  const ExperiencesPage({
    Key? key,
    required this.partyId,
    required this.type,
  }) : super(key: key);

  //final TeamPlayer teamPlayer;
  final int partyId;
  final ViewType type;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          locator<ExperiencesCubit>()..getExperiencesByPlayer(partyId!),
      child: BlocBuilder<ExperiencesCubit, ExperiencesState>(
        builder: (context, state) {
          if (state.screenStatus == ScreenStatus.loading) {
            //pantalla antes de mostrar experiencia

            return Scaffold(
              appBar: AppBar(
                title: const Text("Mi experiencia"),
                backgroundColor: Colors.grey[200],
                flexibleSpace: const Image(
                  image: AssetImage('assets/images/imageAppBar25.png'),
                  fit: BoxFit.fill,
                ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          PlayerExperiencePage.route(
                              BlocProvider.of<ExperiencesCubit>(context)));
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                      decoration: const BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Text(
                        'Agregar',
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
                elevation: 0.0,
              ),
              body: Container(
                color: Colors.grey[200],
                child: Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                    color: const Color(0xff358aac),
                    size: 50,
                  ),
                ),
              ),
            );
          } else {
            if (type == ViewType.teamPlayers) {
              return ListView.builder(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                itemCount: state.experiencesList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                      color: Colors.grey[100],
                      elevation: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        width: 350,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 35,
                                    backgroundColor: Colors.grey[100],
                                    backgroundImage: state
                                                .experiencesList[index]
                                                .fileId
                                                ?.document ==
                                            null
                                        ? const AssetImage(
                                            "assets/images/equipo.png")
                                        : Image.memory(
                                            base64Decode(state
                                                .experiencesList[index]
                                                .fileId!
                                                .document
                                                .toString()),
                                          ).image,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
//CrossAxisAlignment.end ensures the components are aligned from the right to left.
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 8),
                                        width: 150,
                                        color: Colors.black54,
                                        height: 2,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                          "Liga ${state.experiencesList[index].leagueName ?? '-'}"),
                                      Text(
                                          "Torneo ${state.experiencesList[index].tournament ?? '-'}"),
                                      Text(
                                          "Categoría ${state.experiencesList[index].teamCategory ?? '-'}"),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Equipo ${state.experiencesList[index].team ?? '-'}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text("Jugador"),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${state.experiencesList[index].experiencesTitle ?? '-'}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                          "${state.experiencesList[index].experiencesDescription ?? '-'}"),
                                    ],
                                  )
                                ],
                              ),
                            ]),
                      ));
                  //     TablePage()
                },
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Mi experiencia"),
                  backgroundColor: Colors.grey[200],
                  flexibleSpace: const Image(
                    image: AssetImage('assets/images/imageAppBar25.png'),
                    fit: BoxFit.fill,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            PlayerExperiencePage.route(
                                BlocProvider.of<ExperiencesCubit>(context)));
                      },
                      child: Container(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                        decoration: const BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Text(
                          'Agregar',
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
                  elevation: 0.0,
                ),
                body: Container(
                  color: Colors.grey[200],
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    itemCount: state.experiencesList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                          color: Colors.grey[100],
                          elevation: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            width: 350,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.grey[100],
                                        backgroundImage: state
                                                    .experiencesList[index]
                                                    .fileId
                                                    ?.document ==
                                                null
                                            ? const AssetImage(
                                                "assets/images/equipo.png")
                                            : Image.memory(
                                                base64Decode(state
                                                    .experiencesList[index]
                                                    .fileId!
                                                    .document
                                                    .toString()),
                                              ).image,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            state.experiencesList[index]
                                                    .experiencesTitle ??
                                                '-',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                              "Liga ${state.experiencesList[index].leagueName ?? '-'}"),
                                          Text(
                                              "Torneo ${state.experiencesList[index].tournament ?? '-'}"),
                                          Text(
                                              "Categoría ${state.experiencesList[index].teamCategory ?? '-'}"),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Equipo ${state.experiencesList[index].team ?? '-'}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text("Jugador"),
                                        ],
                                      ),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const SizedBox(height: 4),
                                          Text(state.experiencesList[index]
                                                  .experiencesDescription ??
                                              '-'),
                                        ],
                                      ))
                                    ],
                                  ),
                                ]),
                          ));
                      //     TablePage()
                    },
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
