import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/enums.dart';
import '../../../../domain/user_requests/dto/request_match_to_referee_dto.dart';
import '../../../../domain/user_requests/entity/user_requests.dart';
import '../../../app/app.dart';
import '../cubit/referee_request_cubit.dart';

enum RepRequestType { received, sent, recommendation }

class RefRequestsContent extends StatelessWidget {
  const RefRequestsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final refereeId = context
        .select((AuthenticationBloc bloc) => bloc.state.refereeData.refereeId);
    final rol = context
        .select((AuthenticationBloc bloc) => bloc.state.user.applicationRol);
    return BlocConsumer<RefereeRequestCubit, RefereeRequestState>(
      listener: (context, state) {
        if (state.screenStatus == BasicCubitScreenState.error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? ''),
              ),
            );
        } else if (state.screenStatus == BasicCubitScreenState.loaded) {
          context
              .read<NotificationBloc>()
              .add(LoadNotificationCount(refereeId, rol));
        }
      },
      builder: (context, state) {
        if (state.screenStatus == BasicCubitScreenState.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.blueAccent, size: 50),
          );
        }
        return TabBarView(
          children: [
            state.sentRequestsList.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: state.sentRequestsList.length,
                    itemBuilder: (context, index) {
                      return _CardContent(
                        type: RepRequestType.sent,
                        request: state.sentRequestsList[index],
                      );
                    },
                  )
                : const Center(
                    child: Text('Sin solicitudes'),
                  ),
            state.receivedRequestsList.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: state.receivedRequestsList.length,
                    itemBuilder: (context, index) {
                      return _CardContent(
                        type: RepRequestType.received,
                        request: state.receivedRequestsList[index],
                      );
                    },
                  )
                : const Center(
                    child: Text('Sin solicitudes'),
                  ),
            state.requestMatchRefereeList.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ListView.builder(
                      itemCount: state.requestMatchRefereeList.length,
                      itemBuilder: (context, index) {
                        return _MatchToReferee(
                            matchReferee: state.requestMatchRefereeList[index]);
                      },
                    ),
                  )
                : const Center(
                    child: Text('Sin solicitudes para arbitrar partidos.'),
                  ),
          ],
        );
      },
    );
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent({Key? key, required this.request, required this.type})
      : super(key: key);

  final UserRequests request;
  final RepRequestType type;

  @override
  Widget build(BuildContext context) {
    const subTitleStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );
    const titleStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
    );
    final user = context.read<AuthenticationBloc>().state.user;
    final title = type == RepRequestType.sent
        ? 'Solicitud enviada'
        : 'Solicitud recibida';
    final subtitle = type == RepRequestType.sent
        ? 'Solicitud enviada a ${request.requestTo}'
        : 'Solicitud de ${request.requestMadeBy}';
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
            leading: const Icon(
              Icons.email,
              color: Color(0xff358aac),
              size: 20,
            ),
            title: Text(title, style: subTitleStyle),
            subtitle: Text(subtitle, style: titleStyle),
            onTap: () {
              String dialogTitle = '';
              String dialogContent = '';
              if (type == RepRequestType.received) {
                dialogTitle = 'Aceptar solicitud';
                dialogContent =
                    '¿Aceptar la solicitud recibida para unirse al equipo de ${request.requestMadeBy}?';
              } else if (type == RepRequestType.sent) {
                dialogTitle = 'Cancelar la solicitud';
                dialogContent =
                    '¿Deseas cancelar la solicitud enviada a ${request.requestMadeBy}?';
              }
              showDialog(
                context: context,
                builder: (contextD) {
                  return BlocProvider.value(
                    value: BlocProvider.of<RefereeRequestCubit>(context),
                    child: AlertDialog(
                      title: Text(
                        dialogTitle,
                        textAlign: TextAlign.center,
                      ),
                      content: Text(dialogContent),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(contextD),
                          child: const Text('CERRAR'),
                        ),
                        if (type == RepRequestType.received)
                          TextButton(
                            onPressed: () {
                              context
                                  .read<RefereeRequestCubit>()
                                  .cancelUserRequest(
                                      requestId: request.requestId,
                                      personId: user.person.personId!,
                                      refereeId: 990);
                              Navigator.pop(contextD);
                            },
                            child: const Text('RECHAZAR'),
                          ),
                        if (type == RepRequestType.received)
                          TextButton(
                            onPressed: () {
                              context
                                  .read<RefereeRequestCubit>()
                                  .onUpdateRequestStatus(
                                      requestId: request.requestId,
                                      personId: user.person.personId!,
                                      status: true,
                                      refereeId: 990);
                              Navigator.pop(contextD);
                            },
                            child: const Text('ACEPTAR'),
                          ),
                        if (type == RepRequestType.sent)
                          TextButton(
                            onPressed: () {
                              context
                                  .read<RefereeRequestCubit>()
                                  .cancelUserRequest(
                                      requestId: request.requestId,
                                      personId: user.person.personId!,
                                      refereeId: 990);
                              Navigator.pop(contextD);
                            },
                            child: const Text('CANCELAR SOLICITUD'),
                          ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MatchToReferee extends StatelessWidget {
  const _MatchToReferee({Key? key, required this.matchReferee})
      : super(key: key);
  final RequestMatchToRefereeDTO matchReferee;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(8.0)),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.sports,
                color: Colors.blueGrey,
                size: 50,
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    matchReferee.teamMatch!,
                    //textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    //maxLines: 2,
                    //overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text("Fecha y hora: ${matchReferee.startDate}"),
                  const SizedBox(height: 8),
                  Text("Torneo: ${matchReferee.nameTournament}"),
                ],
              ),
            ],
          ),
          _ActionsRow(
            matchReferee: matchReferee,
          ),
        ],
      ),
    );
  }
}

class _ActionsRow extends StatelessWidget {
  const _ActionsRow({Key? key, required this.matchReferee}) : super(key: key);
  final RequestMatchToRefereeDTO matchReferee;
  @override
  Widget build(BuildContext context) {
    final refereeId = context
        .select((AuthenticationBloc bloc) => bloc.state.refereeData.refereeId);
    final user = context.read<AuthenticationBloc>().state.user;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (contextD) {
                return BlocProvider.value(
                  value: BlocProvider.of<RefereeRequestCubit>(context),
                  child: AlertDialog(
                    title: const Text('Rechazar solicitud'),
                    content: _DialogContent(
                      matchReferee: matchReferee,
                    ),
                    actions: [
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pop(contextD);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.grey,
                        ),
                        label: const Text(
                          "Regresar",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          context
                              .read<RefereeRequestCubit>()
                              .onSendResponseRequest(
                                  requestId: matchReferee.requestId!,
                                  accepted: false,
                                  personId: user.person.personId!,
                                  refereeId: refereeId!);
                          Navigator.pop(contextD);
                        },
                        icon: Icon(
                          Icons.cancel_presentation,
                          color: Colors.red[400],
                        ),
                        label: Text(
                          "Rechazar",
                          style: TextStyle(color: Colors.red[300]),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          icon: Icon(
            Icons.cancel_presentation,
            color: Colors.red[400],
          ),
          label: Text(
            "Rechazar",
            style: TextStyle(color: Colors.red[400]),
          ),
        ),
        TextButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (contextD) {
                return BlocProvider.value(
                  value: BlocProvider.of<RefereeRequestCubit>(context),
                  child: AlertDialog(
                    title: const Text('Aceptar solicitud'),
                    content: _DialogContent(
                      matchReferee: matchReferee,
                    ),
                    actions: [
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pop(contextD);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.grey,
                        ),
                        label: const Text(
                          "Regresar",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          context
                              .read<RefereeRequestCubit>()
                              .onAcceptMatchRequest(
                                  request: matchReferee,
                                  accepted: true,
                                  personId: user.person.personId ?? 0,
                                  refereeId: refereeId!);
                          Navigator.pop(contextD);
                        },
                        icon: Icon(
                          Icons.check_box,
                          color: Colors.green[400],
                        ),
                        label: Text(
                          "Aceptar",
                          style: TextStyle(color: Colors.green[400]),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          icon: Icon(
            Icons.check_box,
            color: Colors.green[400],
          ),
          label: Text(
            "Aceptar",
            style: TextStyle(color: Colors.green[400]),
          ),
        ),
      ],
    );
  }
}

class _DialogContent extends StatelessWidget {
  const _DialogContent({
    Key? key,
    required this.matchReferee,
  }) : super(key: key);
  final RequestMatchToRefereeDTO matchReferee;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: const Text('Liga'),
          subtitle: Text(matchReferee.nameLeague!),
        ),
        ListTile(
          title: const Text('Presidente'),
          subtitle: Text(matchReferee.presidentLeague!),
        ),
        ListTile(
          title: const Text('Torneo'),
          subtitle: Text(matchReferee.nameTournament!),
        ),
        ListTile(
          title: const Text('Partido'),
          subtitle: Text(matchReferee.teamMatch!),
        ),
        ListTile(
          title: const Text('Fecha'),
          subtitle: Text('${matchReferee.startDate} - ${matchReferee.endDate}'),
        ),
      ],
    );
  }
}
