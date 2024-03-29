import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/enums.dart';
import '../../../../domain/leagues/entity/league.dart';
import '../../../../service_locator/injection.dart';
import '../../../app/bloc/authentication_bloc.dart';
import 'cubit/request_lm_cubit.dart';

class EditLeaguePage extends StatelessWidget {
  const EditLeaguePage({Key? key, required this.league}) : super(key: key);
  final League league;

  @override
  Widget build(BuildContext context) {
    final partyId = context
        .select((AuthenticationBloc bloc) => bloc.state.user.person.personId);

    return BlocProvider(
      create: (_) => locator<RequestLmCubit>(),
      child: BlocConsumer<RequestLmCubit, RequestLmState>(
        listener: (context, state) {
          if (state.screenStatus == BasicCubitScreenState.success) {
            showTopSnackBar(
              context,
              const CustomSnackBar.info(
                backgroundColor: Colors.green,
                textScaleFactor: 0.9,
                message: 'Registro editado correctamente',
                maxLines: 3,
                textStyle: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            );
          }
          if (state.screenStatus == BasicCubitScreenState.error) {
            showTopSnackBar(
              context,
              const CustomSnackBar.info(
                backgroundColor: Colors.red,
                textScaleFactor: 0.9,
                message: 'Error al editar',
                maxLines: 3,
                textStyle: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return AlertDialog(
            title: const Text('Editar una liga'),
            backgroundColor: Colors.grey[200],
            content: SizedBox(
              width: 600,
              height: 450,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Color(0xff045a74),
                        child: Image.asset(
                          'assets/images/league.png',
                          fit: BoxFit.cover,
                          height: 90,
                          width: 90,
                          color: Colors.grey[300],
                        ),
                        /*    child: Image(
                                                    image:
                                                        AssetImage('assets/images/request.png'),
                                                    height: 90,
                                                    width: 90,
                                                    color: Colors.grey[300],
                                                  ),*/
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                _NameLeague(name: league.leagueName),
                                const SizedBox(
                                  height: 30,
                                ),
                                _DescriptionLeague(
                                    description: league.leagueDescription!)
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      state.formzStatus.isSubmissionInProgress
                          ? Center(
                              child: LoadingAnimationWidget.fourRotatingDots(
                                color: const Color(0xff358aac),
                                size: 50,
                              ),
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.fromLTRB(
                                          16.0, 10.0, 16.0, 10.0),
                                      decoration: const BoxDecoration(
                                        color: Color(0xff740404),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                      ),
                                      child: Text(
                                        'Salir',
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
                                ),
                                Expanded(
                                  child: TextButton(
                                    onPressed: () async {
                                      // print(
                                      //     'state.formzStatus.isValidated is ${state.formzStatus.isValidated}');
                                      // print(
                                      //     'leagueName is valid : ${state.leagueName.valid}');
                                      // print(
                                      //     'leagueDescrition is valid : ${state.leagueDescription.valid}');
                                      await context
                                          .read<RequestLmCubit>()
                                          .editLeague(league: league);
                                      if (state.leagueName.valid == true &&
                                          state.leagueDescription.valid ==
                                              true) {
                                        context.read<AuthenticationBloc>().add(
                                            GetLeaguesManager(partyId ?? 0));
                                      }
                                    },
                                    /* onPressed: () {
                                                          print("Creacion");
                                                            context
                                                                .read<RequestLmCubit>()
                                                                .sendRequest(partyId: partyId);
                                                                // Navigator.pop(context);
                                                        },*/
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.fromLTRB(
                                          16.0, 10.0, 16.0, 10.0),
                                      decoration: const BoxDecoration(
                                        color: Color(0xff045a74),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                      ),
                                      child: Text(
                                        'Guardar cambios',
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
                                ),
                              ],
                            )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _NameLeague extends StatelessWidget {
  const _NameLeague({Key? key, required this.name}) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestLmCubit, RequestLmState>(
      buildWhen: (previous, current) =>
          previous.leagueName != current.leagueName,
      builder: (context, state) {
        return TextFormField(
          initialValue: name,
          key: const Key('name_league'),
          onChanged: (value) =>
              context.read<RequestLmCubit>().onLeagueNameChange(value),
          onFieldSubmitted: (value) => state.formzStatus.isSubmissionInProgress,
          decoration: InputDecoration(
            labelText: "Nombre de la liga : ",
            labelStyle: TextStyle(fontSize: 13),
            errorText: state.leagueName.invalid
                ? "Escriba el nombre de la liga"
                : null,
          ),
          style: TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _DescriptionLeague extends StatelessWidget {
  const _DescriptionLeague({Key? key, required this.description})
      : super(key: key);
  final String description;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestLmCubit, RequestLmState>(
      buildWhen: (previous, current) =>
          previous.leagueDescription != current.leagueDescription,
      builder: (context, state) {
        return TextFormField(
          key: const Key('description_league'),
          initialValue: description,
          onChanged: (value) =>
              context.read<RequestLmCubit>().onLeagueDescriptionChange(value),
          onFieldSubmitted: (value) => state.formzStatus.isSubmissionInProgress,
          decoration: InputDecoration(
              labelText: 'Descripción de la liga :',
              labelStyle: TextStyle(fontSize: 13),
              errorText: state.leagueDescription.invalid
                  ? "Escriba una descripción a la liga"
                  : null),
          style: TextStyle(fontSize: 13),
        );
      },
    );
  }
}
