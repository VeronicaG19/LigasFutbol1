import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/requests/cubit/representantive_requests_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../domain/user_requests/entity/user_requests.dart';
import '../../../app/app.dart';

enum RepRequestType { received, sent, league }

class RepRequestsContent extends StatelessWidget {
  const RepRequestsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    final teamId = context
        .select((AuthenticationBloc bloc) => bloc.state.selectedTeam.teamId);
    return BlocConsumer<RepresentantiveRequestsCubit,
        RepresentantiveRequestsState>(
      listener: (context, state) {
        if (state.screenStatus == ScreenStatus.error) {
          SnackBar(
            content: Text(state.errorMessage ?? ''),
          );
        } else if (state.screenStatus == ScreenStatus.loaded) {
          context
              .read<NotificationBloc>()
              .add(LoadNotificationCount(teamId, user.applicationRol));
        }
      },
      builder: (context, state) {
        if (state.screenStatus == ScreenStatus.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.blueAccent, size: 50),
          );
        }
        return TabBarView(
          children: [
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
                    child: Text('Sin solicitudes recibidas'),
                  ),
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
                    child: Text('Sin solicitudes enviadas'),
                  ),
            state.adminRequestList.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: state.adminRequestList.length,
                    itemBuilder: (context, index) {
                      return _CardRequestLeague(
                        type: RepRequestType.league,
                        request: state.adminRequestList[index],
                      );
                    },
                  )
                : const Center(
                    child: Text('Sin solicitudes a ligas'),
                  ),
          ],
        );
      },
    );
  }
}

class _CardRequestLeague extends StatelessWidget {
  const _CardRequestLeague(
      {Key? key, required this.request, required this.type})
      : super(key: key);

  final UserRequests request;
  final RepRequestType type;

  @override
  Widget build(BuildContext context) {
    final titleToLeague =
        type == RepRequestType.league ? 'Solicitud a una liga\n' : 'Solicitud';
    final subtitleToLeague = type == RepRequestType.league
        ? 'Solicitud para pertenecer a ${request.requestTo}\n'
            'Estatus: ${request.requestStatus}\n'
        : '';

    return Card(
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
            leading: const Icon(Icons.email),
            title: Text(titleToLeague),
            subtitle: Text(subtitleToLeague),
          ),
        ],
      ),
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
    final team =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedTeam);
    final title = type == RepRequestType.sent
        ? 'Solicitud enviada'
        : 'Solicitud recibida';
    final subtitle = type == RepRequestType.sent
        ? 'Solicitud enviada a ${request.requestMadeBy}'
        : 'Solicitud de ${request.requestMadeBy}';

    return Card(
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
            leading: const Icon(Icons.email),
            title: Text(title),
            subtitle: Text(subtitle),
            onTap: () {
              String dialogTitle = '';
              String dialogContent = '';
              if (type == RepRequestType.received) {
                dialogTitle = 'Aceptar solicitud';
                dialogContent =
                    '¿Aceptar la solicitud recibida para unirse a tu equipo: ${request.requestTo}?';
              } else if (type == RepRequestType.sent) {
                dialogTitle = 'Cancelar la solicitud';
                dialogContent =
                    '¿Deseas cancelar la solicitud enviada a ${request.requestMadeBy}?';
              }
              showDialog(
                context: context,
                builder: (contextD) {
                  return BlocProvider.value(
                    value:
                        BlocProvider.of<RepresentantiveRequestsCubit>(context),
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
                                  .read<RepresentantiveRequestsCubit>()
                                  .cancelUserRequest(
                                    requestId: request.requestId,
                                    teamId: team.teamId!,
                                  );
                              Navigator.pop(contextD);
                            },
                            child: const Text('RECHAZAR'),
                          ),
                        if (type == RepRequestType.received)
                          TextButton(
                            onPressed: () {
                              context
                                  .read<RepresentantiveRequestsCubit>()
                                  .sendRequestStatus(
                                      requestId: request.requestId,
                                      teamId: team.teamId!,
                                      status: true);
                              Navigator.pop(contextD);
                            },
                            child: const Text('ACEPTAR'),
                          ),
                        if (type == RepRequestType.sent)
                          TextButton(
                            onPressed: () {
                              context
                                  .read<RepresentantiveRequestsCubit>()
                                  .cancelUserRequest(
                                    requestId: request.requestId,
                                    teamId: team.teamId!,
                                  );
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
