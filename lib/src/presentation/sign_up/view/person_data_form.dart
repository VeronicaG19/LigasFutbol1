import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';
import 'package:ligas_futbol_flutter/src/presentation/sign_up/bloc/sign_up_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/splash/responsive_widget.dart';

class PersonDataForm extends StatelessWidget {
  const PersonDataForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context) ?
    Column(
      children: [
        const SizedBox(
          width: 25,
          height: 25,
        ),
        Text(
          AppLocalizations.of(context)!.signUpPersonFormLbl,
        ),
        const SizedBox(
          width: 20,
          height: 20,
        ),
        _FirstNameInput(),
        const SizedBox(
          width: 20,
          height: 20,
        ),
        _LastNameInput()
      ],
    ) :
    Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 400, left: 400, top: 20, bottom: 20),
        child: Column(
          children: [
            const SizedBox(
              width: 25,
              height: 25,
            ),
            Text(
              AppLocalizations.of(context)!.signUpPersonFormLbl,
            ),
            const SizedBox(
              width: 20,
              height: 20,
            ),
            _FirstNameInput(),
            const SizedBox(
              width: 20,
              height: 20,
            ),
            _LastNameInput()
          ],
        )
      ),
    );
  }
}

class _FirstNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return TextFormField(
          key: const Key('personDataForm_firstNameInput_textField'),
          initialValue: context.watch<SignUpBloc>().state.firstName.value,
          onChanged: (firstName) =>
              context.read<SignUpBloc>().add(SignUpFirstNameChanged(firstName)),
          onFieldSubmitted: (value) => state.status.isSubmissionInProgress
              ? null
              : context.read<SignUpBloc>().add(SignUpOnNextStep()),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.aeFirstNameLbl,
            helperText: '',
            errorText: state.firstName.invalid
                ? AppLocalizations.of(context)!.signUpFirstNameFailureMsg
                : null,
          ),
        );
      },
    );
  }
}

class _LastNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return TextFormField(
          key: const Key('personDataForm_lastNameInput_textField'),
          initialValue: context.watch<SignUpBloc>().state.lastName.value,
          onChanged: (lastName) =>
              context.read<SignUpBloc>().add(SignUpLastNameChanged(lastName)),
          onFieldSubmitted: (value) => state.status.isSubmissionInProgress
              ? null
              : context.read<SignUpBloc>().add(SignUpOnNextStep()),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.aeLastNameLbl,
            helperText: '',
            errorText: state.lastName.invalid
                ? AppLocalizations.of(context)!.signUpLastNameFailureMsg
                : null,
          ),
        );
      },
    );
  }
}
