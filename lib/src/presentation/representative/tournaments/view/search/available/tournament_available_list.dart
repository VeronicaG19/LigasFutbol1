import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/tournaments/cubit/tournaments_available/tournaments_available_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/splash/responsive_widget.dart';
import 'tournament_available.dart';

class TournamentAvailableList extends StatelessWidget {
  TournamentAvailableList({super.key, required this.teamId});

  final int? teamId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentsAvailableCubit, TournamentsAvailableState>(
      builder: (context, state) {
        return GridView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(
              top: 150.0, right: 8.0, left: 8.0, bottom: 20.0),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: ResponsiveWidget.getMaxCrossAxisExtent(context),
            childAspectRatio: 1.2 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
          ),
          itemCount: state.tournamentsList.length,
          itemBuilder: (context, index) => TournamentAvailable(
            teamId: teamId,
            tournament: state.tournamentsList[index],
          ),
        );
      },
    );
  }
}
