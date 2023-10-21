import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/core/constans.dart';
import 'package:ligas_futbol_flutter/src/presentation/widgets/only_mobile_app/button_alert_only_web.dart';
import 'package:new_version_plus/new_version_plus.dart';
import '../../app/bloc/authentication_bloc.dart';
import '../../widgets/button_share/button_share_widget.dart';
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
  void initState(){

    final newvVersion = NewVersionPlus(
      iOSId: 'dev.ias.swat.ccs.com.Wiplif',
      androidId: 'com.ccs.swat.iaas.spr.ligas_futbol.ligas_futbol_flutter'
    );

    Timer(const Duration(milliseconds: 800),(){
      checkNewVersion(newvVersion);

    });

    super.initState();
  }

  void checkNewVersion(NewVersionPlus newVersion ) async{
    final status = await newVersion.getVersionStatus();
      if(status != null) {
        if (status.canUpdate) {
          newVersion.showUpdateDialog(
            context: context, 
            versionStatus: status,
            dialogText: 'Nueva version disponible en la tienda (${status.storeVersion}), Actualiza ahora',
            dialogTitle: 'Actualización disponible',

            );
        }
      }
  }
  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    final playerInfo = context
        .select((AuthenticationBloc bloc) => bloc.state.playerData.playerid);
    const double tabSize = 50;

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
            const ButtonAlertOnlyWeb(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 5.0),
              child: NotificationIcon(
                applicationRol: user.applicationRol,
              ),
            ),
            const ButtonShareWidget(),
          ],
          elevation: 0.0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: TabBar(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: Colors.white70,
              indicatorWeight: 2.0,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white38,
              ),
              tabs: [
                Tab(
                  key: CoachKey.myTeamsPlayer,
                  height: tabSize,
                  child: const _PlayerTab(
                    title: "Mis equipos",
                    icon: Icons.groups_rounded,
                  ),
                ),
                Tab(
                  key: CoachKey.searchTeamsPlayer,
                  height: tabSize,
                  child: const _PlayerTab(
                    title: "Buscar equipos",
                    icon: Icons.content_paste_search,
                  ),
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
                TeamPage(type: ScreenType.mainPage, playerId: playerInfo ?? 0),
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

class _PlayerTab extends StatelessWidget {
  final String title;
  final IconData icon;

  const _PlayerTab({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white70,
          width: 1.5,
        ),
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10),
            ),
            Icon(icon)
          ],
        ),
      ),
    );
  }
}
