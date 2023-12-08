import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums.dart';
import '../../../../domain/user_requests/entity/user_requests.dart';
import '../../../app/app.dart';
import '../cubit/lm_request_cubit.dart';
import 'referee_dialog_content.dart';
import 'request_dialog_screen.dart';

class RequestCard extends StatefulWidget {
  const RequestCard(
      {Key? key, required this.request, required this.requestType})
      : super(key: key);

  final UserRequests request;
  final LMRequestType requestType;

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  @override
  Widget build(BuildContext context) {
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
    final status = context.read<LmRequestCubit>().state.requestStatus;
    return Card(
      elevation: 0.0,
      color: Colors.grey[100],
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          if (widget.requestType.name == LMRequestType.league.name)
            Expanded(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xff0791a3),
                  child: Image.asset(
                    'assets/images/equipo.png',
                    fit: BoxFit.cover,
                    height: 30,
                    width: 30,
                    color: Colors.grey[300],
                  ),
                ),
                title: Text("Equipo ${widget.request.requestMadeBy}"),
                subtitle: Text(
                  widget.request.content ?? '',
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
            ),
          if (widget.requestType.name == LMRequestType.referee.name)
            Expanded(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xff0791a3),
                  child: Image.asset(
                    'assets/images/referee.png',
                    fit: BoxFit.cover,
                    height: 30,
                    width: 30,
                    color: Colors.grey[300],
                  ),
                ),
                title: leagueManager.leagueName == widget.request.requestMadeBy
                    ? Text("Árbitros ${widget.request.requestTo}")
                    : Text("Árbitros ${widget.request.requestMadeBy}"),
                subtitle: Text(
                  widget.request.content ?? '',
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Solicitud para formar parte de tu liga.',
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
          ),
          ButtonBar(
            buttonHeight: 10.0,
            alignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) {
                      context
                          .read<LmRequestCubit>()
                          .onLoadLeagueRequestData(widget.request);
                      return BlocProvider.value(
                        value: BlocProvider.of<LmRequestCubit>(context),
                        child: BlocBuilder<LmRequestCubit, LmRequestState>(
                          builder: (context, state) {
                            return AlertDialog(
                              title: const Text('Detalles de la solicitud'),
                              content: state.currentRequestType ==
                                      LMRequestType.league
                                  ? const RequestDialogScreen()
                                  : const RefereeDialogContent(),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    if (state.requestStatus == 1 ||
                                        state.currentRequestType ==
                                            LMRequestType.league) {
                                      context
                                          .read<LmRequestCubit>()
                                          .onSubmitRequest(
                                              widget.request, false);
                                    } else {
                                      context
                                          .read<LmRequestCubit>()
                                          .onSubmitRequest(
                                              widget.request, true);
                                      /* context
                                          .read<LmRequestCubit>()
                                          .onCancelRequest(request.requestId,
                                              leagueManager.leagueId);*/
                                    }
                                    Navigator.pop(dialogContext);
                                  },
                                  child: state.requestStatus == 1 ||
                                          state.currentRequestType ==
                                              LMRequestType.league
                                      ? const Text('Rechazar')
                                      : const Text('Aprobar árbitro'),
                                ),
                                if (state.requestStatus == 1 ||
                                    state.currentRequestType ==
                                        LMRequestType.league)
                                  TextButton(
                                      onPressed: () {
                                        context
                                            .read<LmRequestCubit>()
                                            .onSubmitRequest(
                                                widget.request, true);
                                        Navigator.pop(dialogContext);
                                      },
                                      child: const Text('Aprobar')),
                              ],
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                child: const Text('Detalle de la solicitud',
                    style: TextStyle(color: Color(0xff0791a3))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
