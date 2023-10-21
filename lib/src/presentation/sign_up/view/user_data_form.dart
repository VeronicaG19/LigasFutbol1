import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';
import 'package:ligas_futbol_flutter/src/presentation/sign_up/bloc/sign_up_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDataForm extends StatelessWidget {
  const UserDataForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget privacyPolicyLinkAndTermsOfService() {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Center(
            child: Text.rich(TextSpan(
                text: "${AppLocalizations.of(context)!.lblTerms1} ",
                style: const TextStyle(
                  fontSize: 16,
                ),
                children: <TextSpan>[
              TextSpan(
                text: "${AppLocalizations.of(context)!.lblTerms2}\n",
                style: const TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    //https://sites.google.com/view/auxilio-exprs/aviso-de-privacidad?authuser=0
                    // code to open / launch terms of service link here

                    if (!await launchUrl(Uri.parse(
                        "https://sites.google.com/view/ligasfutbol/aviso-de-privacidad"))) {
                      throw 'Could not launch https://sites.google.com/view/ligasfutbol/aviso-de-privacidad';
                    }
                  },
              ),
              TextSpan(
                  text: AppLocalizations.of(context)!.lblTerms3,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: AppLocalizations.of(context)!.lblTerms4,
                      style: const TextStyle(
                          fontSize: 16, decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          // code to open / launch privacy policy link here

                          if (!await launch(
                              "https://sites.google.com/view/ligasfutbol/aviso-de-privacidad")) {
                            throw 'https://sites.google.com/view/ligasfutbol/aviso-de-privacidad';
                          }
                        },
                    )
                  ])
            ]))),
      );
    }

    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        Text(
          AppLocalizations.of(context)!.signUpUserFormLbl,
        ),
        const SizedBox(
          height: 20,
        ),
        _UserNameInput(),
        const SizedBox(
          height: 20,
        ),
        _PasswordInput(),
        const SizedBox(
          height: 10,
        ),
        _PasswordInput2(),
        Row(
          children: [
            const CheckTermAndCondition(),
            privacyPolicyLinkAndTermsOfService(),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class CheckTermAndCondition extends StatefulWidget {
  const CheckTermAndCondition({Key? key}) : super(key: key);

  @override
  State<CheckTermAndCondition> createState() => _CheckTermAndConditionState();
}

class _CheckTermAndConditionState extends State<CheckTermAndCondition> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: context.watch<SignUpBloc>().state.tacStatus,
        onChanged: (value) {
          context.read<SignUpBloc>().add(ChangeTacStatus(value!));
        });
  }
}

class _UserNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextFormField(
          key: const Key('userDataForm_userNameInput_textField'),
          enabled: false,
          initialValue: context.watch<SignUpBloc>().state.username.value,
          onChanged: (userName) =>
              context.read<SignUpBloc>().add(SignUpUserNameChanged(userName)),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.aeUserNameLbl,
            helperText: '',
            errorText: state.username.invalid
                ? AppLocalizations.of(context)!.aeInvalidUsernameMsg
                : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput2 extends StatefulWidget {
  @override
  State<_PasswordInput2> createState() => _PasswordInput2State();
}

class _PasswordInput2State extends State<_PasswordInput2> {
  bool isPasswordVisible = true;

  void _onChangePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password2 != current.password2 ||
          current.password != previous.password,
      builder: (context, state) {
        return TextFormField(
          key: const Key('userDataForm_passwordInput_textField2'),
          initialValue: context.watch<SignUpBloc>().state.password2.value,
          onChanged: (password) => context
              .read<SignUpBloc>()
              .add(SignUpVerificationPassword(password)),
          onFieldSubmitted: (value) => state.status.isSubmissionInProgress
              ? null
              : context.read<SignUpBloc>().add(SignUpOnNextStep()),
          keyboardType: TextInputType.visiblePassword,
          obscureText: isPasswordVisible,
          enabled: state.password.valid,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.aePasswordLbl,
            helperText: '',
            errorText: state.password2.invalid
                ? AppLocalizations.of(context)!
                    .accountDataFailureMsg('notMatchPassword')
                : null,
            suffixIcon: IconButton(
              icon: isPasswordVisible
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
              onPressed: () => _onChangePasswordVisibility(),
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatefulWidget {
  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  bool isPasswordVisible = true;

  void _onChangePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          key: const Key('userDataForm_passwordInput_textField'),
          initialValue: context.watch<SignUpBloc>().state.password.value,
          onChanged: (password) =>
              context.read<SignUpBloc>().add(SignUpPasswordChanged(password)),
          onFieldSubmitted: (value) => state.status.isSubmissionInProgress
              ? null
              : context.read<SignUpBloc>().add(SignUpOnNextStep()),
          keyboardType: TextInputType.visiblePassword,
          obscureText: isPasswordVisible,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.aePasswordLbl,
            helperText: '',
            errorText: state.password.invalid
                ? AppLocalizations.of(context)!.aeInvalidPasswordMsg(
                    state.password.error?.toString() ?? '')
                : null,
            errorMaxLines: 2,
            suffixIcon: IconButton(
              icon: isPasswordVisible
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
              onPressed: () => _onChangePasswordVisibility(),
            ),
          ),
        );
      },
    );
  }
}
