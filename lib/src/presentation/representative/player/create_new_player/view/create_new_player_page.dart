import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/player/create_new_player/cubit/create_new_player_cubit.dart';

import '../../../../../service_locator/injection.dart';
import 'create_new_player_content.dart';

class CreateNewPlayerPage extends StatelessWidget {
  const CreateNewPlayerPage({Key? key, this.teamId}) : super(key: key);

  final int? teamId;

  /*static Route route(TeamPlayersCubit cubit) =>
      MaterialPageRoute(builder: (_) => BlocProvider.value(value: cubit,
        child: const CreateNewPlayerPage(),));*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Crear nuevo jugador",
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.grey[200],
        flexibleSpace: const Image(
          image: AssetImage('assets/images/imageAppBar25.png'),
          fit: BoxFit.fill,
        ),
        // actions: [
        //   _ButtonSearchPlayers(),
        // ],
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
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () async {
      //     Navigator.push(
      //       context,
      //       SearchPlayerPage.route(),
      //     );
      //   },
      //   icon: const Icon(Icons.search, size: 18),
      //   label: Text(
      //     'Buscar jugador',
      //     style: TextStyle(
      //       fontFamily: 'SF Pro',
      //       color: Colors.grey[200],
      //       fontWeight: FontWeight.w500,
      //       fontSize: 12.0,
      //     ),
      //   ),
      //   backgroundColor: const Color(0xff358aac),
      // ),
    );
  }
}
