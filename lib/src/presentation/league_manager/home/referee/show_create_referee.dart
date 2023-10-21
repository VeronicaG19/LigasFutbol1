import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../app/app.dart';
import 'cubit/referee_lm_cubit.dart';

class ShowCreateReferee extends StatelessWidget {
  const ShowCreateReferee({Key? key}) : super(key: key);

  /*static Route route(ShowCreateReferee cubit) =>
      MaterialPageRoute(builder: (_) => BlocProvider.value(value: cubit,
        child: const ShowCreateReferee(),));*/

  @override
  Widget build(BuildContext context) {
    final leagueId =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);

    /* return TextButton(
      //onPressed: () => Navigator.pop(dialogContext),
      onPressed: () {
        showDialog(
          context: context,
          builder: (dialogContext) {*/
    return AlertDialog(
      backgroundColor: Colors.grey[200],
      title: const Text('Agregar arbitro'),
      // content: BlocProvider(
      // create: (_) => locator<RefereeLmCubit>(),
      /*child:*/ content: BlocConsumer<RefereeLmCubit, RefereeLmState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return SizedBox(
            width: 600,
            height: 500,
            child: ListView(shrinkWrap: true, children: [
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
                      'assets/images/referee.png',
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
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(child: _NameReferee()),
                                SizedBox(width: 5),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: _LastNameReferee(),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            _VerificationSenderInput(),
                            SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ],
                  ),
                  state.status.isSubmissionInProgress
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
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
                                onPressed: () {
                                  context
                                      .read<RefereeLmCubit>()
                                      .createReferee(
                                          leagueId: leagueId.leagueId)
                                      .whenComplete(
                                          () => Navigator.pop(context));
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.fromLTRB(
                                      16.0, 10.0, 16.0, 10.0),
                                  decoration: const BoxDecoration(
                                    color: Color(0xff045a74),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
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
              )
            ]),
          );
        },
      ),
      //  ),
      //);
      //},
    );
    /* },
      child: Container(
        padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        decoration: const BoxDecoration(
          color: Color(0xff0791a3),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        height: 35,
        width: 150,
        child: Text(
          'Crear árbitro',
          style: TextStyle(
            fontFamily: 'SF Pro',
            color: Colors.grey[200],
            fontWeight: FontWeight.w500,
            fontSize: 13.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );*/
  }
}

class _LastNameReferee extends StatelessWidget {
  const _LastNameReferee({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RefereeLmCubit, RefereeLmState>(
      buildWhen: (previous, current) =>
          previous.refereeLastName != current.refereeLastName,
      builder: (context, state) {
        return TextFormField(
          key: const Key('last_name_referee'),
          onChanged: (value) =>
              context.read<RefereeLmCubit>().onRefereeLastNameChange(value),
          onFieldSubmitted: (value) => state.status.isSubmissionInProgress,
          decoration: InputDecoration(
            labelText: "Apellido del referee : ",
            labelStyle: TextStyle(fontSize: 13),
            errorText: state.refereeLastName.invalid
                ? "Escriba el apellido del referee"
                : null,
          ),
          style: TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _NameReferee extends StatelessWidget {
  const _NameReferee({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RefereeLmCubit, RefereeLmState>(
      buildWhen: (previous, current) =>
          previous.refereeName != current.refereeName,
      builder: (context, state) {
        return TextFormField(
          key: const Key('name_referee'),
          onChanged: (value) =>
              context.read<RefereeLmCubit>().onRefereeNameChange(value),
          onFieldSubmitted: (value) => state.status.isSubmissionInProgress,
          decoration: InputDecoration(
            labelText: "Nombre del referee : ",
            labelStyle: TextStyle(fontSize: 13),
            errorText: state.refereeName.invalid
                ? "Escriba el nombre del referee"
                : null,
          ),
          style: TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _VerificationSenderInput extends StatelessWidget {
  const _VerificationSenderInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leagueId =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
    return BlocBuilder<RefereeLmCubit, RefereeLmState>(
      buildWhen: (previous, current) =>
          previous.verificationSender != current.verificationSender,
      builder: (context, state) {
        return TextFormField(
          key: const Key('verificationSenderInput_emailInput_textField'),
          initialValue:
              context.watch<RefereeLmCubit>().state.verificationSender.value,
          onChanged: (value) =>
              context.read<RefereeLmCubit>().onVerificationSenderChanged(value),
          onFieldSubmitted: (value) => state.status.isSubmissionInProgress
              ? null
              : context
                  .read<RefereeLmCubit>()
                  .createReferee(leagueId: leagueId.leagueId),
          decoration: InputDecoration(
            isDense: true,
            labelText: AppLocalizations.of(context)!.emailOrPhoneLabel,
            helperText: '',
            errorText: state.verificationSender.invalid
                ? AppLocalizations.of(context)!.aeInvalidDataMsg
                : null,
          ),
          enabled: !state.status.isSubmissionInProgress,
          keyboardType: TextInputType.emailAddress,
        );
      },
    );
  }
}
