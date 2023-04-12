import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/domain/team/entity/team.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/teams/requests_remove_player/cubit/request_remove_player_cubit.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RequetsRemovePlayerPage extends StatelessWidget {
  const RequetsRemovePlayerPage({super.key, required this.team});
  final Team team;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<RequestRemovePlayerCubit>()
        ..getUserDeleteRequest(teamId: team.teamId!),
      child: const RequetsRemovePlayerContent(),
    );
  }
}

class RequetsRemovePlayerContent extends StatelessWidget {
  const RequetsRemovePlayerContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestRemovePlayerCubit, RequestRemovePlayerState>(
      builder: (context, state) {
        if (state.screenStatus == ScreenStatus.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: const Color(0xff358aac),
              size: 50,
            ),
          );
        }
        return state.userRequest.length <= 0
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
                      "Solicitudes para eliminar jugadores",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  GridView.builder(
                    itemCount: state.userRequest.length,
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
                                radius: 40,
                                backgroundColor: Colors.white10,
                                child: Image.asset("assets/images/usuario.png",
                                    height: 65, width: 65),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                state.userRequest[index].requestMadeBy,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900),
                              ),
                              Text(
                                'Posición: Delantero',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 10,
                                ),
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

                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.only(top: 15, left: 15, right: 15),

                    physics: const NeverScrollableScrollPhysics(),
                    //physics: const ScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 6,
                            childAspectRatio: 1,
                            crossAxisSpacing: 12.0,
                            mainAxisSpacing: 12.0),
                  ),
                ],
              );
      },
    );
  }
}
