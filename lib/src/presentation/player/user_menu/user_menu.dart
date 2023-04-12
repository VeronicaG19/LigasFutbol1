import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/bloc/authentication_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user_repository/user_repository.dart';

import '../../referee/referee_calendar/view/referee_calendar_page.dart';
import '../../referee/referee_profile/referee_profile/view/referee_profile_page.dart';
import '../../referee/report_history/view/report_history_page.dart';
import '../../representative/teams/view/representative_teams_page.dart';
import '../../widgets/edit_profile_image/view/profile_image_widget.dart';
import '../player_profile/view/player_profile_page.dart';
import '../profile/profile_page.dart';

final Uri _url = Uri.parse(
    'https://sites.google.com/view/ligasfutbol/terminos-y-condiciones');

class UserMenu extends StatefulWidget {
  const UserMenu({Key? key}) : super(key: key);

  @override
  State<UserMenu> createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user;
    final refereeLeague =
        context.read<AuthenticationBloc>().state.refereeLeague;
    return Stack(
      children: [
        ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 170,
              child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/imageAppBar25.png',
                    ),
                  ),
                ),
                accountName: Text(
                  user.person.getFullName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                currentAccountPicture: const ProfileImageWidget(),
                accountEmail: Text(
                  user.applicationRol == ApplicationRol.referee
                      ? '${user.getCurrentRol} - Liga ${refereeLeague.leagueName}'
                      : user.getCurrentRol,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Divider(
                  color: Color(0xff358aac),
                ),
                _MenuCard(
                  icon: Icons.person_rounded,
                  title: 'Mi perfil',
                  subtitle: 'Visualice o edite los datos de su cuenta',
                  onTap: () => Navigator.push(context, ProfileUser.route()),
                ),
                // if (user.applicationRol == ApplicationRol.fieldOwner)
                //   _MenuCard(
                //     icon: Icons.person_rounded,
                //     title: 'Calendario',
                //     subtitle: 'Visualice el calendario de partidos reservados',
                //     onTap: () => Navigator.push(context, SchedulePage.route()),
                //   ),
                if (user.applicationRol == ApplicationRol.player)
                  _MenuCard(
                    icon: Icons.sports_volleyball,
                    title: 'Ficha de jugador',
                    subtitle: 'Visualice o edite la ficha de jugador',
                    onTap: () =>
                        Navigator.push(context, PlayerProfilePage.route()),
                  ),
                if (user.applicationRol == ApplicationRol.referee)
                  _MenuCard(
                    icon: Icons.sports_volleyball,
                    title: 'Ficha de árbitro',
                    subtitle: 'Visualice o edite la ficha de árbitro',
                    onTap: () =>
                        Navigator.push(context, RefereeProfilePage.route()),
                  ),
                if (user.applicationRol == ApplicationRol.referee)
                  _MenuCard(
                    icon: Icons.calendar_month,
                    title: 'Ver calendario',
                    subtitle: 'Calendario de partidos por arbitrar',
                    onTap: () =>
                        Navigator.push(context, RefereeCalendarPage.route()),
                  ),
                if (user.applicationRol == ApplicationRol.referee)
                  _MenuCard(
                    icon: Icons.newspaper,
                    title: 'Ver historial de reportes',
                    subtitle: 'Visualice el historial de reportes arbitrales',
                    onTap: () =>
                        Navigator.push(context, ReportHistoryPage.route()),
                  ),
                if (user.applicationRol == ApplicationRol.teamManager)
                  _MenuCard(
                    icon: Icons.shield,
                    title: 'Mis equipos',
                    subtitle: 'Ver los equipos creados.',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, RepresentativeTeamsPage.route());
                    },
                  ),
                _MenuCard(
                  icon: Icons.file_copy,
                  title: 'Información legal',
                  subtitle: 'Consulta la información legal sobre ligas fútbol',
                  onTap: () => launchUrl(_url),
                ),
                _MenuCard(
                  icon: Icons.help,
                  title: 'Ayuda',
                  subtitle: '¿Necesita ayuda con la aplicación?',
                  onTap: () {},
                ),
                const Divider(color: Color(0xff358aac)),
              ],
            )
          ],
        ),
        const Divider(),
        Positioned(
          bottom: 10.0,
          left: 0.0,
          right: 0.0,
          child: InkWell(
            child: Container(
                padding: const EdgeInsets.only(bottom: 5),
                height: 45.0,
                color: Colors.red[800],
                child: Center(
                  child: Text("Cerrar sesión",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: Colors.grey[200])),
                )),
            onTap: () {
              Navigator.pop(context);
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested());
            },
          ),
        ),
      ],
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String subtitle;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListTile(
        leading: CircleAvatar(
          radius: 15,
          backgroundColor: const Color(0xff358aac),
          child: Icon(
            icon,
            color: Colors.grey[200],
            size: 19,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 18,
        ),
        title: Text(title, style: const TextStyle(fontSize: 14)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        onTap: onTap,
      ),
    );
  }
}
