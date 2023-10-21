import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/core/constans.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/user_menu/widget/help_menu_button.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:user_repository/user_repository.dart';

import '../../../../../core/enums.dart';
import '../../../../app/app.dart';
import '../../../../league_manager/rating/rating_details/view/match_rating_details.dart';
import '../../../../widgets/general_rating_card.dart';
import '../../../../widgets/rating_card.dart';
import '../../../user_menu/widget/tutorial_widget.dart';
import 'cubit/match_detail_cubit.dart';

class MatchesDetailPage extends StatelessWidget {
  const MatchesDetailPage(
      {Key? key, required this.matchId, required this.playerId, this.myTeamId})
      : super(key: key);
  final int matchId;
  final int playerId;
  final int? myTeamId;
  @override
  Widget build(BuildContext context) {
    //final Color? color2 = Colors.green[800];
    final user = context.read<AuthenticationBloc>().state.user;
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            backgroundColor: Colors.grey[200],
            title: const Text(
              'Detalle del partido',
            ),
            flexibleSpace: const Image(
              image: AssetImage('assets/images/imageAppBar25.png'),
              fit: BoxFit.cover,
            ),
            elevation: 0.0,
            actions: [
              if (user.applicationRol == ApplicationRol.player)
                const HelpMeButton(
                    iconData: Icons.help, tuto: TutorialType.qualifyPlayer),
              if (user.applicationRol == ApplicationRol.referee)
                const HelpMeButton(
                    iconData: Icons.help, tuto: TutorialType.qualifyReferre),
              if (user.applicationRol == ApplicationRol.teamManager)
                const HelpMeButton(
                    iconData: Icons.help,
                    tuto: TutorialType.qualifyRepresentative)
            ],
          ),
        ),
        body: BlocProvider(
          create: (_) => locator<MatchDetailCubit>()
            ..getDetailMatchByPlayer(matchId: matchId),
          child: BlocConsumer<MatchDetailCubit, MatcheDetailState>(
            listener: (context, state) {},
            builder: (context, state) {
              final user = context.read<AuthenticationBloc>().state.user;
              if (state.screenStatus == ScreenStatus.loading) {
                return Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                    color: const Color(0xff358aac),
                    size: 50,
                  ),
                );
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  itemCount: state.detailMatchDTO.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final matchDetail = state.detailMatchDTO[index];
                    final showShootout = matchDetail.shootOut == 'Y';
                    return Column(
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        Text(
                          state.detailMatchDTO[index].campo ??
                              "No hay campos definido aún",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          state.detailMatchDTO[index].direccion ??
                              "Sin dirección",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          state.detailMatchDTO[index].fechaJuego ??
                              "No hay fecha definida aún",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  key: CoachKey.localTeamInformation,
                                  child: Column(
                                    children: <Widget>[
                                      const Image(
                                        image: AssetImage(
                                            'assets/images/playera4.png'),
                                        fit: BoxFit.fitWidth,
                                        height: 80,
                                        width: 80,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          "${state.detailMatchDTO[index].local}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "${state.detailMatchDTO[index].marcadorLocal ?? ''}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 40,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    if (showShootout)
                                      Text(
                                        state.detailMatchDTO[index]
                                                    .shootoutLocal ==
                                                null
                                            ? ''
                                            : "(${state.detailMatchDTO[index].shootoutLocal})",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400),
                                      ),
                                  ],
                                ),
                                const Text(
                                  "-",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w900),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "${state.detailMatchDTO[index].marcadorVisitante ?? ''}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 40,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    if (showShootout)
                                      Text(
                                        state.detailMatchDTO[index]
                                                    .shootoutVisit ==
                                                null
                                            ? ''
                                            : "(${state.detailMatchDTO[index].shootoutVisit})",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400),
                                      ),
                                  ],
                                ),
                                Container(
                                  key: CoachKey.visitTeamInformation,
                                  child: Column(
                                    children: <Widget>[
                                      const Image(
                                        image: AssetImage(
                                            'assets/images/playera4.png'),
                                        fit: BoxFit.fitWidth,
                                        height: 80,
                                        width: 80,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          "${state.detailMatchDTO[index].visitante}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            if (state.detailMatchDTO[index].estado ==
                                    'FINALIZADO' &&
                                user.applicationRol == ApplicationRol.referee)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    key: CoachKey.localTeamQualify,
                                    onPressed: () {
                                      final ref = context
                                          .read<AuthenticationBloc>()
                                          .state
                                          .refereeData;
                                      showDialog(
                                        context: context,
                                        builder: (contextD) {
                                          return _DialogQualification(
                                            topic: TypeTopic.REFEREE_TO_TEAM,
                                            matchId: matchId,
                                            leagueId: state
                                                    .detailMatchDTO[index]
                                                    .leagueid ??
                                                0,
                                            idEvaluator: ref.refereeId ?? 0,
                                            idEvaluated: state
                                                .detailMatchDTO[index].idLocal!,
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          16.0, 10.0, 16.0, 10.0),
                                      decoration: const BoxDecoration(
                                        color: Colors.deepOrangeAccent,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text(
                                              'Calificar',
                                              style: TextStyle(
                                                fontFamily: 'SF Pro',
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.star_rate,
                                              color: Colors.grey[200],
                                              size: 15,
                                            )
                                          ]),
                                    ),
                                  ),
                                  TextButton(
                                    key: CoachKey.visitTeamQualify,
                                    onPressed: () {
                                      final ref = context
                                          .read<AuthenticationBloc>()
                                          .state
                                          .refereeData;
                                      showDialog(
                                        context: context,
                                        builder: (contextD) {
                                          return _DialogQualification(
                                            topic: TypeTopic.REFEREE_TO_TEAM,
                                            matchId: matchId,
                                            leagueId: state
                                                    .detailMatchDTO[index]
                                                    .leagueid ??
                                                0,
                                            idEvaluator: ref.refereeId ?? 0,
                                            idEvaluated: state
                                                    .detailMatchDTO[index]
                                                    .idVisit ??
                                                0,
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          16.0, 10.0, 16.0, 10.0),
                                      decoration: const BoxDecoration(
                                        color: Colors.deepOrangeAccent,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text(
                                              'Calificar',
                                              style: TextStyle(
                                                fontFamily: 'SF Pro',
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.star_rate,
                                              color: Colors.grey[200],
                                              size: 15,
                                            )
                                          ]),
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                                key: CoachKey.statusMatch,
                                child: Column(
                                  children: [
                                    Text(
                                      state.detailMatchDTO[index].estado ??
                                          "Sin resultado",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Arbitro : ${state.detailMatchDTO[index].arbitro ?? "Sin Arbitro"}",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            /*  Text(
                                "Cambios : ${state.detailMatchDTO[index].cambiosIlimitados ?? "Sin cambios"}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),*/
                          ],
                        ),
                        if (state.detailMatchDTO[index].estado ==
                                'FINALIZADO' &&
                            user.applicationRol == ApplicationRol.player)
                          Row(
                            children: [
                              (state.detailMatchDTO[index].refereeId != null)
                                  ? Container(
                                      key: CoachKey.qualifyReferee,
                                      child: TextButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (contextD) {
                                              return _DialogQualification(
                                                teamId: myTeamId,
                                                topic:
                                                    TypeTopic.PLAYER_TO_REFERE,
                                                matchId: matchId,
                                                leagueId: state
                                                        .detailMatchDTO[index]
                                                        .leagueid ??
                                                    0,
                                                idEvaluator: playerId,
                                                idEvaluated: state
                                                        .detailMatchDTO[index]
                                                        .refereeId ??
                                                    0,
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              16.0, 10.0, 16.0, 10.0),
                                          decoration: const BoxDecoration(
                                            color: Colors.deepOrangeAccent,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                          ),
                                          child: const Text(
                                            'Calificar árbitro',
                                            style: TextStyle(
                                              fontFamily: 'SF Pro',
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              (state.detailMatchDTO[index].fieldId != null)
                                  ? Container(
                                      key: CoachKey.qualifyFieldOwner,
                                      child: TextButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (contextD) {
                                              return _DialogQualification(
                                                topic:
                                                    TypeTopic.PLAYER_TO_FIELD,
                                                teamId: myTeamId,
                                                matchId: matchId,
                                                leagueId: state
                                                        .detailMatchDTO[index]
                                                        .leagueid ??
                                                    0,
                                                idEvaluator: playerId,
                                                idEvaluated: state
                                                        .detailMatchDTO[index]
                                                        .fieldId ??
                                                    0,
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              16.0, 10.0, 16.0, 10.0),
                                          decoration: const BoxDecoration(
                                            color: Colors.deepOrangeAccent,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                          ),
                                          child: const Text(
                                            'Calificar campo',
                                            style: TextStyle(
                                              fontFamily: 'SF Pro',
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        if (state.detailMatchDTO[index].estado ==
                                'FINALIZADO' &&
                            user.applicationRol == ApplicationRol.referee)
                          (state.detailMatchDTO[index].fieldId != null)
                              ? TextButton(
                                  key: CoachKey.fieldOwnerTeamQualify,
                                  onPressed: () {
                                    final ref = context
                                        .read<AuthenticationBloc>()
                                        .state
                                        .refereeData;
                                    showDialog(
                                      context: context,
                                      builder: (contextD) {
                                        return _DialogQualification(
                                          topic: TypeTopic.REFEREE_TO_FIELD,
                                          matchId: matchId,
                                          leagueId: state.detailMatchDTO[index]
                                                  .leagueid ??
                                              0,
                                          idEvaluator: ref.refereeId ?? 0,
                                          idEvaluated: state
                                                  .detailMatchDTO[index]
                                                  .fieldId ??
                                              0,
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        16.0, 10.0, 16.0, 10.0),
                                    decoration: const BoxDecoration(
                                      color: Colors.deepOrangeAccent,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Calificar campo',
                                            style: TextStyle(
                                              fontFamily: 'SF Pro',
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.star_rate,
                                            color: Colors.grey[200],
                                            size: 15,
                                          )
                                        ]),
                                  ),
                                )
                              : Container(),
                        if (state.detailMatchDTO[index].estado ==
                                'FINALIZADO' &&
                            user.applicationRol == ApplicationRol.teamManager)
                          _ListQualification(
                            matchId: matchId,
                            teamId: myTeamId ?? 0,
                            type: 'REFEREE_TO_TEAM',
                            trailing: 'Árbitro',
                          ),
                        if (state.detailMatchDTO[index].estado ==
                                'FINALIZADO' &&
                            user.applicationRol == ApplicationRol.referee)
                          SizedBox(
                            key: CoachKey.reviewPlayers,
                            height: 120,
                            child: GeneralRatingCard(
                              title: state.refereeRating.isEmpty
                                  ? 'No hay reseñas de jugadores'
                                  : 'Reseñas de jugadores',
                              rating: state.refereeRating.rating,
                              onPressed: () {
                                if (state.refereeRating.isNotEmpty) {
                                  Navigator.push(
                                    context,
                                    MatchRatingDetails.route(
                                        matchId: matchId,
                                        topic: state.refereeRating),
                                  );
                                }
                              },
                            ),
                          ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ));
  }
}

class _DialogQualification extends StatelessWidget {
  const _DialogQualification(
      {required this.topic,
      required this.matchId,
      required this.leagueId,
      required this.idEvaluator,
      required this.idEvaluated,
      this.teamPlayerId,
      this.teamId});
  final TypeTopic topic;
  final int matchId;
  final int leagueId;
  final int idEvaluator;
  final int idEvaluated;
  final int? teamPlayerId;
  final int? teamId;

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user;
    final Color? color2 = Colors.green[800];
    return BlocProvider(
      create: (_) => locator<MatchDetailCubit>()
        ..getTopicsEvaluationByType(
            type: topic.name,
            personId: user.person.personId,
            leagueId: leagueId,
            matchId: matchId,
            evaluatedId: idEvaluated,
            evaluatorId: idEvaluator,
            typeQualification: topic.name),
      child: BlocConsumer<MatchDetailCubit, MatcheDetailState>(
          listener: (context, state) {
        if (state.screenStatus == ScreenStatus.success) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              backgroundColor: color2!,
              textScaleFactor: 1.0,
              message: "Calificación guardada correctamente",
            ),
          );
        }
      }, builder: (context, state) {
        return AlertDialog(
          //title: Text('Aceptar solicitud'),
          content: SizedBox(
            width: 200,
            height: 350,
            child: _StarRating(
                topic: topic,
                matchId: matchId,
                leagueId: leagueId,
                idEvaluator: idEvaluator,
                idEvaluated: idEvaluated,
                teamPlayerId: teamPlayerId,
                teamId: teamId),
          ),
          //actions: [],
        );
      }),
    );
  }
}

class _StarRating extends StatelessWidget {
  const _StarRating(
      {required this.topic,
      required this.matchId,
      required this.leagueId,
      required this.idEvaluator,
      required this.idEvaluated,
      this.teamPlayerId,
      this.teamId});

  final TypeTopic topic;
  final int matchId;
  final int leagueId;
  final int idEvaluator;
  final int idEvaluated;
  final int? teamPlayerId;
  final int? teamId;

  @override
  Widget build(BuildContext context) {
    List<Icon> _buildRateStars(int rating) {
      final items = List.generate(
          rating.toInt(),
          (index) => const Icon(
                Icons.star_rate,
                color: Colors.amber,
              ));
      if (rating % 1 != 0) {
        items.add(const Icon(
          Icons.star_half_rounded,
          color: Colors.amber,
        ));
      }
      items.addAll(List.generate(
          5 - rating.ceil(),
          (index) => const Icon(
                Icons.star_outline_rounded,
                color: Colors.black38,
              )));
      return items;
    }

    return BlocBuilder<MatchDetailCubit, MatcheDetailState>(
      builder: (context, state) {
        if (state.screenStatus == ScreenStatus.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: const Color(0xff358aac),
              size: 50,
            ),
          );
        } else {
          return state.existQualification.qualificationId != null
              ? ListView(
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(bottom: 20, top: 30),
                        child: Text(
                          'Ya tienes una calificación registrada',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            ..._buildRateStars(
                                state.existQualification.rating ?? 0),
                            const SizedBox(
                              width: 10,
                            ),
                            Text('${state.existQualification.rating} de 5',
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black38)),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(bottom: 9, top: 9),
                        child: Text(
                            'Calificación al ${state.existQualification.getEvaluation}' ??
                                'Sin comentarios',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black54))),
                    Padding(
                        padding: EdgeInsets.only(bottom: 50, top: 15),
                        child: Text(
                            '${state.existQualification.comments}' ??
                                'Sin comentarios',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 15))),
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding:
                            const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Text(
                          'Salir',
                          style: TextStyle(
                            fontFamily: 'SF Pro',
                            color: Colors.grey[200],
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.listTopicsEvaluation.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Column(
                      children: [
                        const SizedBox(height: 25),
                        Text(
                          state.listTopicsEvaluation[index].topic ?? '',
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const RatingScreen(),
                        const SizedBox(height: 8.0),
                        const _CommentsQualificationInput(),
                        const SizedBox(height: 8.0),
                        TextButton(
                          onPressed: () async {
                            await context
                                .read<MatchDetailCubit>()
                                .createQualification(
                                    teamId: teamId,
                                    topicId: state.listTopicsEvaluation[index]
                                            .topicEvaluationId ??
                                        0,
                                    idEvaluator: idEvaluator,
                                    idEvaluated: idEvaluated,
                                    leagueId:
                                        leagueId, //state.detailMatchDTO[index].leagueId ?? 0,
                                    teamPlayerId: teamPlayerId,
                                    matchId: matchId,
                                    typeEvaluation: topic.name);
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(
                                16.0, 10.0, 16.0, 10.0),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: Text(
                              'Enviar Calificación',
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
                    );
                  },
                );
        }
      },
    );
  }
}

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchDetailCubit, MatcheDetailState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 1; i <= 5; i++)
              GestureDetector(
                onTap: () {
                  context.read<MatchDetailCubit>().updateRating(i);
                },
                child: Icon(
                  i <= state.rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 38,
                ),
              ),
          ],
        );
      },
    );
  }
}

//<MatchDetailCubit, MatcheDetailState>
class _CommentsQualificationInput extends StatelessWidget {
  const _CommentsQualificationInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchDetailCubit, MatcheDetailState>(
      buildWhen: (previous, current) => previous.comments != current.comments,
      builder: (context, state) {
        final cubit = context.read<MatchDetailCubit>();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            key: const Key('comments_qualification'),
            maxLines: 5,
            maxLength: 250,
            onChanged: cubit.onCommentsChanged,
            //onSubmitted: (value) => state.status.isSubmissionInProgress,
            keyboardType: TextInputType.text,
            decoration: _myInputDecoration.copyWith(
              labelText: 'Comentarios',
              hintText: 'Agrega algún comentario',
            ),
          ),
        );
      },
    );
  }
}

final _myInputDecoration = InputDecoration(
  hintStyle: const TextStyle(color: Colors.black45),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(
      width: 3,
      color: Colors.orange,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(width: 3, color: Colors.blue),
    borderRadius: BorderRadius.circular(15),
  ),
  labelStyle: const TextStyle(
      color: Colors.black54, fontWeight: FontWeight.w600, fontSize: 15),
);

class _ListQualification extends StatelessWidget {
  const _ListQualification({
    required this.matchId,
    required this.teamId,
    required this.type,
    required this.trailing,
  });
  final int matchId;
  final int teamId;
  final String type;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          locator<MatchDetailCubit>()..getListQualification(matchId, type),
      child: BlocConsumer<MatchDetailCubit, MatcheDetailState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.screenStatus == ScreenStatus.loaded) {
            return state.listDetailQualification.isNotEmpty
                ? ListView.builder(
                    key: CoachKey.qualifyPlayers,
                    shrinkWrap: true,
                    itemCount: state.listDetailQualification.length,
                    itemBuilder: (context, index) {
                      if (state.listDetailQualification[index].evaluatedId ==
                          teamId) {
                        return RatingCard(
                          title: state
                              .listDetailQualification[index].nameEvaluator!,
                          rating: double.parse(state
                              .listDetailQualification[index].rating
                              .toString()),
                          trailing: trailing,
                          subTitle: '',
                          description:
                              state.listDetailQualification[index].comments!,
                        );
                      } else {
                        return const Text('');
                      }
                    },
                  )
                : RatingCard(
                    title: 'Sin reseña del árbitro.',
                    rating: double.parse('0'),
                    trailing: '',
                    subTitle: '',
                    description:
                        'El árbitro aún no captura la reseña de este partido.',
                  );
          } else {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: const Color(0xff358aac),
                size: 50,
              ),
            );
          }
        },
      ),
    );
  }
}
