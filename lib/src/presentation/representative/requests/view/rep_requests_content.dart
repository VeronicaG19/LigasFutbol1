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
    return BlocConsumer<RepresentantiveRequestsCubit, RepresentantiveRequestsState>(
      listener: (context, state) {
        if (state.screenStatus == ScreenStatus.error) {
          SnackBar(
            content: Text(state.errorMessage ?? ''),
          );
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
class _CardRequestLeague extends StatelessWidget{
  const _CardRequestLeague({Key? key, required this.request, required this.type})
      : super(key: key);

  final UserRequests request;
  final RepRequestType type;

  @override
  Widget build(BuildContext context) {
    final titleToLeague = type == RepRequestType.league
        ? 'Solicitud a una liga\n'
        : 'Solicitud';
    final subtitleToLeague = type == RepRequestType.league
        ? 'Solicitud para pertener a ${request.requestTo}\n'
        'Estatus: ${request.requestStatus}\n' : '';

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
    final team = context.read<AuthenticationBloc>().state.teamManager;
    final title = type == RepRequestType.sent ? 'Solicitud enviada' : 'Solicitud recibida';
    final subtitle = type == RepRequestType.sent
        ? 'Solicitud enviada a ${request.requestMadeBy}'
        : 'Solicitud de ${request.requestTo}';

    return Card(
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
            leading: const Icon(Icons.email),
            title: Text(title),
            subtitle: Text(subtitle),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              if (type == RepRequestType.received)
                TextButton(
                  child: const Text('Aceptar'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (contextD) {
                        return BlocProvider.value(
                          value: BlocProvider.of<RepresentantiveRequestsCubit>(context),
                          child: AlertDialog(
                            title: const Text(
                              'Aceptar solicitud',
                              textAlign: TextAlign.center,),
                            content: Text('¿Aceptar la solicitud recibida de ${request.requestMadeBy}?'),
                            actions: [
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
                              TextButton(
                                onPressed: () => Navigator.pop(contextD),
                                child: const Text('REGRESAR'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              const SizedBox(width: 8),
              if (type == RepRequestType.received)
              TextButton(
                child: const Text('Rechazar'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (contextD) {
                      return BlocProvider.value(
                        value: BlocProvider.of<RepresentantiveRequestsCubit>(context),
                        child: AlertDialog(
                          title: const Text(
                            'Rechazar solicitud',
                            textAlign: TextAlign.center,),
                          content: Text('¿Deseas rechazar la solicitud de ${request.requestMadeBy}?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                context
                                    .read<RepresentantiveRequestsCubit>()
                                    .sendRequestStatus(
                                    requestId: request.requestId,
                                    teamId: team.teamId!,
                                    status: false);
                                Navigator.pop(contextD);
                              },
                              child: const Text('RECHAZAR'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(contextD),
                              child: const Text('REGRESAR'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              if (type == RepRequestType.sent)
                TextButton(
                  child: const Text('Cancelar'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (contextD) {
                        return BlocProvider.value(
                          value: BlocProvider.of<RepresentantiveRequestsCubit>(context),
                          child: AlertDialog(
                            title: const Text(
                              'Cancelar la solicitud',
                              textAlign: TextAlign.center,),
                            content: Text('¿Deseas cancelar la solicitud de ${request.requestMadeBy}?'),
                            actions: [
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
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(contextD),
                                child: const Text('REGRESAR'),
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
        ],
      ),
    );
  }
}
