import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            'Mi perfil',
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
          child: Card(
            color: Colors.grey[100],
            elevation: 3.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage("assets/images/perfil_image.png"),
                  width: 60,
                  height: 60,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Datos de cuenta',
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 15,
                      fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Edite los datos de usuario o contraseña',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(context, AccountPage.route());
          },
        ),
        InkWell(
          child: Card(
            color: Colors.grey[100],
            elevation: 3.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage("assets/images/acount_perfil.png"),
                  width: 50,
                  height: 50,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Datos personales',
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 15,
                      fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Edite los datos de nombre, telefono o correo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(context, PersonalData.route());
          },
        ),
        InkWell(
          child: Card(
            color: Colors.grey[100],
            elevation: 3.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage("assets/images/change_rol.png"),
                  width: 60,
                  height: 60,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Roles',
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 15,
                      fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Cambiar de rol',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(context, RolePage.route());
          },
        ),
        InkWell(
          child: Card(
            color: Colors.grey[100],
            elevation: 3.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage("assets/images/notif.png"),
                  width: 60,
                  height: 60,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Notificaciones',
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 15,
                      fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Recibir notificaciones acerca de ligas fútbol',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
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
      ],
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
                ListTile(
                    leading: const CircleAvatar(
                        radius: 28,
                        backgroundColor: Color(0xff358aac),
                        child: Icon(
                          Icons.person_rounded,
                          size: 25,
                        )),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                    ),
                    title:
                        const Text('Mis datos', style: TextStyle(fontSize: 20)),
                    subtitle: const Text(
                        'Visualice o edite los datos personales.',
                        style: TextStyle(fontSize: 15)),
                    onTap: () {
                      Navigator.push(context, AccountWebPage.route());
                    }),
                const Divider(),
                ListTile(
                    leading: const CircleAvatar(
                        radius: 28,
                        backgroundColor: Color(0xff358aac),
                        child: Icon(
                          Icons.recent_actors,
                          size: 25,
                        )),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                    ),
                    title: const Text('Roles', style: TextStyle(fontSize: 20)),
                    subtitle: const Text(
                        'Consulta la información de los roles disponibles.',
                        style: TextStyle(fontSize: 15)),
                    onTap: () {
                      Navigator.push(context, RolePage.route());
                    }),
                const Divider(),
                ListTile(
                    leading: const CircleAvatar(
                        radius: 28,
                        backgroundColor: Color(0xff358aac),
                        child: Icon(
                          Icons.notifications,
                          size: 25,
                        )),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                    ),
                    title: const Text('Notificaciones',
                        style: TextStyle(fontSize: 20)),
                    subtitle: const Text(
                        'Recibir notificaciones acerca de ligas fútbol.',
                        style: TextStyle(fontSize: 15)),
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
                    }),
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
                      child: Text("Rol actual: ${user.getCurrentRol}"),
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
