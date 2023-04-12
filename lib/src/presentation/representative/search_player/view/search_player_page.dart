import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/soccer_team/players/data_player/data_player_content.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/soccer_team/players/team_by_player/team_players_tab.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/constans.dart';
import '../cubit/search_player_cubit.dart';

class SearchPlayerPage extends StatelessWidget {
  const SearchPlayerPage({Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute(builder: (_) => SearchPlayerPage());

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user.person.personId;
    final teamId =
        context.read<AuthenticationBloc>().state.teamManager.teamId;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: const Text(
          'Buscar Jugadores',
          style: TextStyle(
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

      body: BlocProvider(create: (_) =>
        locator<SearchPlayerCubit>()..getSearchPlayers(teamId!, 1),
        child: _PageContent(
      ),),
      /*body: Container(
        child: _PageContent(),
      ),*/
    );
  }
}

class _PageContent extends StatelessWidget {
  const _PageContent({
    Key? key,
  }) : super();

  @override
  Widget build(BuildContext context) {
    final person =
        context.select((AuthenticationBloc bloc) => bloc.state.user.person);
    return BlocConsumer<SearchPlayerCubit,SearchPlayerState>(
        listener: (context, state) {
          if (state.screenStatus == ScreenStatus.error) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('ha ocurrido un error'),
                ),
              );
          } else if (state.screenStatus == ScreenStatus.success) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Buscar jugadores'),
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
          GridView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          itemCount: state.searchPlayer.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0),
          itemBuilder: (BuildContext context, int index) {
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
                      backgroundImage: state.searchPlayer[index].playerPhoto == null
                        ? const AssetImage(kDefaultAvatarImagePath)
                          :Image.memory(
                        base64Decode(state.searchPlayer[index].playerPhoto ?? ''),).image
                      /*const AssetImage(
                        "assets/images/categoria2.png",
                      ),*/
                    ),
                    Text(
                      '${state.searchPlayer[index].namePlayer}\n Edad: ${state.searchPlayer[index].age ?? ''}',
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
                showModalBottomSheet<void>(
                  context: context,
                  builder: (_) {
                    return Container(
                      height: 3000,
                      color: const Color.fromARGB(255, 236, 236, 236),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            const Text('Escribir una mensaje al jugador'),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText: "Comentario",
                                    labelText: 'Enviar una invitacion'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: ElevatedButton(
                                child: const Text('Enviar invitacion'),
                                onPressed: () {
                                  context
                                      .read<SearchPlayerCubit>()
                                      .onSendTeamToPlayerRequest(
                                      state.searchPlayer[index].playerId ?? 0,
                                      context.read<AuthenticationBloc>().state.teamManager.teamId ?? 0);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Le ha mandado una solicitud')));
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        )
          ],
        );
      }
        }
    );


  }
}
