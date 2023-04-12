import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../service_locator/injection.dart';
import '../../app/app.dart';
import '../../player/user_menu/user_menu.dart';
import '../../widgets/button_share/button_share_widget.dart';
import '../../widgets/notification_icon/cubit/notification_count_cubit.dart';
import '../../widgets/notification_icon/view/notification_icon.dart';
import '../manage_team/view/manage_team_page.dart';
import '../team_matches/view/team_matches_page.dart';
import '../tournaments/view/tournaments_page.dart';

class RepresentativeMainPage extends StatelessWidget {
  const RepresentativeMainPage({
    Key? key,
  }) : super(key: key);

  static Page page() =>
      const MaterialPage<void>(child: RepresentativeMainPage());

  static Route route() =>
      MaterialPageRoute(builder: (_) => const RepresentativeMainPage());

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    // final teamIdDefault = context
    //     .select((AuthenticationBloc bloc) => bloc.state.teamManager.teamId);
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
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              buildWhen: (previous, current) =>
                  previous.teamManager != current.teamManager,
              builder: (context, state) {
                if (state.teamManager.teamId == -1) {
                  return const SizedBox();
                }
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 5.0),
                  child: BlocProvider(
                    create: (contextC) => locator<NotificationCountCubit>()
                      ..onLoadNotificationCount(
                          state.teamManager.teamId ?? 0, user.applicationRol),
                    child: NotificationIcon(
                      applicationRol: user.applicationRol,
                    ),
                  ),
                );
              },
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
                              "Administrar equipo",
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
                              "Partidos",
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
                              "Torneos",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          buildWhen: (previous, current) =>
              previous.teamManager != current.teamManager,
          builder: (context, state) {
            if (state.teamManager.teamId == -1) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return TabBarView(
              children: [
                ManageTeamPage(teamId: state.teamManager.teamId),
                TeamMatchesPage(teamId: state.teamManager.teamId),
                TournamentsPage(teamId: state.teamManager.teamId),
              ],
            );
          },
        ),
      ),
    );
  }
}
