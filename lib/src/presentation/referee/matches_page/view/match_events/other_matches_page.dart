import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/referee_match.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/soccer_team/matches_by_player/matche_detail/match_detail_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/cubit/ref_matches_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/view/match_events/match_events_page.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../app/app.dart';

class OtherMatchesPage extends StatelessWidget {
  const OtherMatchesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final referee =
        context.select((AuthenticationBloc bloc) => bloc.state.refereeData);
    return BlocProvider(
      create: (_) =>
          locator<RefMatchesCubit>()..onLoadInitialData(referee.refereeId ?? 0),
      child: _PageContent(refereeId: referee.refereeId ?? 0),
    );
  }
}

class _PageContent extends StatelessWidget {
  const _PageContent({Key? key, required this.refereeId}) : super(key: key);
  final int refereeId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc, NotificationState>(
      listenWhen: (previous, current) =>
          previous.notificationCount != current.notificationCount,
      listener: (context, state) {
        context.read<RefMatchesCubit>().onLoadInitialData(refereeId);
      },
      child: BlocConsumer<RefMatchesCubit, RefMatchesState>(
        listener: (context, state) {
          if (state.screenState == BasicCubitScreenState.success) {
            if (state.statusMessage == "1") {
              showTopSnackBar(
                context,
                CustomSnackBar.success(
                  backgroundColor: Colors.green[800]!,
                  textScaleFactor: 1.0,
                  message: 'El partido ha comenzado correctamente',
                ),
              );
              context.read<RefMatchesCubit>().onLoadInitialData(refereeId);
            }
          }
        },
        builder: (context, state) {
          if (state.screenState == BasicCubitScreenState.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: const Color(0xff358aac),
                size: 50,
              ),
            );
          }
          return state.finishedMatchesList.isEmpty
              ? const Center(
                  child: Text('Sin partidos para mostrar'),
                  // child: ListTile(
                  //   title: const Text('prueba'),
                  //   subtitle: const Text('Subtitulo de prueba'),
                  //   onTap: () {
                  //     showModalBottomSheet(
                  //       backgroundColor: Colors.transparent,
                  //       context: context,
                  //       builder: (_) {
                  //         return BlocProvider.value(
                  //           value: BlocProvider.of<RefMatchesCubit>(context),
                  //           child: const _TournamentDetailCard(
                  //               match: RefereeMatchDTO.empty),
                  //         );
                  //       },
                  //     );
                  //   },
                  // ),
                )
              : ListView.builder(
                  physics: const ScrollPhysics(),
                  itemCount: state.finishedMatchesList.length,
                  padding: const EdgeInsets.only(top: 5),
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.only(
                              right: 10,
                              left: 10,
                            ),
                            color: const Color(0xff358aac),
                            height: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  /*(state.matches[index].matchDate == null)
                                    ? "Fecha pendiente por agendar"
                                    : DateFormat('dd-MM-yyyy HH:mm').format(
                                        state.matches[index].matchDate
                                            as DateTime),*/
                                  //state.matches[index].fechayCampo,
                                  (state.finishedMatchesList[index].fechayCampo
                                          .isEmpty)
                                      ? "Fecha pendiente por agendar"
                                      : state.finishedMatchesList[index]
                                          .fechayCampo,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.grey[200],
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Jornada ${state.finishedMatchesList[index].jornada}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.grey[200],
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )),
                        Container(
                          color: Colors.white38,
                          padding: const EdgeInsets.only(
                              left: 50, right: 25, top: 8, bottom: 8),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(children: [
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      state.finishedMatchesList[index].partido,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      state.finishedMatchesList[index].estado,
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.red[800],
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                ]),
                                IconButton(
                                  icon: const Icon(
                                    Icons.touch_app,
                                    size: 22,
                                    color: Color(0xff358aac),
                                  ),
                                  onPressed: () async {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (_) {
                                        return BlocProvider.value(
                                          value:
                                              BlocProvider.of<RefMatchesCubit>(
                                                  context),
                                          child: _TournamentDetailCard(
                                              match: state
                                                  .finishedMatchesList[index]),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ]),
                        ),
                      ],
                    );
                    //     TablePage()
                  },
                ); /* ListView.builder(
                itemCount: state.matches.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(state.matches[index].ligayTorneo),
                  subtitle: Text(state.matches[index].partido),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return BlocProvider.value(
                          value: BlocProvider.of<RefMatchesCubit>(context),
                          child: _TournamentDetailCard(
                              match: state.matches[index]),
                        );
                      },
                    );
                  },
                ),
              );*/
        },
      ),
    );
  }
}

class _TournamentDetailCard extends StatelessWidget {
  const _TournamentDetailCard({Key? key, required this.match})
      : super(key: key);

  final RefereeMatchDTO match;

  @override
  Widget build(BuildContext context) {
    final referee =
        context.select((AuthenticationBloc bloc) => bloc.state.refereeData);

    const titleStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
    );

    const subTitleStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(
              Icons.app_registration,
              color: Colors.grey, //Color(0xff358aac),
              size: 32,
            ),
            title: const Text(
              'Acciones del partido',
              style: titleStyle,
            ),
            onTap: () {},
          ),
          // ListTile(
          //   leading: const Icon(Icons.line_style,
          //       color: Color(0xff358aac), size: 32),
          //   title: const Text(
          //     'Alineaciones',
          //     style: titleStyle,
          //   ),
          //   subtitle: const Text(
          //     'Ver las alineaciones',
          //     style: subTitleStyle,
          //   ),
          //   onTap: () {},
          // ),
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
          BlocBuilder<RefMatchesCubit, RefMatchesState>(
            builder: (context, state) {
              if (match.estado == 'Pendiente') {
                return ListTile(
                  leading: const Icon(
                    Icons.not_started,
                    color: Color(0xff358aac),
                    size: 32,
                  ),
                  title: const Text(
                    'Comenzar',
                    style: titleStyle,
                  ),
                  subtitle: const Text('Comenzar partido'),
                  onTap: () {
                    context.read<RefMatchesCubit>().onPressStartGame(
                          refereeId: referee.refereeId!,
                          match: match,
                        );
                    Navigator.pop(context);
                  },
                );
              } else if (match.estado == 'Iniciado') {
                return ListTile(
                  leading: const Icon(
                    Icons.not_started,
                    color: Color(0xff358aac),
                    size: 32,
                  ),
                  title: const Text(
                    'Evento',
                    style: titleStyle,
                  ),
                  subtitle: const Text('Registrar goles, tarjetas y faltas'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                                value:
                                    BlocProvider.of<RefMatchesCubit>(context),
                                child: MatchEventsPage(match: match),
                              )),
                    );

                    //Navigator.popUntil(context,(route) => route.settings.name == '/');
                    //Navigator.pushReplacement(context, newRoute)
                  },
                );
              } else {
                return ListTile(
                  leading: const Icon(
                    Icons.info,
                    color: Color(0xff358aac),
                    size: 32,
                  ),
                  title: const Text(
                    'Ver detalle y calificar',
                    style: titleStyle,
                  ),
                  subtitle: const Text('Detalle del partido finalizado.'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MatchesDetailPage(
                            matchId: match.matchId ?? 0, playerId: 0),
                      ),
                    );
                  },
                );
              }
            },
          ),
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
          // ListTile(
          //   leading: const Icon(
          //     Icons.cancel,
          //     color: Color(0xff358aac),
          //     size: 32,
          //   ),
          //   title: const Text(
          //     'Declinar del partido',
          //     style: titleStyle,
          //   ),
          //   subtitle: const Text('Rechazar o declinar el partido asignado'),
          //   onTap: () {},
          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.list_alt,
          //     color: Color(0xff358aac),
          //     size: 32,
          //   ),
          //   title: const Text(
          //     'Pase de lista',
          //     style: titleStyle,
          //   ),
          //   subtitle: const Text('Ver asignaciones'),
          //   onTap: () {},
          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.calendar_month,
          //     color: Color(0xff358aac),
          //     size: 32,
          //   ),
          //   title: const Text(
          //     'Reagendar partido',
          //     style: titleStyle,
          //   ),
          //   subtitle: const Text(
          //       'Solicita al presidente de liga reagendar este partido'),
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }
}
