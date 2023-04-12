import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'cubit/data_player_cubit.dart';

class DataPlayerContent extends StatelessWidget {
  const DataPlayerContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user.person.personId;
    return BlocProvider(
      create: (_) =>
          locator<DataPlayerCubit>()..loadInfoPlayer(personId: user!),
      child: BlocBuilder<DataPlayerCubit, DataPlayerState>(
          builder: (context, state) {
        if (state.screenStatus == ScreenStatus.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: Colors.white70,
              size: 50,
            ),
          );
        } else if (state.screenStatus == ScreenStatus.loaded) {
          return Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Column(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white38,
                      radius: 30,
                      child: Image(
                        image: AssetImage(
                          'assets/images/usuario.png',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${state.playerInfo.firstName ?? "-"} ${state.playerInfo.lastName ?? "-"}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${state.playerInfo.emailAddress ?? "-"}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Posición: ${state.playerInfo.preferencePosition ?? "-"}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .40,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      'Dirección: ${state.playerInfo.playerAddress ?? "-"}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ]),
              ]),
              const SizedBox(
                height: 20,
              ),
            ],
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
