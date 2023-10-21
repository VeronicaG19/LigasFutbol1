import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import './options/league/league_option.dart';
import '../../../../../../core/constans.dart';
import '../../../../../../domain/category/entity/category.dart';
import '../../../../../../domain/countResponse/entity/register_count_interface.dart';
import '../../../../../../domain/matches/dto/detail_rol_match_dto/detail_rol_match_DTO.dart';
import '../../../../../../domain/tournament/entity/tournament.dart';
import '../../../../../../service_locator/injection.dart';
import '../../../../../app/bloc/authentication_bloc.dart';
import '../../../../../player/user_menu/widget/help_menu_button.dart';
import '../../../../../player/user_menu/widget/tutorial_widget.dart';
import '../../../../rating/match_rating/view/match_rating_page.dart';
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
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => locator<TournamentMainCubit>()
              ..onLoadCategories(league.leagueId)),
        BlocProvider(create: (_) => locator<TournamentCubit>()),
        BlocProvider(create: (_) => locator<ClasificationCubit>()),
      ],
      // create: (_) =>
      //     locator<TournamentMainCubit>()..onLoadCategories(league.leagueId),
      child: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _HeadingBar(),
          _TournamentList(),
          //   _TournamentTitle(),
          //Expanded(child: _BodyContent()),
          _BodyContent(),
        ],
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
            // context
            //     .read<TournamentCubit>()
            //     .onChangeTournament(state.selectedTournament);
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
            if (state.selectedMenu == 5) {
              context.read<TournamentMainCubit>().getTournamentFinishedStatus(
                  tournamentId: state.selectedTournament.tournamentId ?? 0);
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
                const SizedBox(height: 50, child: _TournamentMenuOptions()),
                if (state.selectedMenu == 0) ConfigurationTournament(),
                if (state.selectedMenu == 1) TournamentsTeams(),
                if (state.selectedMenu == 2) const _MatchDataTable(),
                if (state.selectedMenu == 3) const RoleGames(screen: 2),
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
                      dataRowHeight: 40,
                      headingRowHeight: 40,
                      sortColumnIndex: 0,
                      sortAscending: state.roundNumberSorting,
                      columns: [
                        DataColumn(
                          label: const Text('Jornada'),
                          onSort: (columnIndex, _) {
                            context.read<TournamentMainCubit>().onSortMatches();
                          },
                        ),
                        const DataColumn(
                            label:
                                Text('Fecha', style: TextStyle(fontSize: 14))),
                        const DataColumn(
                            label:
                                Text('Local', style: TextStyle(fontSize: 14))),
                        const DataColumn(
                            label: Text('Marcador',
                                style: TextStyle(fontSize: 14))),
                        const DataColumn(
                            label: Text('Visitante',
                                style: TextStyle(fontSize: 14))),
                        const DataColumn(
                            label:
                                Text('Campo', style: TextStyle(fontSize: 14))),
                        const DataColumn(
                            label: Text('Árbitro',
                                style: TextStyle(fontSize: 14))),
                        const DataColumn(
                            label: Text('Configuración',
                                style: TextStyle(fontSize: 14))),
                        const DataColumn(
                          label: Text('Calificación',
                              style: TextStyle(fontSize: 14)),
                        ),
                      ],
                      rows: List.generate(
                        state.matches.length,
                        (index) {
                          final match = state.matches[index];
                          final fieldStatus =
                              match.statusRequestField == 'SEND';
                          final refereeStatus =
                              match.statusRequestReferee == 'SEND';
                          return DataRow(
                            cells: [
                              DataCell(Text(
                                '${match.roundNumber ?? 0}',
                                style: const TextStyle(fontSize: 14),
                              )),
                              DataCell(
                                (fieldStatus && refereeStatus)
                                    ? Text(
                                        match.dateMatch ?? '-',
                                        style: const TextStyle(fontSize: 14),
                                      )
                                    : IconButton(
                                        icon: const Icon(
                                          color: Color(0xff0791a3),
                                          Icons.info_outlined,
                                        ),
                                        tooltip: "Por definir",
                                        onPressed: () {},
                                      ),
                              ),
                              DataCell(Text(match.localTeam ?? '-',
                                  style: const TextStyle(fontSize: 14))),
                              DataCell(
                                _BtnEdiGameButton(
                                  match: match,
                                  selectT: state.selectedTournament,
                                ),
                              ),
                              DataCell(Text(match.teamVisit ?? '-',
                                  style: const TextStyle(fontSize: 14))),
                              DataCell(
                                Text(
                                    fieldStatus
                                        ? 'Solicitud enviada'
                                        : match.fieldMatch ?? '-',
                                    style: const TextStyle(fontSize: 14)),
                              ),
                              DataCell(
                                Text(
                                    refereeStatus
                                        ? 'Solicitud enviada'
                                        : match.refereeName ?? '-',
                                    style: const TextStyle(fontSize: 14)),
                              ),
                              DataCell(
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<TournamentMainCubit>()
                                        .onSelectMatch(match);
                                    Navigator.push(
                                      context,
                                      EditGameRolPage.route(
                                        BlocProvider.of<TournamentMainCubit>(
                                            context),
                                      ),
                                    );
                                  },
                                  tooltip: 'Editar rol de juego',
                                  icon: const Icon(Icons.edit_note, size: 18),
                                ),
                              ),
                              DataCell(
                                IconButton(
                                  onPressed: () => Navigator.push(context,
                                      MatchRatingPage.route(match: match)),
                                  tooltip: 'Ver calificación',
                                  icon: const Icon(
                                    Icons.star,
                                    size: 18,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
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
    var tournament;
    return Padding(
      padding: const EdgeInsets.only(right: 100, left: 100, bottom: 7, top: 7),
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
                  tournament = state.selectedTournament.tournamentId;
                  return SizedBox(
                    height: 44,
                    child: DropdownButtonFormField<ResgisterCountInterface>(
                      value: state.selectedRoundNumber,
                      icon: const Icon(Icons.keyboard_arrow_down, size: 18),
                      decoration: const InputDecoration(
                        label: Text(
                          'Selecciona una jornada',
                          style: TextStyle(fontSize: 12),
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
                          child: Text(value.getInfoMessage,
                              style: TextStyle(fontSize: 12)),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          ),
          const _BtnCreateRolesButton(),
          const _BtnEditGameRoles(),
          const _BtnChampionButton(),
          _BtnFinishTournamentButton(tId: tournament),
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
          (previous.selectedMenu != current.selectedMenu ||
              previous.selectedTournament != current.selectedTournament),
      builder: (context, state) {
        return NavigationBar(
          height: 35,
          backgroundColor: Colors.grey[100],
          onDestinationSelected:
              context.read<TournamentMainCubit>().onChangeMenu,
          selectedIndex: state.selectedMenu,
          destinations: <Widget>[
            NavigationDestination(
              icon:
                  const Icon(Icons.settings, size: 18, color: Colors.blueGrey),
              key: CoachKey.configTournament,
              label: 'Configuración',
            ),
            NavigationDestination(
              icon: const Icon(Icons.people, size: 18, color: Colors.blueGrey),
              key: CoachKey.teamsTournament,
              label: 'Equipos',
            ),
            NavigationDestination(
              icon: const Icon(Icons.safety_divider,
                  size: 22, color: Colors.blueGrey),
              key: CoachKey.roleGamesTournament,
              label: 'Rol de juegos',
            ),
            NavigationDestination(
              key: CoachKey.clasificationTournament,
              icon: const Icon(Icons.table_chart,
                  size: 18, color: Colors.blueGrey),
              label: 'Clasificación',
            ),
            NavigationDestination(
              key: CoachKey.scoreTable,
              icon:
                  const Icon(Icons.bar_chart, size: 20, color: Colors.blueGrey),
              label: 'Tabla de goleo',
            ),
            Visibility(
              visible: !context.read<TournamentCubit>().state.lookUpValues.any(
                  (e) => (('${e.lookupValue}' ==
                          '${state.selectedTournament.typeTournament}') &&
                      (e.lookupName == 'Tabla general'))),
              child: NavigationDestination(
                key: CoachKey.miniLigue,
                icon: const Icon(Icons.flag_rounded,
                    size: 20, color: Colors.blueGrey),
                label: 'Liguilla',
              ),
            ),
            const HelpMeButton(
              iconData: Icons.help,
              tuto: TutorialType.ligurTournmanetConfig,
            )
          ],
        );
      },
    );
  }
}

/*class TournamentTitle extends StatelessWidget {
  const TournamentTitle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
      child: BlocBuilder<TournamentMainCubit, TournamentMainState>(
        builder: (context, state) {
          return Text(
            state.selectedTournament.tournamentName ?? '',
            style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 25.0,
                letterSpacing: 1.2),
          );
        },
      ),
    );
  }
}*/

class _TournamentList extends StatelessWidget {
  const _TournamentList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: SizedBox(
        key: CoachKey.selectTournamentLi,
        height: 70,
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
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }
              return /*CarouselSlider(
                options: CarouselOptions(
                  // height: 200.0,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: true,
                  aspectRatio: 6.0, enlargeCenterPage: true,

                  disableCenter: true,
                  onPageChanged: (index, reason) {},
                ),
                items: state.tournaments.map((card) {
                  return Builder(builder: (BuildContext context) {
                    return _TournamentCard(
                      tournament: card,
                      isSelected: state.tournaments == state.selectedTournament,
                    );
                  });
                }).toList(),
              );*/
                  ListView.builder(
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
      padding: const EdgeInsets.only(
        right: 50.0,
        left: 50,
        top: 15,
      ),
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
                return SizedBox(
                  height: 45,
                  child: DropdownButtonFormField<Category>(
                    key: CoachKey.catListTournament,
                    value: state.selectedCategory,
                    icon: const Icon(Icons.keyboard_arrow_down, size: 22),
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      label: Text(
                        'Categorías',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    isExpanded: true,
                    elevation: 8,
                    onChanged:
                        context.read<TournamentMainCubit>().onChangeCategory,
                    items: state.categories
                        .map<DropdownMenuItem<Category>>((Category value) {
                      return DropdownMenuItem<Category>(
                        value: value,
                        child: Text(
                          value.categoryName,
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              key: CoachKey.filterTournament1,
              padding: const EdgeInsets.only(
                right: 5.0,
                left: 5,
              ),
              child: SizedBox(
                  height: 45,
                  child: TextField(
                    enabled: context
                            .watch<TournamentMainCubit>()
                            .state
                            .screenState !=
                        LMTournamentScreen.loadingCategories,
                    decoration: InputDecoration(
                      isDense: false,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 7.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Buscar torneo...',
                      hintStyle: const TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.w300),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: IconButton(
                          hoverColor: Colors.transparent,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            size: 22.0,
                          ),
                        ),
                      ),
                    ),
                    onChanged:
                        context.read<TournamentMainCubit>().onFilterTournaments,
                  )),
            ),
          ),
          const Flexible(
            child: _SortingMenu(),
          ),
          Flexible(
            child: Padding(
                padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                child: BlocConsumer<TournamentMainCubit, TournamentMainState>(
                    listenWhen: (previous, current) =>
                        previous.screenState != current.screenState,
                    listener: (context, state) {
                      if (state.screenState ==
                          LMTournamentScreen.categoriesLoaded) {
                        context
                            .read<TournamentCubit>()
                            .getCategoriesByLeage(state.categories);
                      }
                    },
                    buildWhen: (previous, current) =>
                        previous.selectedCategory != current.selectedCategory ||
                        previous.categories != current.categories,
                    builder: (context, state) {
                      if (state.screenState ==
                          LMTournamentScreen.loadingCategories) {
                        return Center(
                          child: LoadingAnimationWidget.fourRotatingDots(
                            color: const Color(0xff358aac),
                            size: 45,
                          ),
                        );
                      } else {
                        if (state.categories.isNotEmpty) {
                          return IconButton(
                            key: CoachKey.addTournamentButtn,
                            tooltip: 'Crear nuevo torneo',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: BlocProvider.of<TournamentMainCubit>(
                                        context),
                                    child: CreateTournamentPage(fromPage: 2),
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.add_circle, size: 22),
                          );
                        } else {
                          return IconButton(
                            tooltip: 'Sin categorias',
                            onPressed: () {},
                            icon: const Icon(Icons.add_circle, size: 24),
                          );
                        }
                      }
                    })),
          ),
          const HelpMeButton(
              iconData: Icons.help, tuto: TutorialType.ligueAdminTournmnt)
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
      icon: const Icon(Icons.keyboard_arrow_down, size: 24),
      hint: const Text('Ordenar por', style: TextStyle(fontSize: 14)),
      isExpanded: true,
      elevation: 8,
      borderRadius: BorderRadius.circular(10.0),
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
          child: Text(value.description, style: TextStyle(fontSize: 14)),
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
      width: 300,
      child: Card(
        shape: isSelected
            ? RoundedRectangleBorder(
                side: const BorderSide(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              )
            : RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
        elevation: isSelected ? 2.5 : 1.0,
        child: ListTile(
          /*  trailing: Text(
            'Fecha de inscripción: ' +
                    DateFormat('dd-MM-yyyy')
                        .format(tournament.inscriptionDate!) ??
                '',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            softWrap: true,
            style: TextStyle(fontSize: 14),
          ),*/
          leading: Icon(
            Icons.emoji_events,
            color: Colors.blueGrey,
            size: 25,
          ),
          title: Text(
            tournament.tournamentName ?? '',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            softWrap: true,
            style: TextStyle(fontSize: 15),
          ),
          subtitle: Text(
            '${tournament.categoryId?.categoryName ?? ''}',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            softWrap: true,
            style: TextStyle(fontSize: 14),
          ),
          onTap: () => context
              .read<TournamentMainCubit>()
              .onSelectTournament(tournament),
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
              icon: const Icon(Icons.add_circle, size: 20),
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
        tooltip: 'Configuración',
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
        icon: const Icon(Icons.settings_sharp, size: 20),
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
      visible: (cubit.statusTournament == 'true' &&
          cubit.nameCh.isNotEmpty &&
          cubit.tournament.typeTournament != "2"),
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
          icon: const Icon(Icons.military_tech, size: 20),
        ),
      ),
    );
  }
}

class _BtnFinishTournamentButton extends StatelessWidget {
  const _BtnFinishTournamentButton({Key? key, this.tId}) : super(key: key);
  final int? tId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentMainCubit, TournamentMainState>(
      builder: (context, state) {
        final cubit = context.select((ClasificationCubit bloc) => bloc.state);
        return Visibility(
          visible: false,
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0),
            child: IconButton(
              tooltip: 'Finalizar torneo',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return BlocProvider.value(
                      value: BlocProvider.of<TournamentMainCubit>(context),
                      child: FinalizeTournamentDialog(ttInt: tId ?? 0),
                    );
                  },
                );
              },
              icon: const Icon(Icons.tour, size: 20),
            ),
          ),
        );
      },
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
        icon: const Icon(Icons.info, size: 20),
      ),
    );
  }
}

class _BtnEdiGameButton extends StatelessWidget {
  const _BtnEdiGameButton(
      {Key? key, required this.match, required this.selectT})
      : super(key: key);
  final DeatilRolMatchDTO match;
  final Tournament selectT;

  @override
  Widget build(BuildContext context) {
    return match.score == "Asignar resultado"
        ? IconButton(
            onPressed: () {
              context.read<TournamentMainCubit>().asingDataFinalize(match);

              showDialog(
                context: context,
                builder: (_) {
                  //final exampleC = context.read<TournamentMainCubit>();
                  return BlocProvider<TournamentMainCubit>.value(
                    value: BlocProvider.of<TournamentMainCubit>(context),
                    child: FinalizeMatchModal(
                      visit: match.teamVisit!,
                      local: match.localTeam!,
                    ),
                  );
                },
              ) /*.whenComplete(
                    () async => await context
                    .read<TournamentMainCubit>().onLoadGameRolTable(),
                  .read<ClasificationCubit>()
                        .getScoringSystem(
                        tournament: selectT)*/
                  ;
            },
            icon: const Icon(
              Icons.edit,
              color: Color(0xff358aac),
              size: 18,
            ),
          )
        : Container(
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
