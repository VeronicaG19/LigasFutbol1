import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../core/constans.dart';
import '../../../../domain/user_requests/entity/user_requests.dart';
import '../cubit/rquest_cubit.dart';

class CancelRequestCardAdmin extends StatelessWidget {
  const CancelRequestCardAdmin({super.key, required this.request});

  final UserRequests request;

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
    const subtitle = 'Solicitud de';
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
            title: Text(
                '$subtitle: ${request.requestMadeBy}\nNombre de la liga: ${request.requestTo}',
                style: titleStyle),
            subtitle: Text(request.content ?? 'Sin descripción',
                style: subTitleStyle),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                child: const Text('Aceptar eliminación'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (contextD) {
                      return BlocProvider.value(
                        value: BlocProvider.of<RquestCubit>(context),
                        child: BlocListener<RquestCubit, RquestState>(
                          listenWhen: (previous, current) =>
                              previous.formzStatus != current.formzStatus,
                          listener: (context, state) {
                            if (state.formzStatus ==
                                FormzStatus.submissionSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Se ha eliminado la liga exitosamente'),
                                ),
                              );
                              Navigator.pop(contextD);
                            }
                          },
                          child: BlocBuilder<RquestCubit, RquestState>(
                            builder: (context, state) {
                              return AlertDialog(
                                title: const Text('Confirmar eliminación'),
                                content: Text(
                                    'Confirma la eliminación de la liga ${request.requestTo}'),
                                actions: state.formzStatus ==
                                        FormzStatus.submissionInProgress
                                    ? [
                                        const Center(
                                            child: CircularProgressIndicator())
                                      ]
                                    : [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(contextD),
                                          child: const Text('SALIR'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            context
                                                .read<RquestCubit>()
                                                .onDeleteLeague(request);
                                          },
                                          child: const Text('CONFIRMAR'),
                                        ),
                                      ],
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('Rechazar eliminación'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (contextD) {
                      return BlocProvider.value(
                        value: BlocProvider.of<RquestCubit>(context),
                        child: BlocListener<RquestCubit, RquestState>(
                          listenWhen: (previous, current) =>
                              previous.formzStatus != current.formzStatus,
                          listener: (context, state) {
                            if (state.formzStatus ==
                                FormzStatus.submissionSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Se ha enviado un mensaje al presidente de liga'),
                                ),
                              );
                              Navigator.pop(contextD);
                            }
                          },
                          child: BlocBuilder<RquestCubit, RquestState>(
                            builder: (context, state) {
                              return AlertDialog(
                                // insetPadding:
                                //     const EdgeInsets.symmetric(horizontal: 75),
                                title: const Text('Rechazar eliminación'),
                                content: const _DescriptionInput(),
                                actions: state.formzStatus ==
                                        FormzStatus.submissionInProgress
                                    ? [
                                        const Center(
                                            child: CircularProgressIndicator())
                                      ]
                                    : [
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              contextD), //Navigator.pop(context),
                                          child: const Text('SALIR'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            context
                                                .read<RquestCubit>()
                                                .onRejectCancellationOnLeague(
                                                    request);
                                          },
                                          child: const Text('ENVIAR'),
                                        ),
                                      ],
                              );
                            },
                          ),
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

class _DescriptionInput extends StatelessWidget {
  const _DescriptionInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 450,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: BlocBuilder<RquestCubit, RquestState>(
          buildWhen: (previous, current) =>
              previous.description != current.description ||
              current.screenStatus == ScreenStatus.initial ||
              current.screenStatus == ScreenStatus.loaded,
          builder: (context, state) {
            if (state.screenStatus == ScreenStatus.initial) {
              return const SizedBox();
            }
            return TextFormField(
              key: const Key('description_form_input'),
              initialValue: state.description.value,
              onChanged: context.read<RquestCubit>().onDescriptionChanged,
              keyboardType: TextInputType.text,
              maxLines: 4,
              decoration: textInputDecoration.copyWith(
                labelText: 'Describe porqué rechazas la eliminación de la liga',
                errorText:
                    state.description.invalid ? 'Texto demasiado corto' : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
