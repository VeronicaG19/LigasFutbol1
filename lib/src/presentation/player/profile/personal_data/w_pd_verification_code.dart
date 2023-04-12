import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../app/bloc/authentication_bloc.dart';
import 'cubit/personal_data_cubit.dart';

class PDVerificationCode extends StatefulWidget {
  const PDVerificationCode({Key? key}) : super(key: key);

  @override
  State<PDVerificationCode> createState() => _PDVerificationCodeState();
}

class _PDVerificationCodeState extends State<PDVerificationCode>
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
    //listenForCode();
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
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    final buttons = [
      Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 25.0),
        child: ElevatedButton(
          child: const Text('Reenviar código'),
          onPressed: () {
            context.read<PersonalDataCubit>().onResentVerificationCode(user);
          },
        ),
      ),
      ElevatedButton(
        child: const Text('Cancelar solicitud'),
        onPressed: () {
          context.read<PersonalDataCubit>().onCancelUpdateRequest();
        },
      ),
    ];
    return BlocBuilder<PersonalDataCubit, PersonalDataState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Hemos enviado un código de verificación a:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                child: Text(
                  state.code.receiver,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
              Visibility(
                visible: !(state.code.receiver.length == 10 ),
                child: const Padding(padding: EdgeInsets.all(8.0),
                child: const Text(
                  "En caso de no recibir el código favor de revisar en la carpeta de correos no deseados",
                 textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red
                  ),
                ),),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Introduce el código para continuar con la actualización.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              PinCodeTextField(
                backgroundColor: Colors.white10,
                length: 4,
                onChanged: (value) => context
                    .read<PersonalDataCubit>()
                    .onVerificationCodeChanged(value),
                appContext: context,
                onCompleted: (value) => state.status.isSubmissionInProgress
                    ? null
                    : context
                        .read<PersonalDataCubit>()
                        .onSubmitVerificationCode(user),
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                beforeTextPaste: (text) {
                  return false;
                },
              ),
              if (state.status.isSubmissionInProgress)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              if (!state.status.isSubmissionInProgress) ...buttons,
            ],
          ),
        );
      },
    );
  }
}
