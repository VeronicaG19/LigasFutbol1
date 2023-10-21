import 'package:flutter/material.dart';

import '../../player/user_menu/user_menu.dart';
import '../../widgets/button_share/button_share_widget.dart';
import '../requests/cancel_league_c.dart';
import '../requests/request_field_owner.dart';
import '../requests/request_page.dart';

class SuperAdminMainPage extends StatelessWidget {
  const SuperAdminMainPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: SuperAdminMainPage());
  @override
  Widget build(BuildContext context) {
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
            const ButtonShareWidget(),
          ],
          elevation: 0.0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: TabBar(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: Colors.white70,
              indicatorWeight: 1.0,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white38),
              tabs: [
                // Tab(
                //   height: 25,
                //   iconMargin: const EdgeInsets.all(5),
                //   child: Container(
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(20),
                //         border: Border.all(color: Colors.white70, width: 1.5)),
                //     child: const Align(
                //       alignment: Alignment.center,
                //       child: Text(
                //         'Todos mis partidos',
                //         textAlign: TextAlign.center,
                //         style: TextStyle(fontSize: 10),
                //       ),
                //     ),
                //   ),
                // ),
                Tab(
                  height: 25,
                  iconMargin: const EdgeInsets.all(5),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white70, width: 1.5)),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Solicitudes de ligas',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),
                Tab(
                  height: 25,
                  iconMargin: const EdgeInsets.all(5),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white70, width: 1.5)),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Solicitudes de dueño de cancha',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),
                Tab(
                  height: 25,
                  iconMargin: const EdgeInsets.all(5),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white70, width: 1.5)),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Eliminación de ligas',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            RequestPage(),
            RequestFieldsPage(),
            const CancelLeagueRequest(),
          ],
        ),
      ),
    );
  }
}
