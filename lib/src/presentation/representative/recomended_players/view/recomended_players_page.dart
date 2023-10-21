import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../service_locator/injection.dart';
import '../../../app/app.dart';
import '../cubit/recomended_players_cubit.dart';

class RecomendedPlayersPage extends StatelessWidget {
  const RecomendedPlayersPage({super.key});

  static Route route() =>
      MaterialPageRoute(builder: (_) => const RecomendedPlayersPage());

  @override
  Widget build(BuildContext context) {
    final teamId = context.read<AuthenticationBloc>().state.selectedTeam.teamId;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jugadores recomendados',
          style: TextStyle(
              color: Colors.grey[200],
              fontSize: 20,
              fontWeight: FontWeight.w900),
        ),
        flexibleSpace: const Image(
          image: AssetImage('assets/images/imageAppBar25.png'),
          fit: BoxFit.cover,
        ),
      ),
      body: BlocProvider(
        create: (_) =>
            locator<RecomendedPlayersCubit>()..onGetRecomendations(teamId!),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          alignment: AlignmentDirectional.bottomEnd,
          fit: StackFit.loose,
          children: [
            BlocConsumer<RecomendedPlayersCubit, RecomendedPlayersState>(
              listener: (context, state) {
                if (state.status.isSubmissionSuccess) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                          content: Text('${state.errorMessage}'),
                          duration: const Duration(seconds: 5)),
                    );
                } else if (state.screenStatus == ScreenStatus.nullData) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                          content: Text(
                              'No hay jugadores recomendados para mostrar'),
                          duration: Duration(seconds: 5)),
                    );
                } else {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                          content: Text('${state.errorMessage}'),
                          duration: Duration(seconds: 5)),
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
                }
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 18.0),
                      child: TextField(
                        onChanged:
                            context.read<RecomendedPlayersCubit>().onFilterList,
                        decoration: InputDecoration(
                          labelText: 'Buscar por nombre de jugador',
                          prefixIcon: const Icon(Icons.search),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      physics: const ScrollPhysics(),
                      child: GridView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(
                            top: 15, left: 15, right: 15, bottom: 65),
                        itemCount: state.recomendationsList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        //physics: const ScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 2 / 3,
                                crossAxisSpacing: 5.0,
                                mainAxisSpacing: 5.0),
                        itemBuilder: (BuildContext ctx, index) {
                          return InkWell(
                            child: Card(
                              color: Colors.grey[100],
                              elevation: 3.0,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey[100],
                                      child: Image.asset(
                                        'assets/images/usuario.png',
                                        width: 60,
                                        height: 60,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      '${state.recomendationsList[index].recommended}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      " Recomendado por: ${state.recomendationsList[index].recommendedBy ?? ''}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                isScrollControlled: true,
                                builder: (_) {
                                  return Container(
                                    height: 300,
                                    color: const Color.fromARGB(
                                        255, 236, 236, 236),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Text(
                                            '¿Desea enviar invitación al jugador ${state.recomendationsList[index].recommended}?',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 50, right: 12, left: 12),
                                          child: Row(children: [
                                            Expanded(
                                              child: TextButton(
                                                onPressed: () {
                                                  context
                                                      .read<
                                                          RecomendedPlayersCubit>()
                                                      .onResponseRecomendation(
                                                          teamId!,
                                                          state
                                                              .recomendationsList[
                                                                  index]
                                                              .id!,
                                                          false);
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          16.0,
                                                          10.0,
                                                          16.0,
                                                          10.0),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xff740411),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15.0)),
                                                  ),
                                                  child: Text(
                                                    'Rechazar recomendación',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'SF Pro',
                                                      color: Colors.grey[200],
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 10.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: TextButton(
                                                onPressed: () {
                                                  context
                                                      .read<
                                                          RecomendedPlayersCubit>()
                                                      .onResponseRecomendation(
                                                          teamId!,
                                                          state
                                                              .recomendationsList[
                                                                  index]
                                                              .id!,
                                                          true);

                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          16.0,
                                                          10.0,
                                                          16.0,
                                                          10.0),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xff045a74),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15.0)),
                                                  ),
                                                  child: Text(
                                                    'Enviar invitación',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'SF Pro',
                                                      color: Colors.grey[200],
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 10.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ]),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
