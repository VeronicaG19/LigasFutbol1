import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';
import 'package:ligas_futbol_flutter/src/presentation/sign_up/bloc/sign_up_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/sign_up/view/view.dart';
import 'package:ligas_futbol_flutter/src/presentation/splash/responsive_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:top_snackbar_flutter/custom_snack_bar.dart';
// import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: SignUpForm());

  @override
  Widget build(BuildContext context) {
    final Color? color = Colors.blue[800];
    final Color? color2 = Colors.green[800];
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: BlocConsumer<SignUpBloc, SignUpState>(
                listenWhen: (_, state) => state.status.isSubmissionFailure,
                listener: (context, state) {
                  if (!state.tacStatus && state.index == 2) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(AppLocalizations.of(context)!
                              .termsAndConditionsLabel),
                          content:
                              Text(AppLocalizations.of(context)!.tacWarningMsg),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                  AppLocalizations.of(context)!.aeAcceptLbl),
                            )
                          ],
                        );
                      },
                    );
                  } else {
                    final errorCode = state.getErrorCode();
                    final content = errorCode ?? 'Error';
                    final message = content == 'intentsExceeded'
                        ? AppLocalizations.of(context)!
                            .signUpMaxIntentsMsg(state.getResetTime())
                        : AppLocalizations.of(context)!
                            .signUpVerificationFailureMsg(
                                state.errorMessage ?? 'unknown');
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
                      ..showSnackBar(SnackBar(content: Text(message)));
                  }
                },
                buildWhen: (_, state) => !state.status.isSubmissionSuccess,
                builder: (context, state) {
                  return Stepper(
                    steps: [
                      Step(
                          title: Text(AppLocalizations.of(context)!
                              .signUpCodeFormTitle),
                          state: context.watch<SignUpBloc>().state.index <= 0
                              ? StepState.editing
                              : StepState.complete,
                          isActive:
                              context.watch<SignUpBloc>().state.index == 0,
                          content: const VerificationCodeForm()),
                      Step(
                          title: Text(AppLocalizations.of(context)!
                              .signUpPersonFormTitle),
                          state: context.watch<SignUpBloc>().state.index <= 1
                              ? StepState.editing
                              : StepState.complete,
                          isActive:
                              context.watch<SignUpBloc>().state.index == 1,
                          content: const PersonDataForm()),
                      Step(
                          title: Text(AppLocalizations.of(context)!
                              .signUpAccountFormTitle),
                          state: StepState.complete,
                          isActive:
                              context.watch<SignUpBloc>().state.index == 2,
                          content: state.status.isSubmissionInProgress
                              ? const _LoadingScreen()
                              : const UserDataForm()),
                    ],
                    type: StepperType.horizontal,
                    currentStep: context.watch<SignUpBloc>().state.index,
                    onStepContinue: () {
                      FocusScope.of(context).unfocus();
                      context.read<SignUpBloc>().add(SignUpOnNextStep());
                    },
                    onStepCancel: () {
                      FocusScope.of(context).unfocus();
                      context.read<SignUpBloc>().add(SignUpOnBackStep());
                    },
                    controlsBuilder:
                        (BuildContext context, ControlsDetails controls) {
                      return ResponsiveWidget.isSmallScreen(context)
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 25.0),
                              child: state.status.isSubmissionInProgress
                                  ? Center(
                                      child: LoadingAnimationWidget
                                          .fourRotatingDots(
                                        color: color!,
                                        size: 50,
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Expanded(
                                          child: TextButton(
                                            onPressed: controls.onStepCancel,
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: const Size(140, 50),
                                            ),
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .aeBackButtonLbl,
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: controls.onStepContinue,
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: const Size(140, 50),
                                                primary: Colors.blue),
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .aeContinueButtonLbl),
                                          ),
                                        ),
                                      ],
                                    ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(
                                  right: 400, left: 400, top: 20, bottom: 20),
                              child: state.status.isSubmissionInProgress
                                  ? Center(
                                      child: LoadingAnimationWidget
                                          .fourRotatingDots(
                                        color: color!,
                                        size: 50,
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Expanded(
                                          child: TextButton(
                                            onPressed: controls.onStepCancel,
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: const Size(140, 50),
                                            ),
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .aeBackButtonLbl,
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: controls.onStepContinue,
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: const Size(140, 50),
                                                primary: Colors.blue),
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .aeContinueButtonLbl),
                                          ),
                                        ),
                                      ],
                                    ),
                            );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 80.0),
        child: Text(AppLocalizations.of(context)!.signUpRegisteringUserMsg));
  }
}
