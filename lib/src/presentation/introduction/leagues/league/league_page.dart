import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/introduction/leagues/league/cubit/league_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/introduction/leagues/league/league_content.dart';
import 'package:ligas_futbol_flutter/src/presentation/introduction/leagues/league/tournaments_by_league_content.dart';
import 'package:ligas_futbol_flutter/src/presentation/splash/responsive_widget.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';

import '../../../splash/top_bar.dart';

class LeaguePage extends StatelessWidget {
  const LeaguePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isSmallScreen(context)) {
      return const _BodyMobile();
    } else {
      return const _BodyWeb();
    }
  }
}

class _BodyMobile extends StatelessWidget {
  const _BodyMobile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => locator<LeagueCubit>()..loadLeagues(),
        child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            const LeagueContent(),
            const SizedBox(
              height: 15,
            ),
            TournamentsByLeagueContent()
          ],
        ));
  }
}

class _BodyWeb extends StatelessWidget {
  const _BodyWeb({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocProvider(
        create: (_) => locator<LeagueCubit>()..loadLeagues(),
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(screenSize.width, 1000),
              child: TopBarContents(),
            ),
            body: Column(
              children: [
                Container(
                  width: 400,
                  child: const LeagueContent(),
                ),
                SizedBox(height: screenSize.height / 55),
                const Text(
                  "Torneos",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w900),
                ),
                Expanded(child: TournamentsByLeagueContent())
              ],
            )));
  }
}
