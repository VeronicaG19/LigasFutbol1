import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/tournaments/cubit/team_tournaments/team_tournaments_cubit.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ligas_futbol_flutter/src/presentation/splash/responsive_widget.dart';

import 'tournament_card.dart';

class TournamentList extends StatelessWidget {
  const TournamentList({Key? key, required this.teamId}) : super(key: key);

  final int teamId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          locator<TeamTournamentsCubit>()..getTeamTournaments(teamId: teamId),
      child: BlocBuilder<TeamTournamentsCubit, TeamTournamentsState>(
        builder: (context, state) {
          if (state.screenStatus == BasicCubitScreenState.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.blue[800]!,
                size: 50,
              ),
            );
          } else {
            return state.tournamentsList.isNotEmpty
                ? GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(
                  top: 75, left: 8, right: 8, bottom: 20.0),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent:
                ResponsiveWidget.getMaxCrossAxisExtent(context),
                childAspectRatio: 1.5 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
              ),
              itemCount: state.tournamentsList.length,
              itemBuilder: (context, index) =>
                  TournamentCard(
                    tournamentEntity: state.tournamentsList[index],
                  ),
            )
                : const Center(child: Text("Aún no participaste en algún torneo."));
          }
        },
      ),
    );
  }
}
