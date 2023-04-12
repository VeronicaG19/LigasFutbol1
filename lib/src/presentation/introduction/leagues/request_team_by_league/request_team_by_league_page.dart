import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/domain/category/entity/category.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/entity/tournament.dart';
import 'package:ligas_futbol_flutter/src/presentation/introduction/leagues/request_team_by_league/cubit/request_team_by_league_cubit.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../login/view/login_page.dart';

class RequestTeamByLeaguePage extends StatefulWidget {
  RequestTeamByLeaguePage(
      {Key? key, required this.tournament, required this.category})
      : super(key: key);
  final Tournament tournament;
  final Category category;
  @override
  _RequestTeamByLeaguePageState createState() =>
      _RequestTeamByLeaguePageState();
}

class _RequestTeamByLeaguePageState extends State<RequestTeamByLeaguePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<RequestTeamByLeagueCubit>()
        ..getRequestTeamByLeague(
            leagueId: widget.tournament.leagueId!.leagueId),
      child: BlocBuilder<RequestTeamByLeagueCubit, RequestTeamByLeagueState>(
        builder: (context, state) {
          if (state.screenStatus == ScreenStatus.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: const Color(0xff358aac),
                size: 50,
              ),
            );
          } else {
            return ListView.builder(
                padding: const EdgeInsets.only(
                  top: 5,
                ),
                itemCount: state.teamList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Container(
                        color: Colors.black12,
                        height: 5,
                      ),
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const LoginPage())),
                        child: Container(
                          color: Colors.white38,
                          padding: const EdgeInsets.only(
                              right: 20, left: 12, top: 15, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(8.0),
                                    bottomRight: Radius.circular(8.0),
                                  ),
                                  child: Container(
                                    width: 6.0,
                                    height: 20.0,
                                    color: Color(0xff358aac),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${state.teamList[index].teamName}",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900),
                                ),
                              ]),
                              Container(
                                height: 45,
                                padding: EdgeInsets.all(8),
                                color: Color(0xff358aac),
                                child: Column(
                                  children: [
                                    Text(
                                      "Edad",
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey[200],
                                          fontWeight: FontWeight.w900),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      "18 - 50",
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey[200],
                                          fontWeight: FontWeight.w900),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.black12,
                        height: 5,
                      ),
                    ],
                  );
                  //     TablePage()
                });
          }
        },
      ),
    );
  }
}
