import 'package:authentication_repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ligas_futbol_flutter/src/presentation/sign_up/bloc/sign_up_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/sign_up/view/view.dart';
import 'package:user_repository/user_repository.dart';

class SignUpWizard extends StatelessWidget {
  const SignUpWizard({Key? key}) : super(key: key);

  static Route<User> route() =>
      MaterialPageRoute(builder: (_) => const SignUpWizard());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpBloc(context.read<AuthenticationRepository>()),
      child: SignUpWizardFlow(
        onComplete: (user) => Navigator.of(context).pop(user),
      ),
    );
  }
}

class SignUpWizardFlow extends StatelessWidget {
  const SignUpWizardFlow({
    Key? key,
    required this.onComplete,
  }) : super(key: key);

  final ValueSetter<User> onComplete;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listenWhen: (_, state) => state.status.isSubmissionSuccess,
      listener: (context, state) => onComplete(state.userModel),
      child: FlowBuilder<SignUpState>(
        state: context.watch<SignUpBloc>().state,
        onGeneratePages: (state, pages) {
          return [
            VerificationForm.page(),
            if (state.signUpStatus == SignUpStatus.userForm) SignUpForm.page(),
          ];
        },
      ),
    );
  }
}
