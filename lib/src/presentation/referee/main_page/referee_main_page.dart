import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/view/matches_tab.dart';

import '../../../domain/leagues/entity/league.dart';
import '../../../service_locator/injection.dart';
import '../../app/app.dart';
import '../../player/user_menu/user_menu.dart';
import '../../widgets/button_share/button_share_widget.dart';
import '../../widgets/notification_icon/cubit/notification_count_cubit.dart';
import '../../widgets/notification_icon/view/notification_icon.dart';
import '../leagues/view/leagues_page.dart';
import '../statics/view/statics_page.dart';

class RefereeMainPage extends StatelessWidget {
  const RefereeMainPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: RefereeMainPage());

  @override
  Widget build(BuildContext context) {
    final refereeId = context
        .select((AuthenticationBloc bloc) => bloc.state.refereeData.refereeId);
    final rol = context
        .select((AuthenticationBloc bloc) => bloc.state.user.applicationRol);
    return BlocProvider(
      create: (_) => locator<NotificationCountCubit>()
        ..onLoadNotificationCount(refereeId, rol),
      child: const _MainPageContent(),
    );
  }
}

class _MainPageContent extends StatelessWidget {
  const _MainPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
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
                fontSize: 23,
                fontWeight: FontWeight.w900),
          ),
          flexibleSpace: const Image(
            image: AssetImage('assets/images/imageAppBar25.png'),
            fit: BoxFit.cover,
          ),
          actions: [
            const _ChangeLeagueOption(),
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
            preferredSize: const Size.fromHeight(50),
            child: TabBar(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: Colors.white70,
              indicatorWeight: 2.0,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white38),
              tabs: [
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
                        'Partidos',
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
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white70, width: 1.5),
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Ligas',
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
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white70, width: 1.5),
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Estadísticas arbitrales',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
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

class _ChangeLeagueOption extends StatefulWidget {
  const _ChangeLeagueOption({Key? key}) : super(key: key);

  @override
  State<_ChangeLeagueOption> createState() => _ChangeLeagueOptionState();
}

class _ChangeLeagueOptionState extends State<_ChangeLeagueOption> {
  League league = League.empty;

  @override
  Widget build(BuildContext context) {
    final leagues =
        context.select((AuthenticationBloc bloc) => bloc.state.refereeLeagues);
    league = leagues.isNotEmpty ? leagues.first : League.empty;
    final items = List.generate(
      leagues.length,
      (index) => PopupMenuItem<League>(
        value: leagues[index],
        child: Text(leagues[index].leagueName),
      ),
    );

    return PopupMenuButton<League>(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      icon: const Icon(Icons.sync_alt, size: 20),
      onSelected: (option) {
        setState(() {
          league = option;
        });
        context
            .read<AuthenticationBloc>()
            .add(ChangeRefereeLeagueEvent(option));
      },
      itemBuilder: (context) => items,
      initialValue: league,
      tooltip: 'Cambiar de liga',
    );
  }
}
