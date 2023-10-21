import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../core/enums.dart';
import '../../../../../domain/team_tournament/entity/team_tournament.dart';
import '../../../../../domain/tournament/entity/tournament.dart';
import '../../../../../service_locator/injection.dart';
import '../../lm_tournament_v2/main_page/cubit/tournament_main_cubit.dart';
import 'cubit/matchs_l_roles_cubit.dart';

class MatchesLRolesPage extends StatelessWidget {
  final Tournament tournament;

  const MatchesLRolesPage({super.key, required this.tournament});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<MatchesLRolesCubit>()
        ..getTournamentTeams(tournamentId: tournament.tournamentId),
      child: BlocConsumer<MatchesLRolesCubit, MatchesLRolesState>(
        listenWhen: (previous, current) =>
            previous.screenStatus != current.screenStatus,
        listener: (context, state) {
          if (state.screenStatus == BasicCubitScreenState.emptyData) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                    content: Text('Debes llenar los campos faltantes'),
                    duration: Duration(seconds: 3)),
              );
          } else if (state.screenStatus ==
                  BasicCubitScreenState.submissionFailure ||
              state.screenStatus == BasicCubitScreenState.error) {
            final errorMessage = state.errorMessage ?? 'Ha ocurrido un error';
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                    content: Text(errorMessage),
                    duration: const Duration(seconds: 3)),
              );
          } else if (state.screenStatus ==
              BasicCubitScreenState.submissionSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                    content: Text('Configuración concluida con éxito'),
                    duration: Duration(seconds: 3)),
              );
            context.read<TournamentMainCubit>().setTournamentStatusToFalse();
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state.screenStatus == BasicCubitScreenState.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.blue[800]!,
                size: 50,
              ),
            );
          } else {
            return Column(
              children: [
                const _ScreenTitle(),
                const _ScreenHeader(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: state.roundCount,
                      separatorBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: SizedBox(
                            height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: _TeamMenuSelection(
                                    title: 'Local',
                                    rowNumber: index,
                                    indexList: index + index,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: _TeamMenuSelection(
                                    title: 'Visitante',
                                    rowNumber: index,
                                    indexList: index + (index + 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                if (state.screenStatus ==
                    BasicCubitScreenState.submissionInProgress)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (state.screenStatus !=
                    BasicCubitScreenState.submissionInProgress)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        _SubmitButton(),
                        SizedBox(
                          width: 25,
                        ),
                        _ClearButton(),
                      ],
                    ),
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}

class _ScreenTitle extends StatelessWidget {
  const _ScreenTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = context.select((MatchesLRolesCubit bloc) => bloc.state.round);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 35),
      ),
    );
  }
}

class _ScreenHeader extends StatelessWidget {
  const _ScreenHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
        fontSize: 15, color: Colors.grey[200], fontWeight: FontWeight.w900);

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      height: 35,
      color: const Color(0xff358aac),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Local",
                  textAlign: TextAlign.start,
                  style: textStyle,
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Visitante",
                  textAlign: TextAlign.start,
                  style: textStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TeamMenuSelection extends StatelessWidget {
  const _TeamMenuSelection(
      {Key? key,
      required this.title,
      required this.rowNumber,
      required this.indexList})
      : super(key: key);
  final String title;
  final int rowNumber;
  final int indexList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchesLRolesCubit, MatchesLRolesState>(
      builder: (context, state) {
        final selectedValue =
            state.tmsSelected[indexList] == TeamTournament.empty
                ? null
                : state.tmsSelected[indexList];
        return DropdownButtonFormField<TeamTournament>(
          decoration: InputDecoration(
            label: Text(title),
            border: const OutlineInputBorder(),
          ),
          //icon: const Icon(Icons.sports_soccer),
          value: selectedValue,
          isExpanded: true,
          hint: const Text('Selecciona un equipo'),
          items: List.generate(
            state.listOfTeams[indexList].length,
            (index) {
              final content =
                  state.listOfTeams[indexList][index].teamId?.teamName ?? '';
              return DropdownMenuItem(
                value: state.listOfTeams[indexList][index],
                child: Text(
                    content.trim().isEmpty ? 'Selecciona un equipo' : content),
              );
            },
          ),
          onChanged: (value) {
            context.read<MatchesLRolesCubit>().onSelectTeam(value, indexList);
          },
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green),
        ),
        onPressed: () {
          context.read<MatchesLRolesCubit>().onSaveEditRoles();
        },
        icon: const Icon(
          Icons.save,
          size: 24.0,
        ),
        label: const Text('Guardar'),
      ),
    );
  }
}

class _ClearButton extends StatelessWidget {
  const _ClearButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blue),
        ),
        onPressed: context.read<MatchesLRolesCubit>().onCleanList,
        icon: const Icon(
          Icons.clear,
          size: 24.0,
        ),
        label: const Text('Limpiar'),
      ),
    );
  }
}
