import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/view/matches_tab.dart';
import 'package:new_version_plus/new_version_plus.dart';

import '../../../core/constans.dart';
import '../../app/app.dart';
import '../../player/user_menu/user_menu.dart';
import '../../widgets/button_share/button_share_widget.dart';
import '../../widgets/notification_icon/view/notification_icon.dart';
import '../leagues/view/leagues_page.dart';
import '../statics/global_statics/view/statics_page.dart';

class RefereeMainPage extends StatelessWidget {
  const RefereeMainPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: RefereeMainPage());

  @override
  Widget build(BuildContext context) {
    return const _MainPageContent();
  }
}

class _MainPageContent extends StatefulWidget {
  const _MainPageContent({Key? key}) : super(key: key);

  @override
  State<_MainPageContent> createState() => _MainPageContentState();
}

class _MainPageContentState extends State<_MainPageContent> {
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
    const double tabSize = 50;
    return DefaultTabController(
      length: 3,
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
            //_ChangeLeagueOption(key: CoachKey.changeLigesKey),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 5.0),
              child: NotificationIcon(
                key: CoachKey.notificationKey,
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
                  key: CoachKey.matchesKey,
                  height: tabSize,
                  child: const _RefereeTab(
                    title: 'Partidos',
                    icon: Icons.lan,
                  ),
                ),
                Tab(
                  key: CoachKey.liguesReferee,
                  height: tabSize,
                  child: const _RefereeTab(
                    title: 'Ligas',
                    icon: Icons.groups,
                  ),
                ),
                Tab(
                  key: CoachKey.statiscReferee,
                  height: tabSize,
                  child: const _RefereeTab(
                    title: 'Estadísticas arbitrales',
                    icon: Icons.bar_chart,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            MatchesTab(),
            LeaguesPage(),
            StaticsPage(),
          ],
        ),
      ),
    );
  }
}

class _RefereeTab extends StatelessWidget {
  final String title;
  final IconData icon;

  const _RefereeTab({
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
