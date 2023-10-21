import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/user_requests/cubit/user_requests_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../domain/user_requests/entity/user_requests.dart';
import '../../app/app.dart';

enum RequestType { received, sent }

class UserRequestsContent extends StatelessWidget {
  const UserRequestsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return BlocConsumer<UserRequestsCubit, UserRequestsState>(
      listener: (context, state) {
        if (state.screenStatus == ScreenStatus.error) {
          SnackBar(
            content: Text(state.errorMessage ?? ''),
          );
        } else if (state.screenStatus == ScreenStatus.loaded) {
          context.read<NotificationBloc>().add(
              LoadNotificationCount(user.person.personId, user.applicationRol));
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
            state.sentRequestsList.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: state.sentRequestsList.length,
                    itemBuilder: (context, index) {
                      return _CardContent(
                        type: RequestType.sent,
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
                        type: RequestType.received,
                        request: state.receivedRequestsList[index],
                      );
                    },
                  )
                : const Center(
                    child: Text('Sin solicitudes'),
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
  final RequestType type;

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user;
    final title =
        type == RequestType.sent ? 'Solicitud enviada' : 'Solicitud recibida';
    final subtitle = type == RequestType.sent
        ? 'Solicitud enviada al equipo: ${request.requestTo}'
        : 'Solicitud del equipo: ${request.requestTo}';
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
              if (type == RequestType.received) {
                dialogTitle = 'Aceptar solicitud';
                dialogContent =
                    '¿Aceptar la solicitud recibida para unirse al equipo: ${request.requestTo}?';
              } else if (type == RequestType.sent) {
                dialogTitle = 'Cancelar la solicitud';
                dialogContent =
                    '¿Deseas cancelar la solicitud enviada al equipo: ${request.requestTo}?';
              }
              showDialog(
                context: context,
                builder: (contextD) {
                  return BlocProvider.value(
                    value: BlocProvider.of<UserRequestsCubit>(context),
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
                        if (type == RequestType.received)
                          TextButton(
                            onPressed: () {
                              context
                                  .read<UserRequestsCubit>()
                                  .cancelUserRequest(
                                      requestId: request.requestId,
                                      personId: user.person.personId!);
                              Navigator.pop(contextD);
                            },
                            child: const Text('RECHAZAR'),
                          ),
                        if (type == RequestType.received)
                          TextButton(
                            onPressed: () {
                              context
                                  .read<UserRequestsCubit>()
                                  .onUpdateRequestStatus(
                                      requestId: request.requestId,
                                      personId: user.person.personId!,
                                      status: true);
                              Navigator.pop(contextD);
                            },
                            child: const Text('ACEPTAR'),
                          ),
                        if (type == RequestType.sent)
                          TextButton(
                            onPressed: () {
                              context
                                  .read<UserRequestsCubit>()
                                  .cancelUserRequest(
                                      requestId: request.requestId,
                                      personId: user.person.personId!);
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
