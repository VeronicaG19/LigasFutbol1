import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/tournaments/lm_tournament_v1/teams_tournamens/teams_list.dart';

import '../../../../../service_locator/injection.dart';
import '../../lm_tournament_v2/main_page/cubit/tournament_main_cubit.dart';
import '../teams_by_tournament/cubit/teams_cubit.dart';
import 'need_select_tournament_page.dart';

class TournamentsTeams extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentMainCubit, TournamentMainState>(
      builder: (context, state) {
        return (state.selectedTournament.isEmpty)
            ? const NeedSlctTournamentPage()
            : BlocProvider(
                create: (_) => locator<TeamsLMCubit>()
                  ..getTournamentTeamDataBytournament(
                      tournament: state.selectedTournament),
                child: Card(
                  color: Colors.grey[200],
                  child: TeamListPage(tournament: state.selectedTournament),
                ),
              );
      },
    );
  }
}
