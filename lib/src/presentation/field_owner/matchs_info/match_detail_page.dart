import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/matchs_info/ratting_sended.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:user_repository/user_repository.dart';

import '../../../core/enums.dart';
import '../../../service_locator/injection.dart';
import '../../app/app.dart';
import '../../player/soccer_team/matches_by_player/matche_detail/cubit/match_detail_cubit.dart';
import 'my_rattings.dart';

class MatchDetailTabBar extends StatelessWidget {
  const MatchDetailTabBar({
    Key? key,
    required this.matchId,
    required this.fieldId, required this.eventId,

  }) : super(key: key);

  final int matchId;
  final int fieldId;
  final int eventId;
  static Route route(int matchId, int fieldId, int eventId) => MaterialPageRoute(
      builder: (_) => MatchDetailTabBar(matchId: matchId, fieldId: fieldId, eventId: eventId));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          locator<MatchDetailCubit>()..getMatchDeailByEvent(eventId: eventId),
      child: _PageRattingcontent(
        matchId: matchId,
        fieldId: fieldId,
      ),
    );
  }
}

class _PageRattingcontent extends StatefulWidget {
  const _PageRattingcontent(
      {Key? key, required this.matchId, required this.fieldId})
      : super(key: key);
  final int matchId;
  final int fieldId;

  @override
  State<_PageRattingcontent> createState() => _PageRattingcontentState();
}

class _PageRattingcontentState extends State<_PageRattingcontent>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int index = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller.addListener(() {
      setState(() {
        index = _controller.index;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Detalle del partido',
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[200],
          flexibleSpace: const Image(
            image: AssetImage('assets/images/imageAppBar25.png'),
            fit: BoxFit.fill,
          ),
          elevation: 0.0,
          bottom: TabBar(
            controller: _controller,
            tabs: const [
              Tab(text: 'Detalle'),
              Tab(text: 'Mis reseñas'),
              Tab(text: 'Calificaciones enviadas'),
            ],
            onTap: (index) {
              setState(() {
                this.index = index;
              });
            },
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            MatchDetailPage(matchId: widget.matchId, fieldId: widget.fieldId),
            MyRattings(matchId: widget.matchId),
            RattingsSendend(matchId: widget.matchId),
          ],
        ),
      ),
    );
  }
}

class MatchDetailPage extends StatelessWidget {
  const MatchDetailPage(
      {Key? key, required this.matchId, required this.fieldId})
      : super(key: key);
  final int matchId;
  final int fieldId;
  @override
  Widget build(BuildContext context) {
    final Color? color2 = Colors.green[800];
    return BlocConsumer<MatchDetailCubit, MatcheDetailState>(
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
                return Column(
                  children: [
                    const SizedBox(
                      height: 35,
                    ),
                    Text(
                      "${state.detailMatchDTO[index].campo ?? "No hay campos definido aún"}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${state.detailMatchDTO[index].direccion ?? "Sin dirección"}",
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
                      "${state.detailMatchDTO[index].fecha ?? "No hay fecha definida aún"}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: <Widget>[
                                const Image(
                                  image:
                                      AssetImage('assets/images/playera4.png'),
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
                                Text(
                                  """${state.detailMatchDTO[index].shootoutLocal == null ? '' : "(${state.detailMatchDTO[index].shootoutLocal})"}""",
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
                                Text(
                                  """${state.detailMatchDTO[index].shootoutVisit == null ? '' : "(${state.detailMatchDTO[index].shootoutVisit})"}""",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                const Image(
                                  image:
                                      AssetImage('assets/images/playera4.png'),
                                  fit: BoxFit.fitWidth,
                                  height: 80,
                                  width: 80,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  child: Text(
                                    "${state.detailMatchDTO[index].visitante}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  width: 100,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                              ],
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "${state.detailMatchDTO[index].estado ?? "Sin resultado"}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Arbitro : ${state.detailMatchDTO[index].arbitro ?? "Sin Arbitro"}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 30,
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
                    if (state.detailMatchDTO[index].estado == 'FINALIZADO' &&
                        user.applicationRol == ApplicationRol.fieldOwner )
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (state.detailMatchDTO[index].estado == 'FINALIZADO' && (!state.ownerFieldRating.isNotEmpty))
                              ? TextButton(
                                  onPressed: () {
                                    showDialog( 
                                      context: context,
                                      builder: (contextD) {
                                        return _DialogQualification(
                                          teamId: null,
                                          topic: TypeTopic.FIELD_TO_MATCH,
                                          matchId: state.detailMatchDTO[index]
                                              .matchId!, //match id
                                          leagueId: state.detailMatchDTO[index]
                                                  .leagueid ??
                                              0,
                                          idEvaluator: fieldId, //id del campo
                                          idEvaluated: state
                                                  .detailMatchDTO[index]
                                                  .matchId ??
                                              0, //matchd id
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
                                      'Calificar partido',
                                      style: TextStyle(
                                        fontFamily: 'SF Pro',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                child: const Text('Ya calificaste el partido'),
                              ),
                        ],
                      ),
                  ],
                );
                //     TablePage()
              });
        }
      },
    );
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
            typeQualification: topic.name,
            evaluatedId: idEvaluated,
            leagueId: leagueId,
            matchId: matchId,
            evaluatorId: idEvaluator),
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
                teamPlayerId: null,
                teamId: null),
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
          ) :
          ListView.builder(
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
                      padding:
                      const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
