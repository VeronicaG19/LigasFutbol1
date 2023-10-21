import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/enums.dart';
import '../../../app/bloc/authentication_bloc.dart';
import 'cubit/personal_data_cubit.dart';
import 'w_pd_verification_code.dart';

class FormDataContent extends StatelessWidget {
  const FormDataContent({Key? key}) : super(key: key);

  static const String kEmailTitle = 'Actualizar correo electrónico';
  static const String kPhoneTitle = 'Actualizar teléfono';
  static const String kNameTitle = 'Actualizar nombre';
  static const String kPhoneSuccess =
      'Se ha actualizado el teléfono correctamente';
  static const String kEmailSuccess =
      'Se ha actualizado el correo electrónico correctamente';
  static const String kNameSuccess =
      'Se ha actualizado tu nombre correctamente';
  static const String kUserNameWarningMessage =
      'Se ha actualizado tu nombre correctamente';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonalDataCubit, PersonalDataState>(
      listenWhen: (_, state) =>
          state.status.isSubmissionFailure || state.status.isSubmissionSuccess,
      listener: (context, state) {
        if (state.action == PersonalDataSubmitAction.updatePersonName &&
            state.status.isSubmissionSuccess) {
          context.read<AuthenticationBloc>().add(UpdateUserData(state.user));
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text(kNameSuccess),
              ),
            );
          Navigator.pop(context);
        }
        if (state.status.isSubmissionSuccess &&
            state.code.statusCode == 'CONFIRMED') {
          context.read<AuthenticationBloc>().add(UpdateUserData(state.user));
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: state.action == PersonalDataSubmitAction.updatePhone
                    ? const Text(kPhoneSuccess)
                    : const Text(kEmailSuccess),
                content: RichText(
                  text: TextSpan(
                    text:
                        'El ${state.action == PersonalDataSubmitAction.updatePhone ? 'teléfono' : 'correo electrónico'} que actualizaste también era tu nombre de usuario, por lo que tu nombre de usuario también cambió. Usa ',
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: state.user.userName,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: ' la próxima vez que inicies sesión.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Aceptar'),
                  ),
                ],
              );
            },
          );
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                SnackBar(content: Text(state.errorMessage ?? 'error')));
        }
      },
      builder: (context, state) {
        if (state.isVerificationScreen) {
          return const PDVerificationCode();
        }
        return Column(
          children: <Widget>[
            if (state.action == PersonalDataSubmitAction.updatePersonName) ...[
              const Text(kNameTitle),
              const _FirstNameInput(),
              const _LastNameInput()
            ],
            if (state.action == PersonalDataSubmitAction.updateEmail) ...[
              const Text(kEmailTitle),
              const _EmailInput()
            ],
            if (state.action == PersonalDataSubmitAction.updatePhone) ...[
              const Text(kPhoneTitle),
              const _PhoneInput()
            ],
            //if(Platform.isIOS || Platform.isAndroid)
            const _SubmitButton(),
          ],
        );
      },
    );
  }
}

class _FirstNameInput extends StatelessWidget {
  const _FirstNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return BlocBuilder<PersonalDataCubit, PersonalDataState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            autofocus: true,
            enabled: !state.status.isSubmissionInProgress,
            onChanged: (value) =>
                context.read<PersonalDataCubit>().onFirstNameChanged(value),
            onFieldSubmitted: (value) => state.status.isSubmissionInProgress
                ? null
                : context.read<PersonalDataCubit>().onUpdatePersonName(user),
            decoration: InputDecoration(
              labelText: 'Nombre:',
              errorText: state.firstName.invalid
                  ? 'Introduce los datos faltantes'
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class _LastNameInput extends StatelessWidget {
  const _LastNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return BlocBuilder<PersonalDataCubit, PersonalDataState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            autofocus: true,
            enabled: !state.status.isSubmissionInProgress,
            onChanged: (value) =>
                context.read<PersonalDataCubit>().onLastNameChanged(value),
            onFieldSubmitted: (value) => state.status.isSubmissionInProgress
                ? null
                : context.read<PersonalDataCubit>().onUpdatePersonName(user),
            decoration: InputDecoration(
              labelText: 'Apellido:',
              errorText: state.lastName.invalid
                  ? 'Introduce los datos faltantes'
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return BlocBuilder<PersonalDataCubit, PersonalDataState>(
      buildWhen: (previous, current) =>
          previous.emailInput != current.emailInput,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            autofocus: true,
            enabled: !state.status.isSubmissionInProgress,
            onChanged: (value) =>
                context.read<PersonalDataCubit>().onEmailChanged(value),
            onFieldSubmitted: state.status.isSubmissionInProgress
                ? null
                : (value) {
                    final cubit = BlocProvider.of<PersonalDataCubit>(context);
                    if (user.userName == user.person.getMainEmail) {
                      _showWarningDialog(context, state.action, cubit);
                    } else {
                      context
                          .read<PersonalDataCubit>()
                          .onSendVerificationCode(user);
                    }
                  },
            decoration: InputDecoration(
              labelText: 'Correo electrónico:',
              errorText: state.emailInput.invalid
                  ? 'Introduce los datos faltantes'
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class _PhoneInput extends StatelessWidget {
  const _PhoneInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return BlocBuilder<PersonalDataCubit, PersonalDataState>(
      buildWhen: (previous, current) =>
          previous.phoneInput != current.phoneInput,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            maxLength: 10,
            keyboardType: TextInputType.phone,
            autofocus: true,
            enabled: !state.status.isSubmissionInProgress,
            onChanged: (value) =>
                context.read<PersonalDataCubit>().onPhoneChanged(value),
            onFieldSubmitted: state.status.isSubmissionInProgress
                ? null
                : (value) {
                    final cubit = BlocProvider.of<PersonalDataCubit>(context);
                    if (user.userName == user.person.getUnformattedMainPhone) {
                      _showWarningDialog(context, state.action, cubit);
                    } else {
                      context
                          .read<PersonalDataCubit>()
                          .onSendVerificationCode(user);
                    }
                  },
            decoration: InputDecoration(
              labelText: 'Teléfono:',
              errorText: state.phoneInput.invalid
                  ? 'Introduce los datos faltantes'
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return BlocBuilder<PersonalDataCubit, PersonalDataState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: state.status.isSubmissionInProgress
              ? Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                      color: Colors.blueAccent, size: 50),
                )
              : ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (state.action ==
                        PersonalDataSubmitAction.updatePersonName) {
                      context
                          .read<PersonalDataCubit>()
                          .onUpdatePersonName(user);
                    } else {
                      final cubit = BlocProvider.of<PersonalDataCubit>(context);
                      if (PersonalDataSubmitAction.updatePhone ==
                          state.action) {
                        if (user.userName ==
                            user.person.getUnformattedMainPhone) {
                          _showWarningDialog(context, state.action, cubit);
                        } else {
                          context
                              .read<PersonalDataCubit>()
                              .onSendVerificationCode(user);
                        }
                      } else {
                        if (user.userName == user.person.getMainEmail) {
                          _showWarningDialog(context, state.action, cubit);
                        } else {
                          context
                              .read<PersonalDataCubit>()
                              .onSendVerificationCode(user);
                        }
                      }
                    }
                  },
                  child: const Text('Aceptar'),
                ),
        );
      },
    );
  }
}

void _showWarningDialog(BuildContext context,
    final PersonalDataSubmitAction action, PersonalDataCubit cubit) {
  showDialog(
    context: context,
    builder: (context) {
      return BlocProvider.value(
        value: cubit,
        child: _DialogContent(
          action: action,
        ),
      );
    },
  );
}

class _DialogContent extends StatelessWidget {
  const _DialogContent({Key? key, required this.action}) : super(key: key);

  final PersonalDataSubmitAction action;
  static const String phone = 'Teléfono';
  static const String email = 'Correo electrónico';

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return AlertDialog(
      title: const Text('Advertencia'),
      content: Text(
          ('El ${action == PersonalDataSubmitAction.updatePhone ? phone : email} que estas actualizando también es tu nombre de usuario. Si continúas con el proceso también actualizarás tu nombre de usuario.')),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            context.read<PersonalDataCubit>().onSendVerificationCode(user);
            Navigator.pop(context);
          },
          child: const Text('Continuar'),
        ),
      ],
    );
  }
}
