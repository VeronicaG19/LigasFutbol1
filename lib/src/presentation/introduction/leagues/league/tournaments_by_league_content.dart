import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/introduction/leagues/league/category_by_tournament_and%20league/category_by_tournament.dart';
import 'package:ligas_futbol_flutter/src/presentation/introduction/leagues/league/cubit/league_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../splash/responsive_widget.dart';

class TournamentsByLeagueContent extends StatefulWidget {
  @override
  State<TournamentsByLeagueContent> createState() =>
      _TournamentsByLeagueContentState();
}

class _TournamentsByLeagueContentState
    extends State<TournamentsByLeagueContent> {
  @override
  Widget build(BuildContext context) {
    if(ResponsiveWidget.isSmallScreen(context)) {
      return _TournamentBodyMobile();
    } else {
      return _TournamentBodyWeb();
    }
  }
}

class _TournamentBodyMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeagueCubit, LeagueState>(
      builder: (context, state) {
        if (state.screenStatus == ScreenStatus.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: const Color(0xff358aac),
              size: 50,
            ),
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Torneos",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  itemCount: state.tournamentList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(
                              state.tournamentList[index].tournamentName
                                  .toString(),
                              style: TextStyle(fontSize: 14)),
                          onTap: () {
                            (state.tournamentList[index].leagueId == null)
                                ? Container()
                                : Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CategoryByTournament(
                                      state.tournamentList[index],
                                      state.tournamentList[index].leagueId!
                                          .leagueId,
                                    ),
                              ),
                            );
                          },
                          leading: const Icon(Icons.workspaces_filled,
                              color: Color(0xff358aac), size: 18),
                          trailing:
                          (state.tournamentList[index].leagueId == null)
                              ? Text("Sin categorias",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xff358aac)))
                              : Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: Colors.blueGrey,
                          ),
                        ),
                        const Divider(
                          height: 5.0,
                        ),
                      ],
                    );
                    //     TablePage()
                  })
            ],
          );
        }
      },
    );
  }
}

class _TournamentBodyWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeagueCubit, LeagueState>(
      builder: (context, state) {
        if (state.screenStatus == ScreenStatus.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: const Color(0xff358aac),
              size: 50,
            ),
          );
        } else {
          return GridView.builder(
              padding: EdgeInsets.only(top: 15, left: 8, right: 8),
              gridDelegate:
              const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3.5 / 2,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 35),
              itemCount: state.tournamentList.length,
              itemBuilder: (BuildContext ctx, index) {
                return InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          offset: const Offset(0, 20),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                         CircleAvatar(
                          radius: 28,
                          backgroundColor: Color(0xff358aac),
                          child: Icon(
                            Icons.emoji_events,
                            size: 35.0,
                            color: Colors.grey[300],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          state.tournamentList[index].tournamentName.toString(),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    (state.tournamentList[index].leagueId == null)
                        ? Container()
                        : Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CategoryByTournament(
                              state.tournamentList[index],
                              state.tournamentList[index].leagueId!
                                  .leagueId,
                            ),
                      ),
                    );
                  },
                );
              });
        }
      },
    );
  }
}