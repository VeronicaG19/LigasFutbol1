import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/tournaments/lm_tournament_v1/clasification/clasification_main.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/tournaments/lm_tournament_v1/cubit/tournament_cubit.dart';

import '../../../../../service_locator/injection.dart';
import '../clasification/cubit/clasification_cubit.dart';
import 'need_select_tournament_page.dart';

class Clasification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentCubit, TournamentState>(
      builder: (context, state) {
        return (state.tournamentSelected.tournamentId == null)
            ? NeedSlctTournamentPage()
            : Card(
                color: Colors.grey[200],
                child: BlocProvider(
                  create: (_) => locator<ClasificationCubit>()
                    ..getScoringSystem(tournament: state.tournamentSelected),
                  child:
                      ClasificationMain(tournament: state.tournamentSelected),
                ));
      },
    );
  }
}
