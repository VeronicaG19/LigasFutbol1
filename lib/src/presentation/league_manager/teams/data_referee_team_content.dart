import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/teams/cubit/team_league_manager_cubit.dart';

class DataRefereeTeamContent extends StatefulWidget {
  const DataRefereeTeamContent({Key? key}) : super(key: key);

  @override
  _DataRefereeTeamContentState createState() => _DataRefereeTeamContentState();
}

class _DataRefereeTeamContentState extends State<DataRefereeTeamContent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamLeagueManagerCubit, TeamLeagueManagerState>(
      builder: (context, state) {
        return ListView(
          shrinkWrap: true,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Datos de representante",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: 15, right: 15, top: 15, left: 15),
                        child: _RefereeNameInput(),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(
                          bottom: 15, right: 15, top: 15, left: 15),
                      child: _RefereeLatNameInput(),
                    )),
                  ],
                ),
                Row(
                  children: const [
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(
                          bottom: 15, right: 15, top: 15, left: 15),
                      child: _VerificationSenderInput(),
                    )),
                  ],
                ),
              ],
            )
          ],
        );
      },
    );
  }
}

class _RefereeNameInput extends StatelessWidget {
  const _RefereeNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamLeagueManagerCubit, TeamLeagueManagerState>(
      //buildWhen: (previous, current) => previous.minAge != current.minAge,
      builder: (context, state) {
        return TextFormField(
          key: const Key('referee_name_textField'),
          onChanged: (value) => context
              .read<TeamLeagueManagerCubit>()
              .onChangeRefereeFirstName(value),
          decoration: InputDecoration(
            labelText: "Nombre del representante",
            labelStyle: TextStyle(fontSize: 13),
            errorText: state.refereeName.invalid ? "Datos no válidos" : null,
          ),
          style: const TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _RefereeLatNameInput extends StatelessWidget {
  const _RefereeLatNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamLeagueManagerCubit, TeamLeagueManagerState>(
      buildWhen: (previous, current) =>
          previous.refereeLastName != current.refereeLastName,
      builder: (context, state) {
        return TextFormField(
          key: const Key('referee_last_name_textField'),
          onChanged: (value) => context
              .read<TeamLeagueManagerCubit>()
              .onChangeRefereeLastName(value),
          decoration: InputDecoration(
            labelText: "Apellido del representante",
            labelStyle: TextStyle(fontSize: 13),
            errorText:
                state.refereeLastName.invalid ? "Datos no válidos" : null,
          ),
          style: const TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _VerificationSenderInput extends StatelessWidget {
  const _VerificationSenderInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamLeagueManagerCubit, TeamLeagueManagerState>(
      buildWhen: (previous, current) =>
          previous.verificationSender != current.verificationSender,
      builder: (context, state) {
        return TextFormField(
          key: const Key('verificationSenderInput_emailInput_textField'),
          style: TextStyle(fontSize: 13),
          onChanged: (value) => context
              .read<TeamLeagueManagerCubit>()
              .onVerificationSenderChanged(value),
          decoration: InputDecoration(
            labelText: "Correo electrónico o teléfono del representante",
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
