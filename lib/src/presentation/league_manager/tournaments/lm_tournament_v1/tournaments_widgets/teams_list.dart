import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/entity/tournament.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/view/loading_screen.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/teams/widgets/card_team.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/tournaments/lm_tournament_v1/teams_by_tournament/cubit/teams_cubit.dart';

import '../../../../../service_locator/injection.dart';

class TeamListPage extends StatelessWidget {
  final Tournament tournament;
  const TeamListPage({super.key, required this.tournament});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => locator<TeamsLMCubit>()
          ..getTournamentTeamDataBytournament(tournament: tournament),
        child: BlocBuilder<TeamsLMCubit, TeamsLMState>(
          builder: (context, state) {
            if (state.screenStatus == ScreenStatus.loading) {
              return LoadingScreen();
            } else if (state.screenStatus == ScreenStatus.loaded ||
                state.screenStatus == ScreenStatus.teamsGetted ||
                state.screenStatus == ScreenStatus.teamsGetting) {
              return GridView.count(
                  crossAxisCount: 5,
                  padding: EdgeInsets.only(top: 20, left: 8, right: 8),
                  children: List.generate(
                    state.teamsTournament.length,
                    (int index) {
                      print('${state.teamsTournament.length}');
                      return TeamCard(
                        teamName: state.teamsTournamentDto[index].teamName!,
                        categoryName: state.teamsTournamentDto[index].category!,
                        representanName:
                            state.teamsTournamentDto[index].representant!,
                        imageTeam: state.teamsTournamentDto[index].teamLogo!,
                        onTap: () {},
                      );
                    },
                  ));
            } else {
              return Center(
                child: Text('Sin equipos registrados'),
              );
            }
          },
        ));
  }
}
