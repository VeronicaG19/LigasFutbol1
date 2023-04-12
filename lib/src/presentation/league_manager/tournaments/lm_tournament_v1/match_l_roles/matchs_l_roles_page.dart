import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../domain/team_tournament/entity/team_tournament.dart';
import '../../../../../domain/tournament/entity/tournament.dart';
import '../../../../../service_locator/injection.dart';
import '../../../../app/app.dart';
import 'cubit/matchs_l_roles_cubit.dart';

class MatchsLRolesPage extends StatelessWidget {
  final Tournament tournament;
  final String seccion;
  const MatchsLRolesPage(
      {super.key, required this.tournament, required this.seccion});

  @override
  Widget build(BuildContext context) {
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.leagueManager);
    return BlocProvider(
      create: (_) => locator<MatchsLRolesCubit>()
        ..getTeamsTournaments(
            tournamentId: tournament.tournamentId!,
            leagueId: leagueManager.leagueId, numM: seccion == 'Final' ? 1 :
        seccion == 'Semifinal' ? 2 :
        seccion == '4TOS' ? 4 :
        seccion == '8VOS' ? 8 :
        seccion == '16VOs' ? 16 : 32),
      child: BlocBuilder<MatchsLRolesCubit, MatchsLRolesState>(
        builder: (context, state) {
          if (state.screenStatus == ScreenStatus.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.blue[800]!,
                size: 50,
              ),
            );
          } else {
            return Card(
              child: Column(
                children: [
                  Text(
                    'Crear partidos de liguilla del torneo ${tournament.tournamentName}',
                    style: const TextStyle(fontSize: 35),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      labelText: state.listOfTeams.length.toInt()~/2 ==1 ? 'Final'
                                :state.listOfTeams.length.toInt()~/2 == 2 ? 'Semifinal'
                                :state.listOfTeams.length.toInt()~/2 == 4 ? 'Cuartos'
                                :state.listOfTeams.length.toInt()~/2 == 8 ? 'Octavos'
                                :state.listOfTeams.length.toInt()~/2 == 16 ? '16VOs'
                                :'32VOs',//"Jornada ${state.nextRoundNumber.coundt1}",
                      labelStyle: TextStyle(fontSize: 13),
                    ),
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Stack(fit: StackFit.loose, children: [
                    Container(
                      padding: const EdgeInsets.only(right: 7, left: 7),
                      height: 35,
                      color: const Color(0xff358aac),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                "Local",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[200],
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            SizedBox(
                              width: 60,
                              child: Text(
                                "Visitante",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[200],
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ]),
                    ),
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: state.listOfTeams.length.toInt()~/2,
                        padding: EdgeInsets.only(top: 40, bottom: 65),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                color: Colors.grey,
                                height: 1,
                              ),
                              Container(
                                height: 70,
                                padding: EdgeInsets.only(right: 7, left: 7),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: DropdownButtonFormField<
                                            TeamTournament>(
                                          decoration: const InputDecoration(
                                            label: Text('Local'),
                                            border: OutlineInputBorder(),
                                          ),
                                          //icon: const Icon(Icons.sports_soccer),
                                          isExpanded: true,
                                          hint: const Text(
                                              'Selecciona un equipo'),
                                          items: List.generate(
                                            state.listOfTeams.length,
                                            (index) {
                                              final content = state
                                                  .listOfTeams[index]
                                                  .teamId
                                                  ?.teamName;
                                              return DropdownMenuItem(
                                                value: state.listOfTeams[index],
                                                child: Text(
                                                    content!.trim().isEmpty
                                                        ? 'Selecciona un equipo'
                                                        : content),
                                              );
                                            },
                                          ),
                                          onChanged: (value) {
                                            context
                                                .read<MatchsLRolesCubit>()
                                                .onChangeTeamLocal(
                                                    index, value!);
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: DropdownButtonFormField<
                                            TeamTournament>(
                                          decoration: const InputDecoration(
                                            label: Text('Visitante'),
                                            border: OutlineInputBorder(),
                                          ),
                                          //icon: const Icon(Icons.sports_soccer),
                                          isExpanded: true,
                                          hint: const Text(
                                              'Selecciona un equipo'),
                                          items: List.generate(
                                            state.listOfTeams.length,
                                            (index) {
                                              final content = state
                                                  .listOfTeams[index]
                                                  .teamId
                                                  ?.teamName;
                                              return DropdownMenuItem(
                                                value: state.listOfTeams[index],
                                                child: Text(
                                                    content!.trim().isEmpty
                                                        ? 'Selecciona un equipo'
                                                        : content),
                                              );
                                            },
                                          ),
                                          onChanged: (value) {
                                            context
                                                .read<MatchsLRolesCubit>()
                                                .onChangeTeamVisit(
                                                    index, value!);
                                          },
                                        ),
                                      ),
                                    ]),
                              ),
                            ],
                          );
                          //     TablePage()
                        }),
                  ]),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green)),
                          onPressed: () {
                            context.read<MatchsLRolesCubit>().onSaveEditRoles(tournament.tournamentId!);
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.save, // <-- Icon
                            size: 24.0,
                          ),
                          label: const Text('Guardar'), // <-- Text
                        ),
                      ),
                    ],
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
