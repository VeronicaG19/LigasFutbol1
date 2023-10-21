import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/bloc/authentication_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/category/category_lm/detail/category_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/home/home.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/teams/lm_teams_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/profile/profile_page.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constans.dart';
import '../../../domain/leagues/entity/league.dart';
import '../../widgets/notification_icon/view/notification_icon.dart';
import '../tournaments/lm_tournament_v2/main_page/view/lm_tournament_page.dart';

class LeagueManagerMainPage extends StatefulWidget {
  const LeagueManagerMainPage({Key? key}) : super(key: key);

  static Page page() =>
      const MaterialPage<void>(child: LeagueManagerMainPage());

  @override
  State<LeagueManagerMainPage> createState() => _LeagueManagerMainPageState();
}

class _LeagueManagerMainPageState extends State<LeagueManagerMainPage> {
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
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
    final List<String> items = [
      'Mi liga',
      'Cerrar sesión',
    ];
    String? selectedValue;
    return DefaultTabController(
      length: 5,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(top: 25),
            child: ListTile(
                leading: Image(
                  image: AssetImage('assets/images/soccer_logo_SaaS.png'),
                ),
                title: Row(
                  children: [
                    Text(
                      'Ligas Futbol',
                      style: TextStyle(
                          color: Colors.grey[200],
                          fontSize: 28,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                )),
          ),
          backgroundColor: Colors.grey[200],
          flexibleSpace: Image(
            image: AssetImage('assets/images/imageAppBar25.png'),
            fit: BoxFit.fitWidth,
          ),
          /*Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xff06748b), Color(0xff078995), Color(0xff058299)],
          ))),*/
          actions: [
            const _ChangeLeagueOption(),
            // TextButton(
            //   onPressed: () async {},
            //   child: Container(
            //       height: 50,
            //       padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
            //       decoration: const BoxDecoration(
            //         borderRadius: BorderRadius.all(Radius.circular(15.0)),
            //       ),
            //       child: Row(
            //         children: [
            //           Icon(
            //             Icons.beenhere,
            //             size: 15,
            //             color: Colors.grey[200],
            //           ),
            //           const SizedBox(
            //             width: 10,
            //           ),
            //           Text(
            //             'Liga: ${leagueManager.leagueName}',
            //             style: TextStyle(
            //               fontFamily: 'SF Pro',
            //               color: Colors.grey[200],
            //               fontWeight: FontWeight.w500,
            //               fontSize: 12.0,
            //             ),
            //           ),
            //         ],
            //       )),
            // ),
            NotificationIcon(
              key: CoachKey.notificationAdKey,
              applicationRol: user.applicationRol,
            ),
            TextButton(
              child: Row(
                children: [
                  Icon(
                    Icons.share,
                    size: 15,
                    color: Colors.grey[200],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Compartir',
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      color: Colors.grey[200],
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
              onPressed: () async {
                final box = context.findRenderObject() as RenderBox?;
                await Share.share(
                    '¡Ven y regístrate a Ligas fútbol!\n'
                    'Vive la experiencia como jugador, árbitro, etc, con una proyección profesional.'
                    ' En ligas fútbol tenemos las mejores ligas de la zona, no te quedes'
                    ' afuera y vive la experiencia.\n\n'
                    '¡Regístrate 𝐆𝐑𝐀𝐓𝐈𝐒 ahora!',
                    subject: '¡Regístrate 𝐆𝐑𝐀𝐓𝐈𝐒 ahora!',
                    sharePositionOrigin:
                        box!.localToGlobal(Offset.zero) & box.size);
              },
            ),
            TextButton(
              onPressed: () async {},
              child: Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.mediation,
                        size: 15,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Rol: Presidente de liga',
                        style: TextStyle(
                          fontFamily: 'SF Pro',
                          color: Colors.grey[200],
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  )),
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                hint: Text(
                  'Usuario: ${user.person.getFullName}',
                  style: TextStyle(
                    fontFamily: 'SF Pro',
                    color: Colors.grey[200],
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                  ),
                ),
                items: items
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ))
                    .toList(),
                value: selectedValue,
                onChanged: (value) {
                  if (value != 'Mi liga') {
                    setState(() {
                      selectedValue = value as String;
                    });
                    print("valor $value");
                    if (value == "Cerrar sesión") Navigator.pop(context);
                    context
                        .read<AuthenticationBloc>()
                        .add(AuthenticationLogoutRequested());
                  }
                },
                buttonHeight: 40,
                buttonWidth: 250,
                icon: Icon(
                  Icons.play_for_work,
                  color: Colors.grey[200],
                  size: 22,
                ),
                itemHeight: 40,
              ),
            ),
            const SizedBox(
              width: 20,
            )
          ],
          elevation: 0.0,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /*  Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.sports_baseball,
                              color: Colors.grey[200], size: 33),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                'Ligas Futbol',
                                style: TextStyle(
                                    color: Colors.grey[200],
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          )
                        ],
                      ),
                      ListTile(
                        title: Text(
                          'Ligas Mexico',
                          style: TextStyle(
                              color: Colors.grey[200],
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),*/
                  Align(
                    alignment: Alignment.center,
                    child: TabBar(
                        indicatorSize: TabBarIndicatorSize.label,
                        unselectedLabelColor: Colors.white70,
                        indicatorWeight: 1.0,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white30),
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
                                child: Text("Inicio",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ),
                          ),
                          Tab(
                            key: CoachKey.catMainPageLeageAdm,
                            height: 25,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.white70, width: 1.5)),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text("Categorias",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ),
                          ),
                          Tab(
                            key: CoachKey.teamMainPageLeageAdm,
                            height: 25,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.white70, width: 1.5)),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text("Equipos",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ),
                          ),
                          Tab(
                            key: CoachKey.tournamentMainPageLeageAdm,
                            height: 25,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.white70, width: 1.5)),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text("Torneos",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ),
                          ),
                          Tab(
                            height: 25,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.white70, width: 1.5)),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text("Mi perfil",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              )),
        ),
        body: const TabBarView(
          children: [
            Home(),
            CategoryLeagueManagerPage(),
            LMTeamPage(),
            TournamentPage(),
            //TournamenMainPage(),
            ProfileUser(),
            //  LMRequests(),
          ],
        ),
      ),
    );
  }
}

class _ChangeLeagueOption extends StatelessWidget {
  const _ChangeLeagueOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leagues =
        context.select((AuthenticationBloc bloc) => bloc.state.managerLeagues);
    final items = List.generate(
      leagues.length,
      (index) => PopupMenuItem<League>(
        value: leagues[index],
        child: Text(leagues[index].leagueName),
      ),
    );

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: PopupMenuButton<League>(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            onSelected: (option) {
              context
                  .read<AuthenticationBloc>()
                  .add(ChangeSelectedLeague(option));
            },
            itemBuilder: (context) => items,
            initialValue: state.selectedLeague,
            tooltip: 'Cambiar de liga',
            child: Row(
              children: [
                Icon(
                  Icons.beenhere,
                  size: 15,
                  color: Colors.grey[200],
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Liga: ${state.selectedLeague.leagueName}',
                  style: TextStyle(
                    fontFamily: 'SF Pro',
                    color: Colors.grey[200],
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(Icons.arrow_drop_down, size: 30),
              ],
            ),
          ),
        );
      },
    );
  }
}
