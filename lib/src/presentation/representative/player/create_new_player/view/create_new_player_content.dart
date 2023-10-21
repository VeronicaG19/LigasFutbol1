import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/player/create_new_player/cubit/create_new_player_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../app/app.dart';
import '../../../../player/soccer_team/players/team_players/cubit/team_players_cubit.dart';
import '../../../search_player/view/search_player_page.dart';

class CreateNewPlayerContent extends StatefulWidget {
  const CreateNewPlayerContent({Key? key, this.teamId}) : super(key: key);
  final int? teamId;
  @override
  State<StatefulWidget> createState() => _CreateNewPlayerContentState();
}

class _CreateNewPlayerContentState extends State<CreateNewPlayerContent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user;
    return BlocConsumer<CreateNewPlayerCubit, CreateNewPlayerState>(
      listenWhen: (_, state) =>
          state.status.isSubmissionSuccess || state.status.isSubmissionFailure,
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          _formKey.currentState?.reset();
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text("El jugador se creó correctamente."),
              ),
            );
          context
              .read<TeamPlayersCubit>()
              .getTeamPlayer(user.person.personId!, widget.teamId!);
        } else if (state.errorMessage == 'USER_EXIST') {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text(
                    "El jugador que intentas crear ya existe. Encuéntralo en buscar jugador."),
              ),
            );
        } else {
          final errorCode = state.getErrorCode();
          final content = errorCode ?? 'Error';
          final message = content == 'intentsExceeded'
              ? AppLocalizations.of(context)!
                  .signUpMaxIntentsMsg(state.getResetTime())
              : AppLocalizations.of(context)!.signUpVerificationFailureMsg(
                  state.errorMessage ?? 'unknown');
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(message)));
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 20, bottom: 30),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: const Color(0xff0791a3),
                    child: Image.asset(
                      'assets/images/categoria2.png',
                      fit: BoxFit.cover,
                      height: 90,
                      width: 90,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
                const _PlayerNameInput(),
                const _PlayerLastNameInput(),
                const _VerificationSenderInput(),
                if (!state.status.isSubmissionInProgress)
                  _SubmitButton(teamId: widget.teamId),
                if (state.status.isSubmissionInProgress)
                  LoadingAnimationWidget.fourRotatingDots(
                    color: const Color(0xff358aac),
                    size: 50,
                  ),
                const SizedBox(height: 15),
                if (!state.status.isSubmissionInProgress) _SearchPlayerButton(),
              ],
            ),
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
              labelText: "Nombre",
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
            onChanged: (value) => context
                .read<CreateNewPlayerCubit>()
                .onChangePlayerLastName(value),
            decoration: InputDecoration(
              labelText: "Apellido",
              labelStyle: const TextStyle(fontSize: 13),
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
        return TextButton(
          onPressed: () {
            if (state.status.isValidated) {
              FocusScope.of(context).unfocus();
              context.read<CreateNewPlayerCubit>().createNewPlayerTeam(
                  teamId: teamId!, partyId: user.person.personId!);
            }
          },
          child: Container(
            height: 38,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
            decoration: BoxDecoration(
              color: (state.status.isValidated)
                  ? const Color(0xff045a74)
                  : Colors.grey,
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            ),
            child: Center(
                child: Text(
              'Guardar cambios',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'SF Pro',
                color: Colors.grey[200],
                fontWeight: FontWeight.w500,
                fontSize: 10.0,
              ),
            )),
          ),
        );
      },
    );
  }
}

class _SearchPlayerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          SearchPlayerPage.route(),
        );
      },
      child: Container(
        height: 38,
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
        decoration: const BoxDecoration(
          color: Color(0xff358aac),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Center(
          child: Text(
            'Buscar jugador',
            style: TextStyle(
              fontFamily: 'SF Pro',
              color: Colors.grey[200],
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    );
  }
}
