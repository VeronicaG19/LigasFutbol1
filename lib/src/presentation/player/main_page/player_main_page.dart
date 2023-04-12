import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../service_locator/injection.dart';
import '../../app/bloc/authentication_bloc.dart';
import '../../widgets/button_share/button_share_widget.dart';
import '../../widgets/notification_icon/cubit/notification_count_cubit.dart';
import '../../widgets/notification_icon/view/notification_icon.dart';
import '../search_teams/search_team_page.dart';
import '../soccer_team/team/teams_page.dart';
import '../user_menu/user_menu.dart';

class PlayerMainPage extends StatefulWidget {
  const PlayerMainPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: PlayerMainPage());

  @override
  State<PlayerMainPage> createState() => _PlayerMainPageState();
}

class _PlayerMainPageState extends State<PlayerMainPage> {
  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        drawer: Drawer(
          backgroundColor: Colors.grey[200],
          child: const UserMenu(),
        ),
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          title: Text(
            'Ligas Fútbol',
            style: TextStyle(
                color: Colors.grey[200],
                fontSize: 25,
                fontWeight: FontWeight.w900),
          ),
          flexibleSpace: const Image(
            image: AssetImage('assets/images/imageAppBar25.png'),
            fit: BoxFit.cover,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 5.0),
              child: BlocProvider(
                create: (contextC) => locator<NotificationCountCubit>()
                  ..onLoadNotificationCount(
                      user.person.personId, user.applicationRol),
                child: NotificationIcon(
                  applicationRol: user.applicationRol,
                ),
              ),
            ),
            const ButtonShareWidget(),
          ],
          elevation: 0.0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(90),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: Colors.white70,
                    indicatorWeight: 1.0,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white38),
                    tabs: [
                      Tab(
                        height: 25,
                        iconMargin: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: Colors.white70, width: 1.5)),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Mis equipos",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        height: 25,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(color: Colors.white70, width: 1.5),
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Buscar equipos",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              children: [
                //  ManageMembersPage(),
                const TeamPage(type: ScreenType.mainPage),
                Container(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, bottom: 10, top: 20),
                  color: Colors.grey[200],
                  child: const SearchTeamPage(),
                ),

                //   NotificationPage(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
