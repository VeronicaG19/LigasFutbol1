import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/enums.dart';
import '../../../../domain/user_requests/entity/field_owner_request.dart';
import '../../../app/app.dart';
import '../cubit/fo_request_cubit.dart';

class FoRequestContent extends StatelessWidget {
  const FoRequestContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final league = context.select(
        (AuthenticationBloc bloc) => bloc.state.selectedLeague.leagueId);
    final rol = context
        .select((AuthenticationBloc bloc) => bloc.state.user.applicationRol);
    return BlocConsumer<FoRequestCubit, FoRequestState>(
      listener: (context, state) {
        if (state.screenStatus == BasicCubitScreenState.error) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              backgroundColor: Colors.green[800]!,
              textScaleFactor: 1.0,
              message: state.errorMessage ?? 'Error',
            ),
          );
        } else if (state.screenStatus == BasicCubitScreenState.loaded) {
          context
              .read<NotificationBloc>()
              .add(LoadNotificationCount(league, rol));
        } else if (state.screenStatus == BasicCubitScreenState.success) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              backgroundColor: Colors.green[800]!,
              textScaleFactor: 1.0,
              message: 'Solicitud aceptada',
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.screenStatus == BasicCubitScreenState.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.blueAccent, size: 50),
          );
        }
        return state.requestsList.isNotEmpty
            ? ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: state.requestsList.length,
                itemBuilder: (context, index) {
                  return _CardContent(
                    request: state.requestsList[index],
                  );
                },
              )
            : const Center(
                child: Text('Sin solicitudes'),
              );
      },
    );
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent({Key? key, required this.request}) : super(key: key);

  final FieldOwnerRequest request;

  @override
  Widget build(BuildContext context) {
    const subTitleStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
    );
    const titleStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );
    final league =
        context.read<AuthenticationBloc>().state.selectedLeague.leagueId;
    final title = 'Solicitud de ${request.leaguePresident}';
    final subtitle = '${request.fieldName} - ${request.startDate}';
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
        leading: const Icon(
          Icons.email,
          color: Color(0xff358aac),
          size: 20,
        ),
        title: Text(title, style: subTitleStyle),
        subtitle: Text(subtitle, style: titleStyle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          showDialog(
            context: context,
            builder: (contextD) {
              return BlocProvider.value(
                value: BlocProvider.of<FoRequestCubit>(context),
                child: AlertDialog(
                  title: const Text('Confirmar solicitud'),
                  content: _DialogContent(
                    request: request,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        context
                            .read<FoRequestCubit>()
                            .onCancelRequest(request.requestId, league);
                        Navigator.pop(contextD);
                      },
                      child: const Text('RECHAZAR'),
                    ),
                    TextButton(
                      onPressed: () {
                        context
                            .read<FoRequestCubit>()
                            .onAcceptRequest(request, league);
                        Navigator.pop(contextD);
                      },
                      child: const Text('ACEPTAR'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _DialogContent extends StatelessWidget {
  const _DialogContent({Key? key, required this.request}) : super(key: key);
  final FieldOwnerRequest request;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: const Text('Liga'),
          subtitle: Text(request.leagueName),
        ),
        ListTile(
          title: const Text('Torneo'),
          subtitle: Text(request.tournamentName),
        ),
        ListTile(
          title: const Text('Partido'),
          subtitle: Text(request.teamMatch),
        ),
        ListTile(
          title: const Text('Campo'),
          subtitle: Text(request.fieldName),
        ),
        ListTile(
          title: const Text('Fecha'),
          subtitle: Text('${request.startDate} - ${request.endDate}'),
        ),
      ],
    );
  }
}
