import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/environment_config.dart';
import 'package:ligas_futbol_flutter/src/presentation/account/account_delete_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ligas_futbol_flutter/src/presentation/splash/responsive_widget.dart';

import '../../../service_locator/injection.dart';
import '../../app/app.dart';
import 'account/account_page.dart';
import 'account/account_web_page.dart';
import 'notification/cubit/notification_cubit.dart';
import 'notification/notification_page.dart';
import 'personal_data/personal_data.dart';
import 'role/role_page.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({super.key});

  static Route route() =>
      MaterialPageRoute(builder: (_) => const ProfileUser());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.grey[200],
          title: Text(
            '${AppLocalizations.of(context)!.myprofileLBL}',
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
      body: ResponsiveWidget.isSmallScreen(context)
          ? _ProfilePageBodyMobile()
          : _ProfilePageBodyWeb(),
    );
  }
}

class _ProfilePageBodyMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return GridView(
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0),
      children: [
        InkWell(
          child: _ProfileOptionCard(
            pathImg: "assets/images/perfil_image.png",
            title: AppLocalizations.of(context)!.accountInfoLBL,
            subtitle: AppLocalizations.of(context)!.accountInfoDetsLBL,
          ),
          onTap: () {
            Navigator.push(context, AccountPage.route());
          },
        ),
        InkWell(
          child: _ProfileOptionCard(
            pathImg: "assets/images/acount_perfil.png",
            title: AppLocalizations.of(context)!.myPersonalInfoLBL,
            subtitle: AppLocalizations.of(context)!.myPersonalInfoDetsLBL,
          ),
          onTap: () {
            Navigator.push(context, PersonalData.route());
          },
        ),
        InkWell(
          child: _ProfileOptionCard(
            pathImg: "assets/images/change_rol.png",
            title: AppLocalizations.of(context)!.rolesLBL,
            subtitle: AppLocalizations.of(context)!.roleDetsLBL,
          ),
          onTap: () {
            Navigator.push(context, RolePage.route());
          },
        ),
        InkWell(
          child:  _ProfileOptionCard(
            pathImg: "assets/images/notif.png",
            title: AppLocalizations.of(context)!.notificationsLBL,
            subtitle: AppLocalizations.of(context)!.notificationsDetsLBL,
          ),
          onTap: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return BlocProvider(
                  create: (_) => locator<NotificationCubit>()
                    ..onGetUserConfiguration(user.id ?? 0),
                  child: const NotificationV(),
                );
              },
            );
          },
        ),
        InkWell(
          child: _ProfileOptionCard(
            pathImg: "assets/images/delete_user.png",
            title: AppLocalizations.of(context)!.deleteAccountLBL,
            subtitle: AppLocalizations.of(context)!.deleteAccountDetsLBL
          ),
          onTap: () {
            Navigator.push(context, AccountDeletePage.route());
          },
        ),
      ],
    );
  }
}

class _ProfileOptionCard extends StatelessWidget {
  const _ProfileOptionCard({
    Key? key,
    required this.pathImg,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String pathImg;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      elevation: 3.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(pathImg),
            width: 60,
            height: 60,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(
                color: Colors.grey[800],
                fontSize: 15,
                fontWeight: FontWeight.w900),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfilePageBodyWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Column(
            children: [
              _CardUserProfile(),
              const Card(
                child: SizedBox(
                  height: 400,
                  width: 700,
                  child: _MenuBodyWeb(),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _MenuBodyWeb extends StatelessWidget {
  const _MenuBodyWeb({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Stack(
      children: [
        ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 10),
                _ProfileOptionList(
                  icon: Icons.person_rounded,
                  title: AppLocalizations.of(context)!.accountInfoLBL,
                  subtitle: AppLocalizations.of(context)!.accountInfoDetsLBL,
                  normal: true,
                  onTap: () {
                    Navigator.push(context, AccountWebPage.route());
                  },
                ),
                const Divider(),
                _ProfileOptionList(
                  icon: Icons.recent_actors,
                  title:  AppLocalizations.of(context)!.rolesLBL,
                  subtitle: AppLocalizations.of(context)!.roleDetsLBL,
                  normal: true,
                  onTap: () {
                    Navigator.push(context, RolePage.route());
                  },
                ),
                const Divider(),
                _ProfileOptionList(
                  icon: Icons.notifications,
                  title: AppLocalizations.of(context)!.notificationsLBL,
                  subtitle: AppLocalizations.of(context)!.notificationsDetsLBL,
                  normal: true,
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return BlocProvider(
                          create: (_) => locator<NotificationCubit>()
                            ..onGetUserConfiguration(user.id ?? 0),
                          child: const NotificationV(),
                        );
                      },
                    );
                  },
                ),
                const Divider(),
                _ProfileOptionList(
                  icon: Icons.delete_forever,
                  title: AppLocalizations.of(context)!.deleteAccountLBL,
                  subtitle: AppLocalizations.of(context)!.deleteAccountDetsLBL,
                  normal: false,
                  onTap: () {
                    Navigator.push(context, AccountDeletePage.route());
                  },
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    'v${EnvironmentConfig.appVersion}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _CardUserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0), //<-- SEE HERE
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 700, maxHeight: 80),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/usuario.png'),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: RichText(
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(children: [
                            TextSpan(
                              text: user.person.getFullName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                          ]),
                        )),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text("${AppLocalizations.of(context)!.currentRoleLBL}: ${user.getCurrentRol(context)}"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileOptionList extends StatelessWidget {
  const _ProfileOptionList({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.normal,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String subtitle;
  final bool normal;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: normal
          ? CircleAvatar(
              radius: 28,
              backgroundColor: const Color(0xff358aac),
              child: Icon(icon, size: 25),
            )
          : CircleAvatar(
              radius: 28,
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
              child: Icon(icon, size: 25),
            ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 18,
      ),
      title: Text(title, style: const TextStyle(fontSize: 20)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 15)),
      onTap: () => onTap!(),
    );
  }
}
