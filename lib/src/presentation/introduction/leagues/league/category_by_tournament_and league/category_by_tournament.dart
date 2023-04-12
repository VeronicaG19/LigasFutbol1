import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/entity/tournament.dart';
import 'package:ligas_futbol_flutter/src/presentation/introduction/leagues/tab_bar_matches_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/splash/responsive_widget.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../splash/top_bar.dart';
import 'cubit/category_by_tournament_and_league_cubit.dart';

class CategoryByTournament extends StatefulWidget {
  const CategoryByTournament(this.tournament, this.leagueId) : super();
  final Tournament tournament;
  final int? leagueId;

  @override
  _CategoryByTournamentState createState() => _CategoryByTournamentState();
}

class _CategoryByTournamentState extends State<CategoryByTournament> {
  String? selectedValue2;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (_) => locator<CategoryByTournamentAndLeagueCubit>()
        ..getCategoryByTournamentByAndLeagueId(
            tournamentName: widget.tournament.tournamentName!,
            legueId: widget.leagueId!),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: ResponsiveWidget.isSmallScreen(context)
            ? PreferredSize(
                preferredSize: const Size.fromHeight(110),
                child: AppBar(
                  title: const Text("Categorías",
                      style: TextStyle(fontWeight: FontWeight.w900)),
                  flexibleSpace: const Image(
                    image: AssetImage('assets/images/imageAppBar.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              )
            : PreferredSize(
                preferredSize: Size(screenSize.width, 1000),
                child: TopBarContents(),
              ),
        body: BlocBuilder<CategoryByTournamentAndLeagueCubit,
            CategoryByTournamentAndLeagueState>(
          builder: (context, state) {
            if (state.screenStatus == ScreenStatus.loading) {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: const Color(0xff358aac),
                  size: 50,
                ),
              );
            } else {
              return state.categoryList.isEmpty
                  ? Container()
                  : GridView.builder(
                      padding: EdgeInsets.only(top: 15, left: 8, right: 8),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 180,
                              childAspectRatio: 3.5 / 2,
                              crossAxisSpacing: 30,
                              mainAxisSpacing: 35),
                      itemCount: state.categoryList.length,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 32,
                                  backgroundColor: Color(0xff358aac),
                                  child: Image(
                                    image: const AssetImage(
                                        'assets/images/categoria2.png'),
                                    height: 45,
                                    width: 45,
                                    color: Colors.grey[300],
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                Text(
                                  state.categoryList[index].categoryName!,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                          ),
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TabBarMatchesPage(
                                    tournament: widget.tournament,
                                    categoryInfo: state.categoryList[index]),
                              ),
                            );
                          },
                        );
                      });
            }
          },
        ),
      ),
    );
  }
}
