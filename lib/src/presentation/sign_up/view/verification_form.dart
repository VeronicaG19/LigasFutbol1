import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';
import 'package:ligas_futbol_flutter/src/presentation/sign_up/bloc/sign_up_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/splash/responsive_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../environment_config.dart';
// import 'package:top_snackbar_flutter/custom_snack_bar.dart';
// import 'package:top_snackbar_flutter/top_snack_bar.dart';

class VerificationForm extends StatelessWidget {
  const VerificationForm({Key? key}) : super(key: key);

  static Page page() => const MaterialPage(child: VerificationForm());

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final Color? color = Colors.blue[800];
    final Color? color2 = Colors.green[800];
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<SignUpBloc, SignUpState>(
            listenWhen: (_, state) => state.status.isSubmissionFailure,
            listener: (context, state) {
              if (state.index == 0) {
                final message = AppLocalizations.of(context)!
                    .signUpVerificationFailureMsg(
                        state.errorMessage ?? 'unknown');
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(message)));
              }
            },
            child: ResponsiveWidget.isSmallScreen(context)
                ? _BodyVerificationFormMobile()
                : _BodyVerificationFormWeb(),
          ),
        ),
      ),
    );
  }
}

class _BodyVerificationFormMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.only(top: screenSize.height * 0.1),
      color: Colors.grey[200],
      padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
      child: ListView(
        children: [
          Text(
            AppLocalizations.of(context)!.signUpTitle,
            style: const TextStyle(
                fontSize: 37,
                //color: Theme.of(context).colorScheme.onPrimary,
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 60.0,
          ),
          const _VerificationSenderInput(),
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
}

class _BodyVerificationFormWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/imageLoggin21.png'),
            fit: BoxFit.fill),
      ),
      child: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(right: 400, left: 400, top: 20, bottom: 20),
          child: Container(
            color: Color(0xFF6C6565).withOpacity(0.5),
            child: Column(
              children: [
                Image.asset(
                  EnvironmentConfig.logoImage,
                  width: 230,
                  height: 230,
                  opacity: const AlwaysStoppedAnimation(.8),
                ),
                Text(
                  AppLocalizations.of(context)!.signUpTitle,
                  style: const TextStyle(
                      fontSize: 37,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 60, left: 60),
                  child: Column(
                    children: const [
                      SizedBox(height: 60.0),
                      _VerificationSenderInput(),
                      SizedBox(height: 20.0),
                      _SubmitButton(),
                      SizedBox(height: 20.0),
                      _CancelButton(),
                      SizedBox(height: 20.0),
                    ],
                  ), //top: 30, bottom: 30
                ),
              ],
            ),
          ),
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
          //color: Theme.of(context).colorScheme.onPrimary,
          color: Colors.black,
          fontSize: 17,
        ),
        children: <TextSpan>[
          TextSpan(
            text: AppLocalizations.of(context)!.emailOrPhoneLabel,
            style: const TextStyle(
              //color: Theme.of(context).colorScheme.onPrimary,
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: ' ${AppLocalizations.of(context)!.signUpValidReqMsgLbl}',
            style: const TextStyle(
              //color: Theme.of(context).colorScheme.onPrimary,
              color: Colors.black,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}

class _VerificationSenderInput extends StatelessWidget {
  const _VerificationSenderInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _LabelTitle(),
        const SizedBox(
          height: 25.0,
        ),
        BlocBuilder<SignUpBloc, SignUpState>(
          buildWhen: (previous, current) =>
              previous.verificationSender != current.verificationSender,
          builder: (context, state) {
            return TextFormField(
              style: ResponsiveWidget.isSmallScreen(context)
                  ? const TextStyle(color: Colors.black54)
                  : const TextStyle(color: Colors.white70),
              key: const Key('verificationSenderInput_emailInput_textField'),
              initialValue:
                  context.watch<SignUpBloc>().state.verificationSender.value,
              onChanged: (value) => context
                  .read<SignUpBloc>()
                  .add(SignUpVerificationSenderChanged(value)),
              onFieldSubmitted: (value) => state.status.isSubmissionInProgress
                  ? null
                  : context
                      .read<SignUpBloc>()
                      .add(const SignUpVerificationSubmitted()),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    width: 3,
                    color: Colors.black38,
                  ),
                ),
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
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                color: color!,
                size: 50,
              ))
            : ElevatedButton(
                key: const Key('verificationForm_submit_raisedButton'),
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
                        context
                            .read<SignUpBloc>()
                            .add(const SignUpVerificationSubmitted());
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
      visible: !context.watch<SignUpBloc>().state.status.isSubmissionInProgress,
      child: ElevatedButton(
        key: const Key('verificationForm_cancel_raisedButton'),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          //primary: Theme.of(context).colorScheme.onSecondary,
          backgroundColor: Colors.blueGrey,
        ),
        onPressed: () => context.read<SignUpBloc>().add(SignUpOnCancel()),
        child: Text(
          AppLocalizations.of(context)!.aeCancelLbl,
          style: Theme.of(context).primaryTextTheme.button,
        ),
      ),
    );
  }
}
