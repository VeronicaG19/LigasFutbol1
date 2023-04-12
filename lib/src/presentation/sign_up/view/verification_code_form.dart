import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';
import 'package:ligas_futbol_flutter/src/presentation/sign_up/bloc/sign_up_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/splash/responsive_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';

class VerificationCodeForm extends StatelessWidget {
  const VerificationCodeForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context) ?
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.signUpEnterCodeLbl,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20.0,
        ),
        Text(
          AppLocalizations.of(context)!.signUpCodeFormLbl(
              context.watch<SignUpBloc>().state.verificationSender.value),
        ),
         const SizedBox(
              height: 7.0,
            ),
            Visibility(
              visible: (context.watch<SignUpBloc>().state.verificationType == VerificationType.email),
              child: const Text(
                "En caso de no recibir el código favor de revisar en la carpeta de correos no deseados",
               textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.red
                ),
              ),
            ),
        const SizedBox(
          height: 25.0,
        ),
        _CodeAutoFillPage(),
        const SizedBox(
          height: 25.0,
        ),
        Visibility(
          visible:
          !context.watch<SignUpBloc>().state.status.isSubmissionInProgress,
          child: _ResentCodeButton(),
        ),
      ],
    ) :
    Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 400, left: 400, top: 20, bottom: 20),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.signUpEnterCodeLbl,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              AppLocalizations.of(context)!.signUpCodeFormLbl(
                  context.watch<SignUpBloc>().state.verificationSender.value),
            ),
            const SizedBox(
              height: 9.0,
            ),
            Visibility(
              visible: (context.watch<SignUpBloc>().state.verificationType == VerificationType.email),
              child: const Text(
                "En caso de no recibir el código favor de revisar en la carpeta de correos no deseados",
               textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.red
                ),
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            _CodeAutoFillPage(),
            const SizedBox(
              height: 25.0,
            ),
            Visibility(
              visible:
              !context.watch<SignUpBloc>().state.status.isSubmissionInProgress,
              child: _ResentCodeButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResentCodeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('verificationCodeForm_resent_raisedButton'),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        primary: Colors.blueAccent,
      ),
      onPressed: () => context.read<SignUpBloc>().add(const SignUpResentCode()),
      child: Text(
        AppLocalizations.of(context)!.signUpResentCodeButtonLbl,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class _CodeAutoFillPage extends StatefulWidget {
  @override
  _CodeAutoFillPageState createState() => _CodeAutoFillPageState();
}

class _CodeAutoFillPageState extends State<_CodeAutoFillPage>
    with CodeAutoFill {
  String? appSignature;
  String? otpCode;

  @override
  void codeUpdated() {
    setState(() {
      otpCode = code;
    });
  }

  @override
  void initState() {
    super.initState();
    listenForCode();

    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: /*context.watch<SignUpBloc>().state.verificationType ==
                  VerificationType.phone
              ? PinFieldAutoFill(
                  decoration: UnderlineDecoration(
                    textStyle:
                        const TextStyle(fontSize: 20, color: Colors.black),
                    colorBuilder:
                        FixedColorBuilder(Colors.black.withOpacity(0.3)),
                  ),
                  codeLength: 4,
                  currentCode: otpCode,
                  onCodeChanged: (value) => context
                      .read<SignUpBloc>()
                      .add(SignUpVerificationCodeChanged(value!)),
                  onCodeSubmitted: (value) =>
                      state.status.isSubmissionInProgress
                          ? null
                          : context.read<SignUpBloc>().add(SignUpOnNextStep()),
                )
              : */
              PinCodeTextField(
                  backgroundColor: Colors.white10,
                  length: 4,
                  onChanged: (value) => context
                      .read<SignUpBloc>()
                      .add(SignUpVerificationCodeChanged(value)),
                  appContext: context,
                  onCompleted: (value) => state.status.isSubmissionInProgress
                      ? null
                      : context.read<SignUpBloc>().add(SignUpOnNextStep()),
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  beforeTextPaste: (text) {
                    return false;
                  }),
        );
      },
    );
  }
}
