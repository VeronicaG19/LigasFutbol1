import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/domain/team_tournament/entity/team_tournament.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/config_league/config_league_interface_dto.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/tournaments/lm_tournament_v2/main_page/cubit/tournament_main_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../lm_tournament_v1/match_l_roles/match_l_roles_main.dart';
import '../../../../../lm_tournament_v1/qualifying_rounds/rounds_configuration/view/rounds_configuration_page.dart';

class LeagueOption extends StatelessWidget {
  const LeagueOption({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TournamentMainCubit, TournamentMainState>(
      listener: (context, state) {
        if (state.screenState == LMTournamentScreen.createdConfiguration) {
          context.read<TournamentMainCubit>().getConfigLeague(
              tournamentId: state.selectedTournament.tournamentId!);
        }
      },
      builder: (context, state) {
        if (state.screenState == LMTournamentScreen.loadingTournamentStatus) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: Colors.blue[800]!,
              size: 50,
            ),
          );
        }

        if (state.statusTournament == 'true' ||
            state.configLeagueInterfaceDTO != ConfigLeagueInterfaceDTO.empty) {
          return SizedBox(
            height: 500,
            child: (state.configLeagueInterfaceDTO ==
                    ConfigLeagueInterfaceDTO.empty)
                ? const _LeagueConfigurationButton()
                : const _BodyContent(),
          );
        } else if (state.statusTournament == 'false' &&
            state.configLeagueInterfaceDTO != ConfigLeagueInterfaceDTO.empty) {
          return const _BodyContent();
        } else {
          return const _NeedFinishTournament();
        }
      },
    );
  }
}

class _NeedFinishTournament extends StatelessWidget {
  const _NeedFinishTournament({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          SizedBox(
            width: 15,
          ),
          Icon(Icons.warning_rounded, color: Colors.deepOrange, size: 230),
          SizedBox(
            width: 15,
          ),
          Text(
            'El torneo debe finalizar.',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}

class _LeagueConfigurationButton extends StatelessWidget {
  const _LeagueConfigurationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TournamentMainCubit, TournamentMainState>(
      listener: (context, state) {},
      builder: (context, state) {
        return TextButton(
          onPressed: () {
            context.read<TournamentMainCubit>().getTeamsTournament(
                tournamentId: state.selectedTournament.tournamentId!);
            showDialog(
                context: context,
                builder: (_) {
                  //final exampleCubit = context.read<ClasificationCubit>();
                  return BlocProvider<TournamentMainCubit>.value(
                      value: BlocProvider.of<TournamentMainCubit>(context),
                      child: const RoundsConfigurationPage());
                });
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
            decoration: const BoxDecoration(
              color: Color(0xff0791a3),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            height: 35,
            width: 150,
            child: Text(
              'Configuración de liguilla',
              style: TextStyle(
                fontFamily: 'SF Pro',
                color: Colors.grey[200],
                fontWeight: FontWeight.w500,
                fontSize: 13.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}

class _BodyContent extends StatelessWidget {
  const _BodyContent({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
        },
      ),
      child: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(flex: 1, child: _DetailConfig()),
            Expanded(flex: 2, child: _QualifiedTeams()),
          ],
        ),
      ),
    );
  }
}

class _DetailConfig extends StatelessWidget {
  const _DetailConfig({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentMainCubit, TournamentMainState>(
      builder: (context, state) {
        if (state.screenState == LMTournamentScreen.loadingConfigLeague) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: Colors.blue[800]!,
              size: 50,
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                  left: 40,
                  right: 40,
                ),
                child: Column(
                  children: [
                    const Text(
                      'Encuentros en liguillas',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    _LeagueConfigDetailRow(
                      title: 'Rondas en liguilla : ',
                      data: '${state.configLeagueInterfaceDTO.ronda}',
                    ),
                    _LeagueConfigDetailRow(
                      title: 'Partidos por eliminatoria : ',
                      data: '${state.configLeagueInterfaceDTO.roundTrip}',
                    ),
                    _LeagueConfigDetailRow(
                      title: 'Partidos en la final : ',
                      data: '${state.configLeagueInterfaceDTO.matchFinal}',
                    ),
                    _LeagueConfigDetailRow(
                      title: 'Desempatar por : ',
                      data: '${state.configLeagueInterfaceDTO.tieBreakType}',
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class _LeagueConfigDetailRow extends StatelessWidget {
  final String title;
  final String data;

  const _LeagueConfigDetailRow({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Text(
          data,
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}

class _QualifiedTeams extends StatelessWidget {
  const _QualifiedTeams({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                const Expanded(flex: 1, child: Text('')),
                const Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      'Equipos calificados',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: BlocBuilder<TournamentMainCubit, TournamentMainState>(
                    builder: (context, state) {
                      if (state.statusTournament == 'true') {
                        return Center(
                          child: IconButton(
                            icon: const Icon(Icons.add_circle),
                            tooltip: 'Crear partidos de liga',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MatchLRolesMain.route(
                                    BlocProvider.of<TournamentMainCubit>(
                                        context),
                                    state.selectedTournament),
                              );
                              context
                                  .read<TournamentMainCubit>()
                                  .getQualifiedTeams(
                                      tournamentId: state
                                          .selectedTournament.tournamentId!);
                            },
                          ),
                        );
                      } else {
                        return const Text('');
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        BlocBuilder<TournamentMainCubit, TournamentMainState>(
          builder: (context, state) {
            if (state.screenState == LMTournamentScreen.loadingQualifiedTeams) {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.blue[800]!,
                  size: 50,
                ),
              );
            }
            if (state.qualifiedTeamsList!.isNotEmpty) {
              return GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: (widthScreen / 5),
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: state.qualifiedTeamsList!.length,
                itemBuilder: (context, index) => _QualifiedTeamCard(
                    teamTournament: state.qualifiedTeamsList![index]),
              );
            } else {
              return const Center(child: Text('No hay equipos calificados'));
            }
          },
        ),
      ],
    );
  }
}

class _QualifiedTeamCard extends StatelessWidget {
  final TeamTournament teamTournament;

  const _QualifiedTeamCard({
    Key? key,
    required this.teamTournament,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: Image(
                  image: (teamTournament.teamId?.logoId?.document != '' &&
                          teamTournament.teamId?.logoId?.document != null)
                      ? Image.memory(base64Decode(
                              teamTournament.teamId!.logoId!.document!))
                          .image
                      : Image.asset('assets/images/equipo2.png').image,
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    teamTournament.teamId!.teamName ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
