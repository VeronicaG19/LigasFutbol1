import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../environment_config.dart';
import '../cubit/recover_password_cubit.dart';
// import 'package:top_snackbar_flutter/custom_snack_bar.dart';
// import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RecoverPasswordPage extends StatelessWidget {
  const RecoverPasswordPage({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (_) => const RecoverPasswordPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RecoverPasswordCubit>(
      create: (_) =>
          RecoverPasswordCubit(context.read<AuthenticationRepository>()),
      child: const _RecoverPasswordContent(),
    );
  }
}

class _RecoverPasswordContent extends StatelessWidget {
  const _RecoverPasswordContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color? color = Colors.blue[800];
    final Color? color2 = Colors.green[800];
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<RecoverPasswordCubit, RecoverPasswordState>(
          //listenWhen: (_, state) => state.status.isSubmissionFailure,
          listener: (context, state) {
            if (state.status.isSubmissionFailure) {
              final message = AppLocalizations.of(context)!
                  .passwordRecoveryFailureMsg(state.errorMessage ?? 'unknown');
              // showTopSnackBar(
              //   context,
              //   CustomSnackBar.info(
              //     backgroundColor: color!,
              //     textScaleFactor: 0.9,
              //     message: message,
              //   ),
              // );
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                      content: Text(message),
                      duration: const Duration(seconds: 9)),
                );
            } /*else if (state.status.isSubmissionSuccess) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                    content: Text(
                        AppLocalizations.of(context)!.recoverPasswordMsg)));
              Navigator.pop(context);
            }*/
          },
          builder: (context, state) {
            if (state.status.isSubmissionSuccess) {
              return const AdviseConfirmation();
            } else {
              return Container(
                padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
                child: ListView(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.recoverPasswordTitle,
                      style: const TextStyle(
                          fontSize: 37,
                          //color: Theme.of(context).colorScheme.onSecondary,
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 60.0,
                    ),
                    const _UserFormInput(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const _SubmitButton(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const _CancelButton(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class _LabelTitle extends StatelessWidget {
  const _LabelTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '${AppLocalizations.of(context)!.signUpInsertALbl} ',
        style: const TextStyle(
          //color: Theme.of(context).colorScheme.onSecondary,
          color: Colors.black,
          fontSize: 17,
        ),
        children: <TextSpan>[
          TextSpan(
            text: AppLocalizations.of(context)!.emailOrPhoneLabel.toLowerCase(),
            style: const TextStyle(
              //color: Theme.of(context).colorScheme.onSecondary,
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: ' ${AppLocalizations.of(context)!.signUpValidReqMsgLbl}',
            style: const TextStyle(
              //color: Theme.of(context).colorScheme.onSecondary,
              color: Colors.black,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}

class _UserFormInput extends StatelessWidget {
  const _UserFormInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _LabelTitle(),
        const SizedBox(
          height: 25.0,
        ),
        BlocBuilder<RecoverPasswordCubit, RecoverPasswordState>(
          buildWhen: (previous, current) =>
              previous.userSender != current.userSender,
          builder: (context, state) {
            return TextFormField(
              key: const Key('RecoverPasswordPage_UserFormInput_textField'),
              initialValue:
                  context.watch<RecoverPasswordCubit>().state.userSender.value,
              onChanged: (value) => context
                  .read<RecoverPasswordCubit>()
                  .onUserSenderChanged(value),
              onFieldSubmitted: (value) => state.status.isSubmissionInProgress
                  ? null
                  : context.read<RecoverPasswordCubit>().onChangePassword(),
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.emailOrPhoneLabel,
                helperText: '',
                errorText: state.userSender.invalid
                    ? AppLocalizations.of(context)!.aeInvalidDataMsg
                    : null,
              ),
              enabled: !state.status.isSubmissionInProgress,
              keyboardType: TextInputType.emailAddress,
            );
          },
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color? color = Colors.blue[800];
    return BlocBuilder<RecoverPasswordCubit, RecoverPasswordState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                color: color!,
                size: 50,
              ))
            : ElevatedButton(
                key: const Key('RecoverPasswordPage_submit_raisedButton'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  primary: Colors.blueAccent,
                ),
                onPressed: state.status.isValidated
                    ? () {
                        FocusScope.of(context).unfocus();
                        context.read<RecoverPasswordCubit>().onChangePassword();
                      }
                    : null,
                child: Text(
                  AppLocalizations.of(context)!.aeSubmitLbl,
                  style: Theme.of(context).primaryTextTheme.button,
                ),
              );
      },
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !context
          .watch<RecoverPasswordCubit>()
          .state
          .status
          .isSubmissionInProgress,
      child: ElevatedButton(
        key: const Key('RecoverPasswordPage_cancel_raisedButton'),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Colors.blueGrey,
        ),
        onPressed: () => Navigator.pop(context),
        child: Text(
          AppLocalizations.of(context)!.aeCancelLbl,
          style: Theme.of(context).primaryTextTheme.button,
        ),
      ),
    );
  }
}

class AdviseConfirmation extends StatelessWidget {
  const AdviseConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30.0,
            ),
            const Icon(
              Icons.security,
              size: 150,
            ),
            const SizedBox(
              height: 30.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                    AppLocalizations.of(context)!
                        .recoverPasswordAdv(EnvironmentConfig.appName),
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    )),
              ),
            ),
            ElevatedButton(
              key: const Key('AdviseConfirmation_confirm_raisedButton'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                primary: Colors.blueAccent,
              ),
              onPressed: () => Navigator.pop(context),
              child: Text(
                AppLocalizations.of(context)!.aeAcceptLbl,
                style: Theme.of(context).primaryTextTheme.button,
              ),
            )
          ],
        ),
      ),
    );
  }
}
