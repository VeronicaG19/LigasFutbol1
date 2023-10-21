import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/presentation/account/cubit/account_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';

class AccountDeletePage extends StatelessWidget {
  const AccountDeletePage({
    Key? key,
  }) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (_) => const AccountDeletePage());

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);

    return BlocProvider(
      create: (_) => locator<AccountCubit>()..loadInitialData(user: user),
      child: const _PageBody(),
    );
  }
}

class _PageBody extends StatelessWidget {
  const _PageBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.grey[200],
          title: Text(
            'Cerrar cuenta',
            style: TextStyle(
              color: Colors.grey[200],
              fontWeight: FontWeight.w900,
            ),
          ),
          flexibleSpace: const Image(
            image: AssetImage('assets/images/imageAppBar25.png'),
            fit: BoxFit.cover,
          ),
          elevation: 0.0,
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: const _BodyContent(),
    );
  }
}

class _BodyContent extends StatelessWidget {
  const _BodyContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _InformationCard(
            child: Column(
              children: [
                Text(
                  "Cerrar tu cuenta de Ligas Futbol",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Lee esto detenidamente",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          const _InformationCard(
            child: Text(
              "Antes de proceder, queremos informarte sobre las implicaciones y consecuencias de cerrar tu cuenta de forma permanente.",
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ),
          const SizedBox(height: 10),
          _InformationCard(
            child: RichText(
              text: const TextSpan(
                text:
                    'Cerrar tu cuenta significa que perderás acceso a todas las funcionalidades y datos asociados a tu perfil en la aplicación ',
                style: TextStyle(fontSize: 15.0, color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Ligas Futbol',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                      text:
                          '. Esto incluye tu historial de partidos, estadísticas, logros y cualquier otro dato o contenido relacionado con tu cuenta. Además, una vez que tu cuenta sea cerrada, no podrás recuperarla en el futuro.'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const _InformationCard(
            child: _CheckboxContinue(),
          ),
          const SizedBox(height: 10),
          const _ButtonContinue(),
        ],
      ),
    );
  }
}

class _InformationCard extends StatelessWidget {
  const _InformationCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: child,
      ),
    );
  }
}

class _CheckboxContinue extends StatelessWidget {
  const _CheckboxContinue({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountCubit, AccountState>(
      builder: (context, state) {
        return Row(
          children: [
            Checkbox(
              activeColor: Colors.cyan.shade800,
              value: state.warningReaded,
              onChanged: (value) {
                context.read<AccountCubit>().onCheckWarning(flag: value!);
              },
            ),
            const Text(
              'He leído y deseo continuar',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            )
          ],
        );
      },
    );
  }
}

class _ButtonContinue extends StatelessWidget {
  const _ButtonContinue({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double paddingElevationButton = 15;

    return BlocBuilder<AccountCubit, AccountState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    state.warningReaded
                        ? Colors.red.shade800
                        : Colors.grey.shade600,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(
                    top: paddingElevationButton,
                    bottom: paddingElevationButton,
                  ),
                  child:
                      Text('Cerrar cuenta', style: TextStyle(fontSize: 20.0)),
                ),
                onPressed: () {
                  state.warningReaded
                      ? showDialog(
                          context: context,
                          builder: (_) {
                            return BlocProvider<AccountCubit>.value(
                              value: context.read<AccountCubit>(),
                              child: const _ModalCloseAccount(),
                            );
                          },
                        )
                      : null;
                },
              ),
            )
          ],
        );
      },
    );
  }
}

class _ModalCloseAccount extends StatelessWidget {
  const _ModalCloseAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SimpleDialog(
      title: Center(
        child: Text(
          '¿Estas completamente seguro?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),
      ),
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _ButtonCancel(),
              ),
              SizedBox(width: 15),
              Expanded(
                child: _ButtonFinish(),
              )
            ],
          ),
        )
      ],
    );
  }
}

class _ButtonCancel extends StatelessWidget {
  const _ButtonCancel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double paddingElevationButton = 10;

    return BlocBuilder<AccountCubit, AccountState>(
      builder: (context, state) {
        return ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.cyan.shade800,
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.only(
              top: paddingElevationButton,
              bottom: paddingElevationButton,
            ),
            child: Text(
              'No!',
              style: TextStyle(fontSize: 13.0),
            ),
          ),
          onPressed: () {
            context.read<AccountCubit>().cancelDeactivateAccount();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}

class _ButtonFinish extends StatelessWidget {
  const _ButtonFinish({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double paddingElevationButton = 10;

    return BlocConsumer<AccountCubit, AccountState>(
      listener: (context, state) {
        if (state.screenState == BasicCubitScreenState.submissionSuccess) {
          Navigator.of(context).pop();

          context
              .read<AuthenticationBloc>()
              .add(AuthenticationLogoutRequested());
        }
      },
      buildWhen: (previous, current) =>
          previous.screenState != current.screenState,
      builder: (context, state) {
        return ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.cyan.shade900,
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.only(
              top: paddingElevationButton,
              bottom: paddingElevationButton,
            ),
            child: Text(
              'Si, estoy seguro',
              style: TextStyle(fontSize: 13.0),
            ),
          ),
          onPressed: () {
            context.read<AccountCubit>().deactivateAccount();
          },
        );
      },
    );
  }
}
