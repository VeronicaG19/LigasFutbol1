import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/home/tournaments/table_tournaments_lm.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/tournaments/lm_tournament_v1/create_tournaments/create_tournament_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../service_locator/injection.dart';
import '../../../app/app.dart';
import '../../../player/user_menu/widget/help_menu_button.dart';
import '../../../player/user_menu/widget/tutorial_widget.dart';
import '../widget/Staticts_League_Manager.dart';
import '../widget/cubit/staticts_lm_cubit.dart';
import 'cubit/tournament_lm_cubit.dart';

class TournamentLeagueManegerPage extends StatelessWidget {
  const TournamentLeagueManegerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => locator<StatictsLmCubit>()
              ..loadStaticts(leagueId: leagueManager.leagueId),
          ),
          BlocProvider(
              create: (_) => locator<TournamentLmCubit>()
                ..loadTournament(leagueId: leagueManager.leagueId))
        ],
        child: ListView(children: [
          Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const HelpMeButton(
                  iconData: Icons.help,
                  tuto: TutorialType.ligueAdminMain,
                ),
                BlocBuilder<StatictsLmCubit, StatictsLmState>(
                    //listener: (context, state) {},
                    builder: (context, state) {
                  if (state.screenStatus == ScreenStatusA.loading) {
                    return Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: const Color(0xff358aac),
                        size: 50,
                      ),
                    );
                  } else {
                    if (state.detailCategory.coundt1 != 0) {
                      return TextButton(
                        //onPressed: () => Navigator.pop(dialogContext),
                        onPressed: () {
                          /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(

                                    value: BlocProvider.of<TournamentLmCubit>(
                                        context),
                                    child: CreateTournamentPage(fromPage:1),
                                  ),
                                ),
                              );*/
                          //
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => MultiBlocProvider(
                                        providers: [
                                          BlocProvider.value(
                                            value: BlocProvider.of<
                                                TournamentLmCubit>(context),
                                          ),
                                          BlocProvider.value(
                                              value: BlocProvider.of<
                                                  StatictsLmCubit>(context))
                                        ],
                                        child:
                                            CreateTournamentPage(fromPage: 1),
                                      )));
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                          decoration: const BoxDecoration(
                            color: Color(0xff0791a3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          height: 35,
                          width: 150,
                          child: Text(
                            'Crear torneo',
                            style: TextStyle(
                              fontFamily: 'SF Pro',
                              color: Colors.grey[200],
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    } else {
                      return TextButton(
                        //onPressed: () => Navigator.pop(dialogContext),
                        onPressed: () {},
                        child: Container(
                          padding:
                              const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                          decoration: const BoxDecoration(
                            color: Color(0xffcfedee),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          height: 35,
                          width: 150,
                          child: const Text(
                            'No hay categorias',
                            style: TextStyle(
                              fontFamily: 'SF Pro',
                              color: Colors.black45,
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                  }
                }),
                //const CreateRequestPage()
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: StatictsLeagueManager(),
            ),
            Column(children: <Widget>[
              //StatictsLeagueManager(),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: const Color(0xff0791a3),
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Torneo",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Categoría",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Número de equipos",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Fecha de inicio",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Estado",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Visibilidad",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ]),
          const TableTournamentLm(),
        ]));
  }
}
