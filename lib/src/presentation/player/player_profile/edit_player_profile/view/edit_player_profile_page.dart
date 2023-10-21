import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/player_profile_cubit.dart';
import 'edit_player_profile_content.dart';

class EditPlayerProfilePage extends StatelessWidget {
  const EditPlayerProfilePage({Key? key}) : super(key: key);
  static Route route(PlayerProfileCubit cubit) =>
      MaterialPageRoute(builder: (_) => BlocProvider.value(value: cubit,
        child: const EditPlayerProfilePage(),));
  /*static Route route() =>
      MaterialPageRoute<void>(builder: (_) => const EditPlayerProfilePage());*/

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerProfileCubit, PlayerProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text( 
              "Actualizar datos",
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
            backgroundColor: Colors.grey[200],
            flexibleSpace: const Image(
              image: AssetImage('assets/images/imageAppBar25.png'),
              fit: BoxFit.fill,
            ),
            elevation: 0.0,
          ),
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const Center(child: EditPlayerProfileContent()),
          ),
        );
      },
    );
  }
}
