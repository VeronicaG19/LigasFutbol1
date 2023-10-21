import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/home/league/league_cubit.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../core/constans.dart';
import '../../../../../domain/leagues/entity/league.dart';
import '../../../../app/bloc/authentication_bloc.dart';

class DeleteLeagueDialog extends StatelessWidget {
  const DeleteLeagueDialog(
      {Key? key, required this.nameLeague, required this.leagueId})
      : super(key: key);
  final String nameLeague;
  final League leagueId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<LeagueByLeagueManagerCubit>(),
      child:
          BlocConsumer<LeagueByLeagueManagerCubit, LeagueByLeagueManagerState>(
              listener: (context, state) {
        if (state.screenState == BasicCubitScreenState.success) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text("Se elimino correctamente la liga $nameLeague"),
              ),
            );
          Navigator.pop(context);
          context
              .read<AuthenticationBloc>()
              .add(UpdateLeagueManagerLeagues(state.league));
        } else if (state.screenState == BasicCubitScreenState.error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content:
                    Text(state.errorMessage ?? 'No se pudo eliminar la liga'),
              ),
            );
          Navigator.pop(context);
        } else if (state.formzStatus == FormzStatus.submissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('No se ha enviado una solicitud'),
              ),
            );
          Navigator.pop(context);
        }
      }, builder: (context, state) {
        return AlertDialog(
          backgroundColor: Colors.grey[200],
          title: const Text('Eliminar liga',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
          content: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: Text("¿Desea eliminar la liga $nameLeague?",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w300)),
                ),
              ),
            ],
          ),
          actions: state.screenState == BasicCubitScreenState.loading
              ? [
                  Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                      color: const Color(0xff358aac),
                      size: 50,
                    ),
                  ),
                ]
              : [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Container(
                      padding:
                          const EdgeInsets.fromLTRB(60.0, 10.0, 60.0, 10.0),
                      decoration: const BoxDecoration(
                        color: Color(0xff047074),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Text(
                        'Regresar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SF Pro',
                          color: Colors.grey[200],
                          fontWeight: FontWeight.w500,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context
                          .read<LeagueByLeagueManagerCubit>()
                          .deleteLeague(league: leagueId);
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
                      decoration: const BoxDecoration(
                        color: Color(0xff047074),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Text(
                        'Eliminar liga ahora',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SF Pro',
                          color: Colors.grey[200],
                          fontWeight: FontWeight.w500,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return BlocProvider.value(
                                value:
                                    BlocProvider.of<LeagueByLeagueManagerCubit>(
                                        context),
                                child: _DeleteLeagueRequestDialog(
                                  leagueId: leagueId.leagueId,
                                ));
                          });
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.fromLTRB(17.0, 10.0, 17.0, 10.0),
                      decoration: const BoxDecoration(
                        color: Color(0xff047074),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Text(
                        'Enviar solicitud para eliminar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SF Pro',
                          color: Colors.grey[200],
                          fontWeight: FontWeight.w500,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
                ],
        );
      }),
    );
  }
}

class _DeleteLeagueRequestDialog extends StatelessWidget {
  const _DeleteLeagueRequestDialog({Key? key, required this.leagueId})
      : super(key: key);
  final int leagueId;

  @override
  Widget build(BuildContext context) {
    final person =
        context.select((AuthenticationBloc bloc) => bloc.state.user.person);
    return BlocConsumer<LeagueByLeagueManagerCubit, LeagueByLeagueManagerState>(
      listenWhen: (previous, current) =>
          previous.formzStatus != current.formzStatus,
      listener: (context, state) {
        if (state.formzStatus == FormzStatus.submissionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Se ha enviado una solicitud al administrador.'),
            ),
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: const Text('Solicitud para eliminar liga'),
          content: const _DescriptionInput(),
          actions: state.formzStatus == FormzStatus.submissionInProgress
              ? [const Center(child: CircularProgressIndicator())]
              : [
                  TextButton(
                    onPressed: () =>
                        Navigator.pop(context), //Navigator.pop(context),
                    child: const Text('SALIR'),
                  ),
                  TextButton(
                    onPressed: () {
                      context
                          .read<LeagueByLeagueManagerCubit>()
                          .onSendRequest(person.personId, leagueId);
                    },
                    child: const Text('ENVIAR'),
                  ),
                ],
        );
      },
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
        child:
            BlocBuilder<LeagueByLeagueManagerCubit, LeagueByLeagueManagerState>(
          buildWhen: (previous, current) =>
              previous.description != current.description ||
              current.screenState == BasicCubitScreenState.initial ||
              current.screenState == BasicCubitScreenState.loaded,
          builder: (context, state) {
            return TextFormField(
              key: const Key('description_form_input'),
              initialValue: state.description.value,
              onChanged: context
                  .read<LeagueByLeagueManagerCubit>()
                  .onDescriptionChanged,
              keyboardType: TextInputType.text,
              maxLines: 4,
              decoration: textInputDecoration.copyWith(
                labelText: 'Describe porqué quieres eliminar la liga',
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
