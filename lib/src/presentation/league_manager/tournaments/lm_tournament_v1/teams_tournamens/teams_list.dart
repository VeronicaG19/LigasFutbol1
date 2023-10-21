import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/entity/tournament.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/teams/widgets/card_team.dart';
import 'package:ligas_futbol_flutter/src/presentation/splash/responsive_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../lm_tournament_v2/main_page/cubit/tournament_main_cubit.dart';
import '../teams_by_tournament/cubit/teams_cubit.dart';
import 'asing_team_on_tournament.dart';
import 'delete_team_tournamnet.dart';

class TeamListPage extends StatelessWidget {
  final Tournament tournament;

  const TeamListPage({super.key, required this.tournament});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TournamentMainCubit, TournamentMainState>(
      listenWhen: (previous, current) =>
          previous.selectedTournament != current.selectedTournament,
      listener: (context, state) {
        if (state.selectedMenu == 1) {
          context.read<TeamsLMCubit>().getTournamentTeamDataBytournament(
                tournament: state.selectedTournament,
              );
        }
      },
      child: BlocBuilder<TeamsLMCubit, TeamsLMState>(
        builder: (context, state) {
          if (state.screenStatus == ScreenStatus.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.blue[800]!,
                size: 50,
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: _AddTeamButton(),
                    ),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount:
                        (ResponsiveWidget.isSmallScreen(context)) ? 3 : 8, //5,
                    padding: const EdgeInsets.only(
                        top: 20, left: 8, right: 8, bottom: 20),
                    children: List.generate(
                      state.teamsTournamentDto.length,
                      (int index) {
                        return TeamCard(
                          teamName: state.teamsTournamentDto[index].teamName ??
                              'Nombre no disponible',
                          categoryName:
                              state.teamsTournamentDto[index].category ??
                                  'Sin categoria',
                          representanName:
                              state.teamsTournamentDto[index].representant ??
                                  'Sin representante',
                          imageTeam:
                              state.teamsTournamentDto[index].teamLogo ?? '',
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return BlocProvider.value(
                                  value: BlocProvider.of<TeamsLMCubit>(context),
                                  child: DeleteTeamTournamentModal(
                                    teamTournament:
                                        state.teamsTournamentDto[index],
                                    tournament: tournament,
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class _AddTeamButton extends StatelessWidget {
  const _AddTeamButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tournament =
        context.select((TeamsLMCubit bloc) => bloc.state.tournament);
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.green),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) {
            return BlocProvider<TeamsLMCubit>.value(
                value: BlocProvider.of<TeamsLMCubit>(context)
                  ..getTeamsTosuscribeTournament(),
                child: AssingTeamOnTournament(tournament: tournament));
          },
        );
      },
      icon: const Icon(
        Icons.add_circle,
        size: 24.0,
      ),
      label: const Text(
        'Agregar equipo',
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}
