import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/bloc/authentication_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../../../core/constans.dart';
import '../../../lm_tournament_v1/clasification/widgets/d_assign_match_field.dart';
import '../../main_page/cubit/tournament_main_cubit.dart';
import '../cubit/edit_game_rol_cubit.dart';

class ResultContent extends StatelessWidget {
  const ResultContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final referee =
        context.select((EditGameRolCubit bloc) => bloc.state.selectedReferee);
    final field =
        context.select((EditGameRolCubit bloc) => bloc.state.selectedField);
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
    final match =
        context.select((TournamentMainCubit bloc) => bloc.state.selectedMatch);
    final refereeStatus = match.statusRequestReferee;
    final fieldStatus = match.statusRequestField;

    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Card(
        color: Colors.grey[200],
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text('RESUMEN DEL PARTIDO', textAlign: TextAlign.center),
            ),
            BlocBuilder<EditGameRolCubit, EditGameRolState>(
              builder: (context, state) {
                final date = state.selectedDate != null
                    ? DateFormat('dd-MM-yyyy').format(state.selectedDate!)
                    : '';
                final hour = state.selectedHour != null
                    ? DateFormat('HH:mm').format(state.selectedHour!)
                    : '';
                return ListTile(
                  title: const Text('Fecha del partido',
                      style: TextStyle(fontSize: 15)),
                  subtitle: Text('$date $hour', style: TextStyle(fontSize: 14)),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text('Campo y arbitro seleccionados:',
                  style: TextStyle(fontSize: 12)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: SizedBox(
                //   height: 160,
                child: Card(
                  key: CoachKey.fieldRoleGame,
                  shadowColor: Colors.black,
                  color: fieldStatus == 'ACCEPTED'
                      ? Colors.teal
                      : fieldStatus == 'SEND'
                          ? Colors.orangeAccent
                          : Colors.blueGrey[100],
                  elevation: 0.0,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: const Text(
                          'CAMPO',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 13),
                        ),
                        subtitle: Text(
                          fieldStatus == 'ACCEPTED'
                              ? 'Solicitud aceptada'
                              : fieldStatus == 'SEND'
                                  ? 'Solicitud enviada a ${field.getFieldName}'
                                  : field.fieldName ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: true,
                        ),
                      ),
                      const _InfoSection(requestType: LMRequestType.fieldOwner),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: SizedBox(
                //   height: 160,
                child: Card(
                  key: CoachKey.refereeRoleGame,
                  shadowColor: Colors.black,
                  color: refereeStatus == 'ACCEPTED' ||
                          match.refereeAssigmentId != null
                      ? Colors.teal
                      : refereeStatus == 'SEND'
                          ? Colors.orangeAccent
                          : Colors.blueGrey[100],
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: const Text(
                          'ARBITRO',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 13),
                        ),
                        subtitle: Text(
                          refereeStatus == 'ACCEPTED'
                              ? 'Solicitud aceptada'
                              : refereeStatus == 'SEND'
                                  ? 'Solicitud enviada a ${referee.getRefereeName}'
                                  : referee.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: true,
                        ),
                      ),
                      const _InfoSection(requestType: LMRequestType.referee),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: BlocBuilder<EditGameRolCubit, EditGameRolState>(
                //buildWhen: (_, state) => state.,
                builder: (context, state) {
                  if (state.screenState ==
                      BasicCubitScreenState.submissionInProgress) {
                    return Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: Colors.blue[800]!,
                        size: 50,
                      ),
                    );
                  }
                  if (match.requestRefereeId != null &&
                      match.requestFieldId == null &&
                      match.fieldMatchId == null) {
                    return Center(
                        child: TextButton(
                      onPressed: () {
                        context.read<EditGameRolCubit>().onSendFieldRequest();
                      },
                      child: Container(
                        padding:
                            const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                        decoration: const BoxDecoration(
                          color: Color(0xff045a74),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Text(
                          'Solicitar campo',
                          style: TextStyle(
                            fontFamily: 'SF Pro',
                            color: Colors.grey[200],
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ));
                  } else if ((match.requestRefereeId == null &&
                          match.refereeAssigmentId == null) &&
                      match.requestFieldId != null) {
                    return Center(
                        child: TextButton(
                      onPressed: () {
                        context.read<EditGameRolCubit>().onSendRefereeRequest();
                      },
                      child: Container(
                        padding:
                            const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                        decoration: const BoxDecoration(
                          color: Color(0xff045a74),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Text(
                          'Solicitar árbitro ',
                          style: TextStyle(
                            fontFamily: 'SF Pro',
                            color: Colors.grey[200],
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ));
                  } else {
                    return Visibility(
                        visible: (match.requestRefereeId == null) &&
                            (match.requestFieldId == null),
                        child: TextButton(
                          onPressed: () {
                            context
                                .read<EditGameRolCubit>()
                                .onSubmit(leagueManager.leagueId);
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(
                                25.0, 10.0, 25.0, 10.0),
                            decoration: const BoxDecoration(
                              color: Color(0xff045a74),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: Text(
                              'Solicitar árbitro y campo',
                              style: TextStyle(
                                fontFamily: 'SF Pro',
                                color: Colors.grey[200],
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection({Key? key, required this.requestType}) : super(key: key);
  final LMRequestType requestType;

  @override
  Widget build(BuildContext context) {
    final field =
        context.select((EditGameRolCubit bloc) => bloc.state.selectedField);
    final referee =
        context.select((EditGameRolCubit bloc) => bloc.state.selectedReferee);
    return AssignMatchFieldDialog(
      type: requestType,
      selectedField: field,
      selectedReferee: referee,
      elements: [
        _DeleteRequest(
          requestType: requestType,
        ),
      ],
    );
    /*return OutlinedButton(
      onPressed: () {
        if (requestType == LMRequestType.referee && referee.isEmpty) return;
        if (requestType == LMRequestType.fieldOwner && field.isEmpty) return;
        showDialog(
          context: context,
          builder: (_) {
            return AssignMatchFieldDialog(
              // match: match,
              selectedField: field,
              selectedReferee: referee,
              type: requestType,
            );
          },
        );
      },
      child: const Text(
        'Ver información',
        style: TextStyle(color: Colors.black87),
      ),
    );*/
  }
}

class _DeleteRequest extends StatelessWidget {
  const _DeleteRequest({Key? key, required this.requestType}) : super(key: key);
  final LMRequestType requestType;

  @override
  Widget build(BuildContext context) {
    final match =
        context.select((TournamentMainCubit bloc) => bloc.state.selectedMatch);

    if (requestType == LMRequestType.referee &&
        match.statusRequestReferee != 'SEND') {
      return const SizedBox();
    }
    if (requestType == LMRequestType.fieldOwner &&
        match.statusRequestField != 'SEND') {
      return const SizedBox();
    }
    return OutlinedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (contextD) {
            return BlocProvider.value(
              value: BlocProvider.of<EditGameRolCubit>(context),
              child: BlocConsumer<EditGameRolCubit, EditGameRolState>(
                listenWhen: (previous, current) =>
                    previous.screenState != current.screenState,
                listener: (context, state) {
                  if (state.screenState ==
                      BasicCubitScreenState.submissionFailure) {
                    showTopSnackBar(
                      context,
                      CustomSnackBar.error(
                        backgroundColor: Colors.green[800]!,
                        textScaleFactor: 1.0,
                        message: state.errorMessage ?? 'Error',
                      ),
                    );
                  } else if (state.screenState ==
                      BasicCubitScreenState.submissionSuccess) {
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
                  content: Text(
                    requestType == LMRequestType.referee
                        ? 'Cancelar solicitud para el árbitro'
                        : 'Cancelar solicitud para el campo',
                  ),
                  actions: [
                    if (state.screenState ==
                        BasicCubitScreenState.submissionInProgress)
                      Center(
                        child: LoadingAnimationWidget.fourRotatingDots(
                          color: Colors.blue[800]!,
                          size: 50,
                        ),
                      ),
                    if (state.screenState !=
                        BasicCubitScreenState.submissionInProgress)
                      TextButton(
                        onPressed: () {
                          context.read<EditGameRolCubit>().onCancelRequest(
                              requestType == LMRequestType.referee
                                  ? match.requestRefereeId
                                  : match.requestFieldId);
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
        'Cancelar solicitud',
        style: TextStyle(color: Colors.black87),
      ),
    );
  }
}
