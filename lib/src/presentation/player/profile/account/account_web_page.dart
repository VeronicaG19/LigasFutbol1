import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/enums.dart';
import '../../../../service_locator/injection.dart';
import '../../../app/app.dart';
import '../personal_data/w_menu_option.dart';
import 'cubit/account_cubit.dart';

enum _SubmitAction { updatePersonName, updateEmail, updatePhone }

class AccountWebPage extends StatelessWidget {
  const AccountWebPage({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (_) => const AccountWebPage());

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    // final userstat =
    //     context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Scaffold(
      //drawer: Drawer(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.grey[200],
          title: Text(
            'Mis Datos',
            style:
                TextStyle(color: Colors.grey[200], fontWeight: FontWeight.w900),
          ),
          flexibleSpace: const Image(
            image: AssetImage('assets/images/imageAppBar25.png'),
            fit: BoxFit.cover,
          ),
          elevation: 0.0,
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            children: [
              _SingleSection(
                title: "Datos de la cuenta",
                children: [
                  ListTile(
                    leading: const Icon(Icons.account_circle_rounded),
                    title: const Text('Usuario'),
                    subtitle: Text(user.userName),
                    onTap: () {
                      /*showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 400,
                    color: const Color.fromARGB(255, 236, 236, 236),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('Editar Usuario'),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  hintText: "pedro.com@gmail.com",
                                  labelText: 'Usuario'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ElevatedButton(
                              child: const Text('Guardar Cambios'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );*/
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.password),
                    title: const Text('Contraseña'),
                    subtitle: const Text("********"),
                    onTap: () {
                      showModalBottomSheet<void>(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return BlocProvider(
                            create: (_) => locator<AccountCubit>()..init(),
                            child: const _FormDataContent(
                              elements: [
                                Text('Editar Contraseña'),
                                _OriginalPasswordInput(),
                                _PasswordInput(),
                                _Password2Input(),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              _SingleSection(
                title: "Datos personales",
                children: [
                  PDMenuOption(
                    icon: Icons.settings,
                    title: 'Nombre',
                    subtitle: user.person.getFullName,
                    action: PersonalDataSubmitAction.updatePersonName,
                  ),
                  PDMenuOption(
                    icon: Icons.edit,
                    title: 'Correo electrónico',
                    subtitle: user.person.getMainEmail,
                    action: PersonalDataSubmitAction.updateEmail,
                  ),
                  PDMenuOption(
                    icon: Icons.change_circle,
                    title: 'Teléfono',
                    subtitle: user.person.getFormattedMainPhone,
                    action: PersonalDataSubmitAction.updatePhone,
                  ),
                  /*ListTile(
                    leading: const Icon(Icons.drive_file_rename_outline),
                    title: const Text('Nombre'),
                    subtitle: Text(userstat.person.getFullName),
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext contextS) {
                          return BlocProvider(
                            create: (_) => locator<PersonalDataCubit>(),
                            child: const _FormDataContentPersonal(
                              elements: [
                                Text('Editar Nombre'),
                                _FirstNameInput(),
                                _LastNameInput(),
                              ],
                              action: _SubmitAction.updatePersonName,
                            ),
                          );
                        },
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.mail),
                    title: const Text('Correo electrónico'),
                    subtitle: Text(userstat.person.getMainEmail),
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return BlocProvider(
                            create: (_) => locator<PersonalDataCubit>(),
                            child: const _FormDataContentPersonal(
                              elements: [
                                Text('Editar Correo'),
                                _EmailInput(),
                              ],
                              action: _SubmitAction.updateEmail,
                            ),
                          );
                        },
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('Teléfono'),
                    subtitle: Text(userstat.person.getFormattedMainPhone),
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return BlocProvider(
                            create: (_) => locator<PersonalDataCubit>(),
                            child: const _FormDataContentPersonal(
                              elements: [
                                Text('Editar Telefono'),
                                _PhoneInput(),
                              ],
                              action: _SubmitAction.updatePhone,
                            ),
                          );
                        },
                      );
                    },
                  ),*/
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormDataContent extends StatelessWidget {
  const _FormDataContent({Key? key, required this.elements}) : super(key: key);

  final List<Widget> elements;

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return BlocListener<AccountCubit, AccountState>(
      listenWhen: (_, state) =>
          state.status.isSubmissionFailure || state.status.isSubmissionSuccess,
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
              content: Text('Error al actualizar contraseña'),
            ));
          debugPrint('Error -> ${state.errorMessage}');
        } else if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  content: Text('Contraseña actualizada correctamente'),
                  duration: Duration(seconds: 5)),
            );
          Navigator.pop(context);
        }
      },
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 236, 236, 236),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          height: 400,
          //color: const Color.fromARGB(255, 236, 236, 236),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ...elements,
                BlocBuilder<AccountCubit, AccountState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: state.status.isSubmissionInProgress
                          ? Center(
                              child: LoadingAnimationWidget.fourRotatingDots(
                                  color: Colors.blueAccent, size: 50),
                            )
                          : ElevatedButton(
                              onPressed: state.status.isValidated
                                  ? () {
                                      FocusScope.of(context).unfocus();
                                      context
                                          .read<AccountCubit>()
                                          .onUpdatePassword(user);
                                    }
                                  : null,
                              child: const Text('Guardar Cambios'),
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OriginalPasswordInput extends StatefulWidget {
  const _OriginalPasswordInput({Key? key}) : super(key: key);

  @override
  State<_OriginalPasswordInput> createState() => _OriginalPasswordInputState();
}

class _OriginalPasswordInputState extends State<_OriginalPasswordInput> {
  bool isPasswordVisible = true;

  void _onChangePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return BlocBuilder<AccountCubit, AccountState>(
      buildWhen: (previous, current) =>
          previous.originalPassword != current.originalPassword,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            obscureText: isPasswordVisible,
            keyboardType: TextInputType.visiblePassword,
            autofocus: true,
            enabled: !state.status.isSubmissionInProgress,
            onChanged: (value) =>
                context.read<AccountCubit>().onOriginalPasswordChanged(value),
            onFieldSubmitted: (value) => state.status.isSubmissionInProgress
                ? null
                : context.read<AccountCubit>().onUpdatePassword(user),
            decoration: InputDecoration(
              labelText: 'Contraseña actual:',
              errorText: state.originalPassword.invalid
                  ? 'Contraseña incorrecta'
                  : null,
              suffixIcon: IconButton(
                icon: isPasswordVisible
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
                onPressed: () => _onChangePasswordVisibility(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatefulWidget {
  const _PasswordInput({Key? key}) : super(key: key);

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
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return BlocBuilder<AccountCubit, AccountState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            obscureText: isPasswordVisible,
            keyboardType: TextInputType.visiblePassword,
            autofocus: true,
            enabled: !state.status.isSubmissionInProgress,
            onChanged: (value) =>
                context.read<AccountCubit>().onPasswordChanged(value),
            onFieldSubmitted: (value) => state.status.isSubmissionInProgress
                ? null
                : context.read<AccountCubit>().onUpdatePassword(user),
            decoration: InputDecoration(
              labelText: 'Contraseña:',
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
          ),
        );
      },
    );
  }
}

class _Password2Input extends StatefulWidget {
  const _Password2Input({Key? key}) : super(key: key);

  @override
  State<_Password2Input> createState() => _Password2InputState();
}

class _Password2InputState extends State<_Password2Input> {
  bool isPasswordVisible = true;

  void _onChangePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return BlocBuilder<AccountCubit, AccountState>(
      buildWhen: (previous, current) =>
          previous.password2 != current.password2 ||
          current.password != previous.password,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            obscureText: isPasswordVisible,
            keyboardType: TextInputType.visiblePassword,
            autofocus: true,
            enabled:
                !state.status.isSubmissionInProgress && state.password.valid,
            onChanged: (value) =>
                context.read<AccountCubit>().onPassword2Changed(value),
            onFieldSubmitted: (value) => state.status.isSubmissionInProgress
                ? null
                : context.read<AccountCubit>().onUpdatePassword(user),
            decoration: InputDecoration(
              labelText: 'Confirma tu contraseña:',
              errorText: state.password2.invalid
                  ? 'Las contraseñas no coinciden'
                  : null,
              suffixIcon: IconButton(
                icon: isPasswordVisible
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
                onPressed: () => _onChangePasswordVisibility(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  const _CustomListTile(
      {Key? key, required this.title, required this.icon, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing ?? const Icon(CupertinoIcons.forward, size: 18),
      onTap: () {},
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title.toUpperCase(),
            style:
                Theme.of(context).textTheme.headline3?.copyWith(fontSize: 16),
          ),
        ),
        Container(
          //width: double.infinity,
          color: Colors.white,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
