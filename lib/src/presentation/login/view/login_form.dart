import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';
import 'package:ligas_futbol_flutter/environment_config.dart';
import 'package:ligas_futbol_flutter/src/presentation/login/cubit/login_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../app/bloc/authentication_bloc.dart';
import '../../recover_password/view/recover_password_page.dart';
import '../../sign_up/sign_up.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == FormzStatus.submissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? ''),
              ),
            );
        } else if (state.status == FormzStatus.submissionSuccess) {
          Navigator.pop(context);
          context
              .read<AuthenticationBloc>()
              .add(AuthenticationStatusChanged(state.token!));
        }
      },
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset(
                EnvironmentConfig.logoImage,
                width: 200,
                height: 200,
                opacity: const AlwaysStoppedAnimation(.8),
              ),
              const SizedBox(height: 20),
              const _EmailInput(),
              const SizedBox(height: 8),
              const _PasswordInput(),
              const SizedBox(height: 8),
              const _LoginButton(),
              const SizedBox(height: 20),
              const _SignUpButton(),
              const SizedBox(height: 8),
              _RecoverPasswordButton(),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: Text(
                      "Ir a la pantalla de inicio",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: Colors.blueGrey[300],
                        fontFamily: 'Lato',
                      ),
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                  Icon(Icons.double_arrow, color: Colors.blueGrey[300])
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) =>
              context.read<LoginCubit>().usernameChanged(username),
          onSubmitted: (value) => state.status.isSubmissionInProgress
              ? null
              : context.read<LoginCubit>().logInWithCredentials(),
          keyboardType: TextInputType.text,
          style: const TextStyle(color: Colors.white70),
          decoration: InputDecoration(
            hintStyle: const TextStyle(color: Colors.white70),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 3,
                color: Colors.blue,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: Colors.white54),
              borderRadius: BorderRadius.circular(15),
            ),
            labelStyle: const TextStyle(
                color: Colors.white60,
                fontWeight: FontWeight.w600,
                fontSize: 15),
            labelText: 'Usuario', //AppLocalizations.of(context)!.aeUserNameLbl,
            helperText: '',
            errorText: state.username.invalid
                ? 'Nombre de usuario invalido' //AppLocalizations.of(context)!.aeInvalidUsernameMsg
                : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          onSubmitted: (value) => state.status.isSubmissionInProgress
              ? null
              : context.read<LoginCubit>().logInWithCredentials(),
          obscureText: context.watch<LoginCubit>().state.isPasswordVisible,
          style: const TextStyle(color: Colors.white70),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 3,
                color: Colors.blue,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: Colors.white54),
              borderRadius: BorderRadius.circular(15),
            ),
            labelStyle: const TextStyle(
                color: Colors.white60,
                fontWeight: FontWeight.w600,
                fontSize: 15),
            labelText:
                'Contraseña', //AppLocalizations.of(context)!.aePasswordLbl,
            helperText: '',
            errorText: state.password.invalid
                ? 'Contraseña no válida' //AppLocalizations.of(context)!.aeInvalidPasswordMsg
                : null,
            suffixIcon: IconButton(
              icon: context.watch<LoginCubit>().state.isPasswordVisible
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
              onPressed: () =>
                  context.read<LoginCubit>().onChangePasswordVisibility(),
            ),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color? color = Colors.blue[800];
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? LoadingAnimationWidget.fourRotatingDots(
                color: color!,
                size: 50,
              )
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50.0),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: state.status.isValidated
                    ? () {
                        FocusScope.of(context).unfocus();
                        context.read<LoginCubit>().logInWithCredentials();
                      }
                    : null,
                child: const Text(
                  'Iniciar sesión', //AppLocalizations.of(context)!.aeLoginButtonLbl,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white60, fontWeight: FontWeight.bold),
                ),
              );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Visibility(
          visible: !state.status.isSubmissionInProgress,
          child: TextButton(
            onPressed: () async {
              bool mounted = true;
              final result = await Navigator.of(context).push(
                SignUpWizard.route(),
              );
              if (!mounted) return;
              if (result != null && result.isNotEmpty) {
                context
                    .read<LoginCubit>()
                    .loginAfterSignUp(result.userName, result.password);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${AppLocalizations.of(context)!.notAccountLBL} ",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  //style: styles.kLabelTextStyle,
                ),
                Text(
                  AppLocalizations.of(context)!.signUpHereLBL,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: Colors.blue,
                    fontFamily: 'Lato',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RecoverPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Visibility(
          visible: !state.status.isSubmissionInProgress,
          child: TextButton(
            key: const Key('loginForm_RecoverPasswordButton_flatButton'),
            onPressed: () async {
              Navigator.push(context, RecoverPasswordPage.route());
            },
            style: TextButton.styleFrom(
              minimumSize: const Size.fromHeight(50.0),
            ),
            child: Text(
              AppLocalizations.of(context)!.forgetPasswordLBL,
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        );
      },
    );
  }
}
