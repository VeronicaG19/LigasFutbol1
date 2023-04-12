import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import './options/league/league_option.dart';
import '../../../../../../domain/category/entity/category.dart';
import '../../../../../../domain/countResponse/entity/register_count_interface.dart';
import '../../../../../../domain/matches/dto/detail_rol_match_dto/detail_rol_match_DTO.dart';
import '../../../../../../domain/tournament/entity/tournament.dart';
import '../../../../../../service_locator/injection.dart';
import '../../../../../app/bloc/authentication_bloc.dart';
import '../../../lm_tournament_v1/clasification/cubit/clasification_cubit.dart';
import '../../../lm_tournament_v1/clasification/finalize_match_modal.dart';
import '../../../lm_tournament_v1/clasification/finalize_tournament.dart';
import '../../../lm_tournament_v1/clasification/role_games.dart';
import '../../../lm_tournament_v1/clasification/scoring_sistem_modal.dart';
import '../../../lm_tournament_v1/create_tournaments/create_tournament_page.dart';
import '../../../lm_tournament_v1/cubit/tournament_cubit.dart';
import '../../../lm_tournament_v1/scoring_table_tournamens/scorint_table_main_page.dart';
import '../../../lm_tournament_v1/tournaments_widgets/need_select_tournament_page.dart';
import '../../../lm_tournament_v1/tournaments_widgets/tournament_configuration.dart';
import '../../../lm_tournament_v1/tournaments_widgets/tournaments_teams.dart';
import '../../edit_game_rol/view/p_edit_game_rol.dart';
import '../cubit/tournament_main_cubit.dart';

class TournamentPage extends StatelessWidget {
  const TournamentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final league =
        context.select((AuthenticationBloc bloc) => bloc.state.leagueManager);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 10, 25, 15),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => locator<TournamentMainCubit>()
                ..onLoadCategories(league.leagueId)),
          BlocProvider(create: (_) => locator<TournamentCubit>()),
          BlocProvider(create: (_) => locator<ClasificationCubit>()),
        ],
        // create: (_) =>
        //     locator<TournamentMainCubit>()..onLoadCategories(league.leagueId),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _HeadingBar(),
            _TournamentList(),
            _TournamentTitle(),
            Expanded(child: _BodyContent()),
          ],
        ),
      ),
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
        child: BlocConsumer<TournamentMainCubit, TournamentMainState>(
          listenWhen: (previous, current) =>
              previous.selectedMenu != current.selectedMenu ||
              previous.selectedTournament != current.selectedTournament,
          listener: (context, state) {
            context
                .read<TournamentCubit>()
                .onChangeTournament(state.selectedTournament);
            if (state.selectedMenu == 0 &&
                state.selectedTournament.isNotEmpty) {
              context.read<TournamentCubit>().getTournamentDetail(
                  tournamentId: state.selectedTournament.tournamentId ?? 0);
            }
            if (state.selectedMenu == 2) {
              context
                  .read<ClasificationCubit>()
                  .getScoreData(state.selectedTournament.tournamentId);
            }
            if (state.selectedMenu > 2 && state.selectedMenu < 5) {
              context
                  .read<ClasificationCubit>()
                  .getScoringSystem(tournament: state.selectedTournament);
            }
          },
          builder: (context, state) {
            if (state.selectedTournament.isEmpty) {
              return const Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: NeedSlctTournamentPage(),
              );
            }
            if (state.screenState == LMTournamentScreen.loadingTournaments) {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.blue[800]!,
                  size: 50,
                ),
              );
            }
            return ListView(
              shrinkWrap: true,
              children: [
                const _TournamentMenuOptions(),
                if (state.selectedMenu == 0) ConfigurationTournament(),
                if (state.selectedMenu == 1) TournamentsTeams(),
                if (state.selectedMenu == 2) const _MatchDataTable(),
                if (state.selectedMenu == 3)
                  const RoleGames(
                    screen: 2,
                  ),
                if (state.selectedMenu == 4)
                  ScoringTableMainPage(tournament: state.selectedTournament),
                if (state.selectedMenu == 5) const LeagueOption(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _MatchDataTable extends StatelessWidget {
  const _MatchDataTable();

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
        },
      ),
      child: SingleChildScrollView(
        child: BlocBuilder<TournamentMainCubit, TournamentMainState>(
          builder: (context, state) {
            if (state.screenState == LMTournamentScreen.loadingTable) {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.blue[800]!,
                  size: 50,
                ),
              );
            }
            return BlocListener<ClasificationCubit, ClasificationState>(
              listenWhen: (previous, current) =>
                  previous.screenStatus != current.screenStatus,
              listener: (context, state) {
                if (state.screenStatus == CLScreenStatus.matchFinalized) {
                  context.read<TournamentMainCubit>().onLoadGameRolTable();
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _RoundNumberBar(),
                  if (state.screenState ==
                          LMTournamentScreen.loadingTableFilteredByRound ||
                      state.screenState == LMTournamentScreen.creatingRoles)
                    Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: Colors.blue[800]!,
                        size: 50,
                      ),
                    ),
                  if (state.screenState !=
                          LMTournamentScreen.loadingTableFilteredByRound &&
                      state.screenState != LMTournamentScreen.creatingRoles)
                    DataTable(
                      headingTextStyle: const TextStyle(color: Colors.white),
                      headingRowColor: MaterialStateProperty.resolveWith(
                        (Set states) => const Color(0xff0791a3),
                      ),
                      sortColumnIndex: 0,
                      sortAscending: state.roundNumberSorting,
                      columns: [
                        DataColumn(
                          label: const Text('Jornada'),
                          onSort: (columnIndex, _) {
                            context.read<TournamentMainCubit>().onSortMatches();
                          },
                        ),
                        const DataColumn(label: Text('Fecha')),
                        const DataColumn(label: Text('Local')),
                        const DataColumn(label: Text('Marcador')),
                        const DataColumn(label: Text('Visitante')),
                        const DataColumn(label: Text('Campo')),
                        const DataColumn(label: Text('Árbitro')),
                        const DataColumn(label: Text('Configuración')),
                      ],
                      rows: List.generate(
                        state.matches.length,
                        (index) => DataRow(
                          cells: [
                            DataCell(Text(
                                '${state.matches[index].roundNumber ?? 0}')),
                            DataCell(
                                Text(state.matches[index].dateMatch ?? '-')),
                            DataCell(
                                Text(state.matches[index].localTeam ?? '-')),
                            DataCell(
                              _BtnEdiGameButton(
                                match: state.matches[index],
                              ),
                            ),
                            DataCell(
                                Text(state.matches[index].teamVisit ?? '-')),
                            DataCell(
                                Text(state.matches[index].fieldMatch ?? '-')),
                            DataCell(
                                Text(state.matches[index].refereeName ?? '-')),
                            DataCell(
                              IconButton(
                                onPressed: () {
                                  if (state.matches[index].dateMatch != null) {
                                    return;
                                  }
                                  context
                                      .read<TournamentMainCubit>()
                                      .onSelectMatch(state.matches[index]);
                                  Navigator.push(
                                    context,
                                    EditGameRolPage.route(
                                      BlocProvider.of<TournamentMainCubit>(
                                          context),
                                    ),
                                  );
                                },
                                tooltip: 'Editar rol de juego',
                                icon: const Icon(Icons.edit_note),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _RoundNumberBar extends StatelessWidget {
  const _RoundNumberBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
      child: Row(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, right: 20.0),
              child: BlocBuilder<TournamentMainCubit, TournamentMainState>(
                buildWhen: (previous, current) =>
                    previous.selectedRoundNumber !=
                        current.selectedRoundNumber ||
                    previous.roundNumber != current.roundNumber,
                builder: (context, state) {
                  return DropdownButtonFormField<ResgisterCountInterface>(
                    value: state.selectedRoundNumber,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    decoration: const InputDecoration(
                      label: Text(
                        'Selecciona una jornada',
                        style: TextStyle(fontSize: 18),
                      ),
                      border: OutlineInputBorder(),
                    ),
                    isExpanded: true,
                    elevation: 8,
                    onChanged: (ResgisterCountInterface? value) {
                      context
                          .read<TournamentMainCubit>()
                          .onSelectRoundNumber(value);
                    },
                    items: state.roundNumber
                        .map<DropdownMenuItem<ResgisterCountInterface>>(
                            (ResgisterCountInterface value) {
                      return DropdownMenuItem<ResgisterCountInterface>(
                        value: value,
                        child: Text(value.getInfoMessage),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
          const _BtnCreateRolesButton(),
          const _BtnEditGameRoles(),
          const _BtnChampionButton(),
          const _BtnFinishTournamentButton(),
          const _BtnInformationButton(),
        ],
      ),
    );
  }
}

class _TournamentMenuOptions extends StatelessWidget {
  const _TournamentMenuOptions();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentMainCubit, TournamentMainState>(
      buildWhen: (previous, current) =>
          previous.selectedMenu != current.selectedMenu,
      builder: (context, state) {
        return NavigationBar(
          onDestinationSelected:
              context.read<TournamentMainCubit>().onChangeMenu,
          selectedIndex: state.selectedMenu,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: 'Configuración',
            ),
            NavigationDestination(
              icon: Icon(Icons.people),
              label: 'Equipos',
            ),
            NavigationDestination(
              icon: Icon(Icons.safety_divider),
              label: 'Rol de juegos',
            ),
            NavigationDestination(
              icon: Icon(Icons.table_chart),
              label: 'Clasificación',
            ),
            NavigationDestination(
              icon: Icon(Icons.bar_chart),
              label: 'Tabla de goleo',
            ),
            NavigationDestination(
              icon: Icon(Icons.flag_rounded),
              label: 'Liguilla',
            ),
          ],
        );
      },
    );
  }
}

class _TournamentTitle extends StatelessWidget {
  const _TournamentTitle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
      child: BlocBuilder<TournamentMainCubit, TournamentMainState>(
        builder: (context, state) {
          return Text(
            state.selectedTournament.tournamentName ?? '',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                letterSpacing: 1.2),
          );
        },
      ),
    );
  }
}

class _TournamentList extends StatelessWidget {
  const _TournamentList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
      child: SizedBox(
        height: 120,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.mouse,
            },
          ),
          child: BlocBuilder<TournamentMainCubit, TournamentMainState>(
            buildWhen: (previous, current) =>
                previous.selectedTournament != current.selectedTournament ||
                previous.tournaments != current.tournaments,
            builder: (context, state) {
              if (state.screenState == LMTournamentScreen.loadingCategories) {
                return Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                    color: Colors.blue[800]!,
                    size: 50,
                  ),
                );
              }
              if (state.screenState == LMTournamentScreen.loadingTournaments) {
                return const SizedBox();
              }
              if (state.tournaments.isEmpty) {
                return const Center(
                  child: Text(
                    'No hay resultados de torneos',
                    style: TextStyle(fontSize: 22),
                  ),
                );
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: state.tournaments.length,
                itemBuilder: (context, index) => _TournamentCard(
                  tournament: state.tournaments[index],
                  isSelected:
                      state.tournaments[index] == state.selectedTournament,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _HeadingBar extends StatelessWidget {
  const _HeadingBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 4,
            child: BlocConsumer<TournamentMainCubit, TournamentMainState>(
              listenWhen: (previous, current) =>
                  previous.screenState != current.screenState,
              listener: (context, state) {
                if (state.screenState == LMTournamentScreen.categoriesLoaded) {
                  context
                      .read<TournamentCubit>()
                      .getCategoriesByLeage(state.categories);
                }
              },
              buildWhen: (previous, current) =>
                  previous.selectedCategory != current.selectedCategory ||
                  previous.categories != current.categories,
              builder: (context, state) {
                return DropdownButtonFormField<Category>(
                  value: state.selectedCategory,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  decoration: const InputDecoration(
                    label: Text(
                      'Categorías',
                      style: TextStyle(fontSize: 18),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  isExpanded: true,
                  elevation: 8,
                  onChanged:
                      context.read<TournamentMainCubit>().onChangeCategory,
                  items: state.categories
                      .map<DropdownMenuItem<Category>>((Category value) {
                    return DropdownMenuItem<Category>(
                      value: value,
                      child: Text(value.categoryName),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Flexible(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: TextField(
                enabled:
                    context.watch<TournamentMainCubit>().state.screenState !=
                        LMTournamentScreen.loadingCategories,
                decoration: InputDecoration(
                  isDense: false,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 7.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: 'Buscar torneo...',
                  hintStyle: const TextStyle(
                      fontSize: 15.0, fontWeight: FontWeight.w300),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      hoverColor: Colors.transparent,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        size: 28.0,
                      ),
                    ),
                  ),
                ),
                onChanged:
                    context.read<TournamentMainCubit>().onFilterTournaments,
              ),
            ),
          ),
          const Flexible(
            flex: 1,
            child: _SortingMenu(),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10.0),
              child: IconButton(
                tooltip: 'Crear nuevo torneo',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateTournamentPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.add_circle),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SortingMenu extends StatefulWidget {
  const _SortingMenu({Key? key}) : super(key: key);

  @override
  State<_SortingMenu> createState() => _SortingMenuState();
}

class _SortingMenuState extends State<_SortingMenu> {
  SortingOptions? option;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<SortingOptions>(
      value: option,
      icon: const Icon(Icons.keyboard_arrow_down),
      hint: const Text('Ordenar por'),
      isExpanded: true,
      elevation: 8,
      borderRadius: BorderRadius.circular(12.0),
      onChanged: (SortingOptions? value) {
        setState(() {
          option = value;
        });
        context.read<TournamentMainCubit>().onSortTournaments(option);
      },
      items: SortingOptions.values
          .map<DropdownMenuItem<SortingOptions>>((SortingOptions value) {
        return DropdownMenuItem<SortingOptions>(
          value: value,
          child: Text(value.description),
        );
      }).toList(),
    );
  }
}

class _TournamentCard extends StatelessWidget {
  const _TournamentCard({
    required this.tournament,
    required this.isSelected,
  });

  final Tournament tournament;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Card(
        shape: isSelected
            ? RoundedRectangleBorder(
                side: const BorderSide(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(12.0),
              )
            : RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12.0),
              ),
        elevation: isSelected ? 2.5 : 1.0,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: ListTile(
            title: Text(
              tournament.tournamentName ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              softWrap: true,
            ),
            subtitle: Text(
              tournament.categoryId?.categoryName ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              softWrap: true,
            ),
            onTap: () => context
                .read<TournamentMainCubit>()
                .onSelectTournament(tournament),
          ),
        ),
      ),
    );
  }
}

class _BtnCreateRolesButton extends StatelessWidget {
  const _BtnCreateRolesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TournamentMainCubit, TournamentMainState>(
      listenWhen: (previous, current) =>
          previous.screenState != current.screenState,
      listener: (context, state) {
        if (state.screenState == LMTournamentScreen.rolesCreatedSuccessfully) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  content: Text('Rol de juegos creado correctamente'),
                  duration: Duration(seconds: 5)),
            );
        } else if (state.screenState ==
            LMTournamentScreen.errorOnCreatingRoles) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Se ha producido un error'),
                duration: const Duration(seconds: 5),
              ),
            );
        }
      },
      builder: (context, state) {
        return Visibility(
          visible: context.watch<TournamentMainCubit>().state.matches.isEmpty,
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0),
            child: IconButton(
              tooltip: 'Crear rol de juegos',
              onPressed: () =>
                  context.read<TournamentMainCubit>().createGameRoles(),
              icon: const Icon(Icons.add_circle),
            ),
          ),
        );
      },
    );
  }
}

class _BtnEditGameRoles extends StatelessWidget {
  const _BtnEditGameRoles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10.0),
      child: IconButton(
        tooltip: 'Editar',
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              final cubit = context.read<ClasificationCubit>();
              return BlocProvider<ClasificationCubit>.value(
                value: cubit,
                child: ScoringSystemDialog(),
              );
            },
          );
        },
        icon: const Icon(Icons.edit),
      ),
    );
  }
}

class _BtnChampionButton extends StatelessWidget {
  const _BtnChampionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.select((ClasificationCubit bloc) => bloc.state);
    return Visibility(
      visible: cubit.statusTournament == 'true' && cubit.nameCh.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 10.0),
        child: IconButton(
          tooltip: 'Ver campeón',
          onPressed: () {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('El equipo campeón es:'),
                content: Text(cubit.nameCh),
              ),
            );
          },
          icon: const Icon(Icons.military_tech),
        ),
      ),
    );
  }
}

class _BtnFinishTournamentButton extends StatelessWidget {
  const _BtnFinishTournamentButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.select((ClasificationCubit bloc) => bloc.state);
    print(" pamc ${cubit.tournament.typeTournament}");
    print(" pamc ${cubit.tournament.tournamentId}");
    print(" pamc ${cubit.statusTournament}");
    print(" pamc ${cubit.nameCh}");
    return Visibility(
      visible: cubit.statusTournament == 'true' && cubit.nameCh.isEmpty,
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 10.0),
        child: IconButton(
          tooltip: 'Finalizar torneo2',
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                return BlocProvider.value(
                  value: BlocProvider.of<ClasificationCubit>(context),
                  child: FinalizeTournamentDialog(),
                );
              },
            );
          },
          icon: const Icon(Icons.tour),
        ),
      ),
    );
  }
}

class _BtnInformationButton extends StatelessWidget {
  const _BtnInformationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scoringSystem =
        context.select((ClasificationCubit bloc) => bloc.state.scoringSystem);
    return Padding(
      padding: const EdgeInsets.only(right: 25.0, left: 10.0),
      child: IconButton(
        tooltip: 'Información',
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text('Información', textAlign: TextAlign.center),
                content: Text('''
                        Los criterios de puntaje definido son:
                        
                        * Al equipo ganador de un partido se le otorgan ${scoringSystem.pointsPerWin ?? 0} puntos.
                        * En caso de empate en un partido, se le otorgan ${scoringSystem.pointPerTie ?? 0} punto a cada equipo.
                        * En caso de empate al equipo ganador de un partido en shoot out se le otorgan ${scoringSystem.pointsPerWinShootOut ?? 0} puntos.
                        * En caso de empate al equipo perdedor de un partido en shoot out se le otorgan ${scoringSystem.pointPerLossShootOut ?? 0} puntos.
                        '''),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(_),
                    child: const Text('Aceptar'),
                  ),
                ],
              );
            },
          );
        },
        icon: const Icon(Icons.info),
      ),
    );
  }
}

class _BtnEdiGameButton extends StatelessWidget {
  const _BtnEdiGameButton({Key? key, required this.match}) : super(key: key);
  final DeatilRolMatchDTO match;

  @override
  Widget build(BuildContext context) {
    return match.score == "Asignar resultado"
        ? IconButton(
            onPressed: () {
              context.read<ClasificationCubit>().asingDataFinalize(match);
              showDialog(
                context: context,
                builder: (_) {
                  return BlocProvider<ClasificationCubit>.value(
                    value: BlocProvider.of<ClasificationCubit>(context),
                    child: FinalizeMatchModal(
                      visit: match.teamVisit!,
                      local: match.localTeam!,
                    ),
                  );
                },
              );
            },
            icon: const Icon(
              Icons.edit,
              color: Color(0xff358aac),
              size: 20,
            ),
          )
        : Container(
            width: 40,
            height: 40,
            color: Colors.black12,
            child: Center(
              child: Text(
                match.score ?? '-',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
          );
  }
}
