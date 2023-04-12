import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/player/create_new_player/cubit/create_new_player_cubit.dart';

import '../../../../../service_locator/injection.dart';
import '../../../../app/app.dart';
import '../../../../player/soccer_team/players/team_players/cubit/team_players_cubit.dart';
import '../../../search_player/view/search_player_page.dart';
import 'create_new_player_content.dart';

class CreateNewPlayerPage extends StatelessWidget{
  const CreateNewPlayerPage ({Key? key, this.teamId}) : super(key: key);

  final int? teamId;

  /*static Route route(TeamPlayersCubit cubit) =>
      MaterialPageRoute(builder: (_) => BlocProvider.value(value: cubit,
        child: const CreateNewPlayerPage(),));*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear nuevo jugador"),
        backgroundColor: Colors.grey[200],
        flexibleSpace: const Image(
          image: AssetImage('assets/images/imageAppBar25.png'),
          fit: BoxFit.fill,
        ),
        actions: [
          _ButtonSearchPlayers(),
        ],
        elevation: 0.0,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: BlocProvider<CreateNewPlayerCubit>(
          create: (_) => locator<CreateNewPlayerCubit>(),
          child: CreateNewPlayerContent(teamId: teamId),
        ),
      ),
    );
  }
}

class _ButtonSearchPlayers extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        Navigator.push(
          context,
          SearchPlayerPage.route(),
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
          'Buscar jugador',
          style: TextStyle(
            fontFamily: 'SF Pro',
            color: Colors.grey[200],
            fontWeight: FontWeight.w500,
            fontSize: 10.0,
          ),
        ),
      ),
    );
  }
}