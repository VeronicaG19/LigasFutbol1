import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/player/create_new_player/cubit/create_new_player_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../app/app.dart';
import '../../../../player/soccer_team/players/team_players/cubit/team_players_cubit.dart';

class CreateNewPlayerContent extends StatefulWidget{
  const CreateNewPlayerContent ({Key? key, this.teamId}) : super(key: key);
  final int? teamId;
  @override
  State<StatefulWidget> createState() => _CreateNewPlayerContentState();
}

class _CreateNewPlayerContentState extends State<CreateNewPlayerContent> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user;
    return BlocConsumer<CreateNewPlayerCubit, CreateNewPlayerState>(
      listenWhen: (_, state) => state.status.isSubmissionSuccess || state.status.isSubmissionFailure,
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text("El jugador se creó correctamente."),
              ),
            );
          context.read<TeamPlayersCubit>().getTeamPlayer(user.person.personId!, widget.teamId!);
        }else if(state.errorMessage == 'USER_EXIST'){
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text("El jugador que intentas crear ya existe. Encuéntralo en buscar jugador."),
              ),
            );
        }
        else {
          final errorCode = state.getErrorCode();
          final content = errorCode ?? 'Error';
          final message = content == 'intentsExceeded'
              ? AppLocalizations.of(context)!.signUpMaxIntentsMsg(state.getResetTime())
              : AppLocalizations.of(context)!.signUpVerificationFailureMsg(state.errorMessage ?? 'unknown');
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(message)));
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children:  [
              const _PlayerNameInput(),
              const _PlayerLastNameInput(),
              const _VerificationSenderInput(),
              _SubmitButton(teamId: widget.teamId),
            ],
          ),
        );
      },
    );
  }
}

class _PlayerNameInput extends StatelessWidget {
  const _PlayerNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateNewPlayerCubit, CreateNewPlayerState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            key: const Key('player_name_textField'),
            onChanged: (value) =>
                context.read<CreateNewPlayerCubit>().onChangePlayerName(value),
            decoration: InputDecoration(
              icon: const Icon(Icons.badge),
              border: const OutlineInputBorder(),
              labelText: "Nombre del jugador",
              labelStyle: const TextStyle(fontSize: 13),
              errorText: state.playerName.invalid ? "Datos no válidos" : null,
            ),
            style: const TextStyle(fontSize: 13),
          ),
        );
      },
    );
  }
}

class _PlayerLastNameInput extends StatelessWidget {
  const _PlayerLastNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateNewPlayerCubit, CreateNewPlayerState>(
      //buildWhen: (previous, current) =>
      //previous.refereeLastName != current.refereeLastName,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            key: const Key('player_last_name_textField'),
            onChanged: (value) =>
                context.read<CreateNewPlayerCubit>().onChangePlayerLastName(value),
            decoration: InputDecoration(
              icon: const Icon(Icons.badge),
              border: const OutlineInputBorder(),
              labelText: "Apellido del jugador",
              labelStyle: TextStyle(fontSize: 13),
              errorText:
              state.playerLastName.invalid ? "Datos no válidos" : null,
            ),
            style: const TextStyle(fontSize: 13),
          ),
        );
      },
    );
  }
}

class _VerificationSenderInput extends StatelessWidget {
  const _VerificationSenderInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateNewPlayerCubit, CreateNewPlayerState>(
      buildWhen: (previous, current) =>
      previous.verificationSender != current.verificationSender,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            key: const Key('verificationSenderInput_emailInput_textField'),
            style: const TextStyle(fontSize: 13),
            onChanged: (value) => context
                .read<CreateNewPlayerCubit>()
                .onVerificationSenderChanged(value),
            decoration: InputDecoration(
              icon: const Icon(Icons.assignment_ind),
              border: const OutlineInputBorder(),
              labelText: AppLocalizations.of(context)!.emailOrPhoneLabel,
              helperText: '',
              errorText: state.verificationSender.invalid
                  ? AppLocalizations.of(context)!.aeInvalidDataMsg
                  : null,
            ),
            enabled: !state.status.isSubmissionInProgress,
            keyboardType: TextInputType.emailAddress,
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key, this.teamId}) : super(key: key);
  final int? teamId;
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user;
    final Color? color = Colors.green[800];
    return BlocBuilder<CreateNewPlayerCubit, CreateNewPlayerState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? LoadingAnimationWidget.fourRotatingDots(
          color: color!,
          size: 50,
        ) : ElevatedButton(
          key: const Key('player_experience_submit_button'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50.0),
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: state.status.isValidated ? () async {
            context.read<CreateNewPlayerCubit>()
                .createNewPlayerTeam(
                teamId: teamId!,
                partyId: user.person.personId!
            );
          }
          : null,
          child: const Text(
            'Guardar',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white60, fontWeight: FontWeight.bold
            ),
          ),
        );
      },
    );
  }
}