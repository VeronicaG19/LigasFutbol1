import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../../domain/matches/dto/detail_rol_match_dto/detail_rol_match_DTO.dart';
import '../../../../app/app.dart';
import 'cubit/clasification_cubit.dart';
import 'finalize_match_modal.dart';
import 'widgets/d_assign_match_date.dart';

class MatchesReport extends StatelessWidget {
  const MatchesReport({super.key});

  @override
  Widget build(BuildContext context) {
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
    return BlocBuilder<ClasificationCubit, ClasificationState>(
      builder: (context, state) {
        if (state.screenStatus == CLScreenStatus.creatingRoleGame ||
            state.screenStatus == CLScreenStatus.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: Colors.blue[800]!,
              size: 50,
            ),
          );
        }
        return Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 7, left: 7),
              height: 45,
              color: const Color(0xff358aac),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 39,
                    child: Text(
                      "Jornada",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[200],
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: Text(
                      "Fecha",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[200],
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  SizedBox(
                    width: 35,
                    child: Text(
                      "Local",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[200],
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                    child: Text(
                      "Marcador",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[200],
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  SizedBox(
                    width: 35,
                    child: Text(
                      "Visitante",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[200],
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: Text(
                      "Campo",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[200],
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: Text(
                      "Arbitro",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[200],
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  // SizedBox(
                  //   width: 25,
                  //   child: Text(
                  //     "Detalle",
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(
                  //         fontSize: 10,
                  //         color: Colors.grey[200],
                  //         fontWeight: FontWeight.w900),
                  //   ),
                  // ),
                  /*SizedBox(
                      width: 25,
                      child: Text(
                        "Editar1",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[200],
                            fontWeight: FontWeight.w900),
                      ),
                    ),*/
                ],
              ),
            ),
            ListView.builder(
              itemCount: state.dailMaitch.length,
              padding: const EdgeInsets.only(top: 40, bottom: 65),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      color: Colors.grey,
                      height: 1,
                    ),
                    Container(
                      height: 40,
                      padding: const EdgeInsets.only(right: 7, left: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 39,
                            child: Center(
                              child: Text(
                                "${state.dailMaitch[index].roundNumber}",
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                          Container(
                            width: 80,
                            color: Colors.black12,
                            height: 40,
                            child: _DateSection(
                              match: state.dailMaitch[index],
                            ),
                          ),
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: Center(
                              child: Text(
                                state.dailMaitch[index].localTeam ?? '-',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          (state.dailMaitch[index].score == "Asignar resultado")
                              ? IconButton(
                                  onPressed: () {
                                    context
                                        .read<ClasificationCubit>()
                                        .asingDataFinalize(
                                            state.dailMaitch[index]);
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        final exampleCubit =
                                            context.read<ClasificationCubit>();
                                        return BlocProvider<
                                            ClasificationCubit>.value(
                                          value: exampleCubit,
                                          child: FinalizeMatchModal(
                                            visit: state
                                                .dailMaitch[index].teamVisit!,
                                            local: state
                                                .dailMaitch[index].localTeam!,
                                          ),
                                        );
                                      },
                                    ).whenComplete(
                                      () => context
                                          .read<ClasificationCubit>()
                                          .getScoringSystem(
                                              tournament: state.tournament),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Color(0xff358aac),
                                    size: 20,
                                  ),
                                )
                              : Container(
                                  width: 40,
                                  height: 40,
                                  color: Colors.black12,
                                  child: Center(
                                    child: Text(
                                      "${state.dailMaitch[index].score}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 11,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: Center(
                              child: Text(
                                state.dailMaitch[index].teamVisit ?? '-',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 40,
                            color: Colors.black12,
                            child: _FieldSection(
                              match: state.dailMaitch[index],
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 40,
                            color: Colors.black12,
                            child: _RefereeSection(
                              match: state.dailMaitch[index],
                            ), /* Center(
                              child: Text(
                                state.dailMaitch[index].refereeName ?? '-',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),*/
                          ),
                          /*SizedBox(
                              width: 40,
                              height: 40,
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    context
                                        .read<ClasificationCubit>()
                                        .loadfields(
                                            leagueId: leagueManager.leagueId);
                                    context
                                        .read<ClasificationCubit>()
                                        .loadReferee(
                                            leagueId: leagueManager.leagueId);

                                    context
                                        .read<ClasificationCubit>()
                                        .asignDataToObjEditMatch(
                                            state.dailMaitch[index]);
                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          final exampleCubit = context
                                              .read<ClasificationCubit>();
                                          return BlocProvider<
                                                  ClasificationCubit>.value(
                                              value: exampleCubit,
                                              child: EditRolGame());
                                        });
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Color(0xff358aac),
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),*/
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        );
        /*if (state.screenStatus == ScreenStatus.createdRoleGame ||
            state.screenStatus == ScreenStatus.fieldtListLoaded ||
            state.screenStatus == ScreenStatus.error ||
            state.screenStatus == ScreenStatus.loaded) {
        }*/
      },
    );
  }
}

class _FieldSection extends StatelessWidget {
  const _FieldSection({Key? key, required this.match}) : super(key: key);

  final DeatilRolMatchDTO match;

  @override
  Widget build(BuildContext context) {
    if (match.dateMatch == null) {
      return const Text('-');
    }
    if (match.fieldMatch == null) {
      if (match.statusRequestField == 'SEND') {
        return _CancelRequestDialog(
          content: 'Cancelar solicitud para el campo',
          requestId: match.requestFieldId ?? 0,
        );
      }
      return IconButton(
        onPressed: () {
          /*    context.read<ClasificationCubit>().onGetRentalActive(
              LMRequestType.fieldOwner, leagueManager.leagueId);
          showDialog(
            context: context,
            builder: (_) {
              return BlocProvider.value(
                value: BlocProvider.of<ClasificationCubit>(context),
                child: AssignMatchFieldDialog(
                  // match: match,
                  selectedField: null,
                  selectedReferee: null,
                  type: LMRequestType.fieldOwner,
                ),
              );
            },
          );*/
        },
        icon: const Icon(
          Icons.edit,
          color: Color(0xff358aac),
          size: 20,
        ),
      );
    }
    return Center(
      child: Text(
        match.fieldMatch ?? '-',
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 11, color: Colors.black, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _RefereeSection extends StatelessWidget {
  const _RefereeSection({Key? key, required this.match}) : super(key: key);

  final DeatilRolMatchDTO match;

  @override
  Widget build(BuildContext context) {
    if (match.dateMatch == null) {
      return const Text('-');
    }
    if (match.refereeName == null) {
      if (match.statusRequestReferee == 'SEND') {
        return _CancelRequestDialog(
          content: 'Cancelar solicitud para el árbitro',
          requestId: match.requestRefereeId ?? 0,
        );
      }
      return IconButton(
        onPressed: () {
          /* context
              .read<ClasificationCubit>()
              .onGetRentalActive(LMRequestType.referee, leagueManager.leagueId);
          showDialog(
            context: context,
            builder: (_) {
              return BlocProvider.value(
                value: BlocProvider.of<ClasificationCubit>(context),
                child: AssignMatchFieldDialog(
                  // match: match,
                  type: LMRequestType.referee,
                ),
              );
            },
          );*/
        },
        icon: const Icon(
          Icons.edit,
          color: Color(0xff358aac),
          size: 20,
        ),
      );
    }
    return Center(
      child: Text(
        match.refereeName ?? '-',
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 11, color: Colors.black, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _DateSection extends StatelessWidget {
  const _DateSection({Key? key, required this.match}) : super(key: key);

  final DeatilRolMatchDTO match;

  @override
  Widget build(BuildContext context) {
    if (match.dateMatch == null) {
      return IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return BlocProvider.value(
                value: BlocProvider.of<ClasificationCubit>(context),
                child: AssignMatchDateDialog(
                  match: match,
                ),
              );
            },
          );
        },
        icon: const Icon(Icons.edit),
      );
    }
    return Center(
      child: TextButton(
        onPressed: () {
          if (match.fieldMatchId == null &&
              match.refereeId == null &&
              match.requestFieldId == null &&
              match.requestRefereeId == null) {
            showDialog(
              context: context,
              builder: (_) {
                return BlocProvider.value(
                  value: BlocProvider.of<ClasificationCubit>(context),
                  child: AssignMatchDateDialog(
                    match: match,
                  ),
                );
              },
            );
          }
        },
        child: Text(
          match.dateMatch ?? '-',
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 11, color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class _CancelRequestDialog extends StatelessWidget {
  const _CancelRequestDialog(
      {Key? key, required this.content, required this.requestId})
      : super(key: key);

  final String content;
  final int requestId;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (contextD) {
              return BlocProvider.value(
                value: BlocProvider.of<ClasificationCubit>(context),
                child: BlocConsumer<ClasificationCubit, ClasificationState>(
                  listenWhen: (previous, current) =>
                      previous.screenStatus != current.screenStatus,
                  listener: (context, state) {
                    if (state.screenStatus ==
                        CLScreenStatus.submissionFailure) {
                      showTopSnackBar(
                        context,
                        CustomSnackBar.error(
                          backgroundColor: Colors.green[800]!,
                          textScaleFactor: 1.0,
                          message: state.errorMessage ?? 'Error',
                        ),
                      );
                    } else if (state.screenStatus ==
                        CLScreenStatus.submissionSuccess) {
                      showTopSnackBar(
                        context,
                        CustomSnackBar.success(
                          backgroundColor: Colors.green[800]!,
                          textScaleFactor: 1.0,
                          message: 'Se ha cancelado la solicitud correctamente',
                        ),
                      );
                      Navigator.pop(contextD);
                    }
                  },
                  builder: (contextD, state) => AlertDialog(
                    title: const Text('Cancelar solicitud'),
                    content: Text(content),
                    actions: [
                      if (state.screenStatus ==
                          CLScreenStatus.submissionInProgress)
                        Center(
                          child: LoadingAnimationWidget.fourRotatingDots(
                            color: Colors.blue[800]!,
                            size: 50,
                          ),
                        ),
                      if (state.screenStatus !=
                          CLScreenStatus.submissionInProgress)
                        TextButton(
                          onPressed: () {
                            context
                                .read<ClasificationCubit>()
                                .onCancelRequest(requestId);
                          },
                          child: const Text('CONFIRMAR'),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Text(
          'Solicitud enviada',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 11, color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
