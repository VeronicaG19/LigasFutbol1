import 'package:authentication_repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:user_repository/user_repository.dart';

import '../../../../environment_config.dart';
import '../../../service_locator/injection.dart';
import '../app.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: locator<AuthenticationRepository>(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => locator<AuthenticationBloc>(),
          ),
          BlocProvider(
            //lazy: false,
            create: (_) => locator<NotificationBloc>(),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: context.watch<AuthenticationBloc>().state.locale,
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('es', ''),
      ],
      onGenerateTitle: (BuildContext context) => EnvironmentConfig.appName,
      theme: ThemeData(),
      home: MultiBlocListener(
        listeners: [
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listenWhen: (previous, current) =>
                previous.user.applicationRol != current.user.applicationRol &&
                current.user.applicationRol != ApplicationRol.unknown,
            listener: (context, state) {
              if (state.user.applicationRol == ApplicationRol.player) {
                context.read<NotificationBloc>().add(LoadNotificationCount(
                    state.user.person.personId, state.user.applicationRol));
              } else if (state.user.applicationRol == ApplicationRol.referee) {
                context.read<NotificationBloc>().add(LoadNotificationCount(
                    state.refereeData.refereeId, state.user.applicationRol));
              } else if (state.user.applicationRol ==
                  ApplicationRol.teamManager) {
                context.read<NotificationBloc>().add(LoadNotificationCount(
                    state.selectedTeam.teamId, state.user.applicationRol));
              } else if (state.user.applicationRol ==
                  ApplicationRol.leagueManager) {
                context.read<NotificationBloc>().add(LoadNotificationCount(
                    state.selectedLeague.leagueId, state.user.applicationRol));
              } else if (state.user.applicationRol ==
                  ApplicationRol.fieldOwner) {
                context.read<NotificationBloc>().add(LoadNotificationCount(
                    state.selectedLeague.leagueId, state.user.applicationRol));
              }
            },
          ),
          BlocListener<NotificationBloc, NotificationState>(
            listenWhen: (previous, current) {
              return current.notification.isNotEmpty &&
                  current.appState != null &&
                  previous.notification != current.notification;
            },
            listener: (context, state) {
              final notification = state.notification;
              if (state.appState!.isForeground) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return _NotificationDialog(
                        notification: notification,
                      );
                    });
              } else if (state.appState!.isBackground) {
                // if (notification.data?.actionType == 'SEND_INVITATION') {
                //   Navigator.push(context, ProfileUser.route());
                // }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(notification.body),
                  ),
                );
              }
            },
          ),
        ],
        child: FlowBuilder<AuthenticationStatus>(
          state: context.select((AuthenticationBloc bloc) => bloc.state.status),
          onGeneratePages: onGenerateAppViewPages,
        ),
      ),
    );
  }
}

class _NotificationDialog extends StatelessWidget {
  const _NotificationDialog({Key? key, this.notification}) : super(key: key);

  final NotificationModel? notification;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(notification?.title ?? ''),
      content: Text(notification?.body ?? ''),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('ACEPTAR'),
        ),
      ],
    );
  }
}
