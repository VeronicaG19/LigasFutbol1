import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums.dart';
import '../../../../domain/user_requests/entity/user_requests.dart';
import '../../../app/app.dart';
import '../cubit/lm_request_cubit.dart';
import 'referee_dialog_content.dart';
import 'request_dialog_screen.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({Key? key, required this.request}) : super(key: key);

  final UserRequests request;

  @override
  Widget build(BuildContext context) {
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.leagueManager);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Expanded(
            child: ListTile(
              leading: const Icon(Icons.arrow_drop_down_circle),
              title: Text(request.requestMadeBy),
              subtitle: Text(
                request.content ?? '',
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Pendiente de aprobación',
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
                          .onLoadLeagueRequestData(request);
                      return BlocProvider.value(
                        value: BlocProvider.of<LmRequestCubit>(context),
                        child: BlocBuilder<LmRequestCubit, LmRequestState>(
                          builder: (context, state) {
                            return AlertDialog(
                              title: const Text('Detalles de solicitud'),
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
                                          .onSubmitRequest(request, false);
                                    } else {
                                      context
                                          .read<LmRequestCubit>()
                                          .onCancelRequest(request.requestId,
                                              leagueManager.leagueId);
                                    }
                                    Navigator.pop(dialogContext);
                                  },
                                  child: state.requestStatus == 1 ||
                                          state.currentRequestType ==
                                              LMRequestType.league
                                      ? const Text('RECHAZAR')
                                      : const Text('CANCELAR'),
                                ),
                                if (state.requestStatus == 1 ||
                                    state.currentRequestType ==
                                        LMRequestType.league)
                                  TextButton(
                                      onPressed: () {
                                        context
                                            .read<LmRequestCubit>()
                                            .onSubmitRequest(request, true);
                                        Navigator.pop(dialogContext);
                                      },
                                      child: const Text('ACEPTAR')),
                              ],
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                child: const Text('Editar solicitud'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
