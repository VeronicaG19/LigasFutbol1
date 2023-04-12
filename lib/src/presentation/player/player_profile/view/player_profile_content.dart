import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/constans.dart';
import '../../../../service_locator/injection.dart';
import '../../../app/app.dart';
import '../../../widgets/button_share/button_share_widget.dart';
import '../../soccer_team/team/teams_page.dart';
import '../cubit/player_profile_cubit.dart';
import '../edit_player_profile/view/edit_player_profile_page.dart';

class PlayerProfileContent extends StatelessWidget {
  const PlayerProfileContent({Key? key, required this.personId})
      : super(key: key);
  final personId;
  @override
  Widget build(BuildContext context) {
    /*return BlocListener<PlayerProfileCubit, PlayerProfileState>(
      listener: (context, state) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? ''),
            ),
          );
      },
      child: const _ContentProfile(),
    );*/
    return BlocProvider(
      create: (_) =>
          locator<PlayerProfileCubit>()..loadInfoPlayer(personId: personId!),
      child: BlocBuilder<PlayerProfileCubit, PlayerProfileState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: const Text(
                "Ficha de jugador",
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
              backgroundColor: Colors.grey[200],
              flexibleSpace: const Image(
                image: AssetImage('assets/images/imageAppBar25.png'),
                fit: BoxFit.fill,
              ),
              actions: const [
                ButtonShareWidget(),
              ],
            ),
            body: Column(
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/imageAppBar25.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 260.0,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            iconSize: 80.0,
                            icon: BlocBuilder<AuthenticationBloc,
                                AuthenticationState>(
                              builder: (context, state) {
                                return CircleAvatar(
                                  backgroundColor: Colors.black38,
                                  radius: 50,
                                  backgroundImage: state.user.person.photo ==
                                          null
                                      ? const AssetImage(
                                          kDefaultAvatarImagePath)
                                      : Image.memory(
                                          base64Decode(
                                              state.user.person.photo ?? ''),
                                        ).image,
                                );
                              },
                            ),
                            onPressed: () {
                              Navigator.push(
                            context,
                            EditPlayerProfilePage.route(BlocProvider.of<PlayerProfileCubit>(context))
                        );
                             /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return BlocProvider<PlayerProfileCubit>(
                                      create: (_) =>
                                          locator<PlayerProfileCubit>()
                                            ..loadInfoPlayer(
                                                personId: personId!),
                                      child: const EditPlayerProfilePage(),
                                    );
                                  },
                                ),
                              );*/
                            },
                          ),
                          Text(
                            state.playerInfo.getPLayerName,
                            style: const TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 5.0),
                            color: Colors.white,
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 22.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        const Text(
                                          "Edad",
                                          style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2.0,
                                        ),
                                        Text( //agePlayer
                                          context.watch<PlayerProfileCubit>().agePlayer(state.playerInfo.birthday), //${playerAge}
                                          style: const TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.blueGrey,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        const Text(
                                          "Posición",
                                          style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2.0,
                                        ),
                                        Text(
                                          state
                                              .playerInfo.getPreferencePosition,
                                          style: const TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.blueGrey,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: const [
                    TeamPage(type: ScreenType.profile),
                    /*Container(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  height: 55.0,
                  color: Colors.blueGrey[600],
                  child: ListTile(
                      onTap: () {
                      },
                      leading: const Image(
                          image: AssetImage(
                            "assets/images/categoria.png",
                          ),
                          height: 28,
                          width: 28),
                      title: Text(
                        "Agregar experiencia",
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
                      ))),*/
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
