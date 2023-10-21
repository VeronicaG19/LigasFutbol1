import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';
import 'package:ligas_futbol_flutter/src/presentation/widgets/app_bar_page.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../../core/constans.dart';
import '../../../../../../core/enums.dart';
import '../../../../../player/user_menu/widget/help_menu_button.dart';
import '../../../../../player/user_menu/widget/tutorial_widget.dart';
import '../../main_page/cubit/tournament_main_cubit.dart';
import '../cubit/edit_game_rol_cubit.dart';
import '../widget/filter_bar.dart';
import '../widget/map_section.dart';
import '../widget/w_grid_list.dart';
import '../widget/w_result_content.dart';

class EditGameRolPage extends StatefulWidget {
  const EditGameRolPage({Key? key}) : super(key: key);

  static Route route(TournamentMainCubit cubit) => MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: const EditGameRolPage(),
        ),
      );

  @override
  State<EditGameRolPage> createState() => _EditGameRolPageState();
}

class _EditGameRolPageState extends State<EditGameRolPage> {
  @override
  Widget build(BuildContext context) {
    final match =
        context.select((TournamentMainCubit bloc) => bloc.state.selectedMatch);
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
    print(
        "satus de solicitud field------------------------>${match.statusRequestField}");

    print("id de campo------------------------>${match.requestFieldId}");
    print(
        "satus de solicitud referee------------------------>${match.statusRequestField}");
    print("id de referee------------------------>${match.requestRefereeId}");

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBarPage(
          title: 'Editar rol de juego ${match.localTeam} VS ${match.teamVisit}',
          size: 100,
        ),
      ),
      body: BlocProvider(
        create: (contextC) => locator<EditGameRolCubit>()
          ..onLoadInitialResults(match, leagueManager.leagueId),
        child: BlocListener<TournamentMainCubit, TournamentMainState>(
          listenWhen: (previous, current) =>
              previous.screenState != current.screenState,
          listener: (context, state) {
            if (state.screenState == LMTournamentScreen.tableLoaded) {
              context.read<EditGameRolCubit>().onLoadInitialResults(
                  state.selectedMatch, leagueManager.leagueId);
            }
          },
          child: BlocConsumer<EditGameRolCubit, EditGameRolState>(
            listenWhen: (previous, current) =>
                previous.screenState != current.screenState,
            listener: (contextC, state) {
              if (state.screenState == BasicCubitScreenState.success) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                        content:
                            Text('Se ha enviado la solicitud correctamente'),
                        duration: Duration(seconds: 5)),
                  );
                context.read<TournamentMainCubit>().onLoadGameRolTable();
              } else if (state.screenState ==
                  BasicCubitScreenState.submissionSuccess) {
                context.read<TournamentMainCubit>().onLoadGameRolTable();
              }
              if (state.screenState == BasicCubitScreenState.emptyData ||
                  state.screenState == BasicCubitScreenState.invalidData ||
                  state.screenState == BasicCubitScreenState.error) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage ?? 'Error'),
                      duration: const Duration(seconds: 5),
                    ),
                  );
              }
            },
            builder: (contextC, state) {
              if (state.screenState == BasicCubitScreenState.loading) {
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
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FilterBar(),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          key: CoachKey.cleanRoleGame,
                          width: 90,
                          height: 35,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey, //blue
                            border: Border.all(
                              color: Colors.black12,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(45),
                          ),
                          child: InkWell(
                            onTap: () {
                              contextC
                                  .read<EditGameRolCubit>()
                                  .onClearFilters();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.refresh,
                                  size: 20,
                                  color: Colors.grey[200],
                                ),
                                Text(
                                  'Limpiar',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[200],
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const HelpMeButton(
                            iconData: Icons.help,
                            tuto: TutorialType.ligeRoleGameTutorial),
                      ],
                    ),
                  ),
                  if (state.isMapVisible) const MapSearchingSection(),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.only(bottom: 15, top: 8, left: 10.0),
                          child: Text(
                            "Campos disponibles",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 8),
                          child: Text(
                            "Árbitros disponibles",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      /* if (state.isMapVisible)
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 2, 5, 7),
                            child: SizedBox(
                                width: 500, child: AutocompleteAddress()),
                          ),
                        ),*/
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: match.statusRequestField == null
                            ? const SelectFileTypeHeader()
                            : Container(),
                      ),
                      Expanded(
                        child: match.statusRequestReferee == null
                            ? const SelectRefereeTypeHeader()
                            : Container(),
                      ),
                    ],
                  ),

                  if (state.screenState == BasicCubitScreenState.sending)
                    SizedBox(
                      height: 300,
                      child: Center(
                        child: LoadingAnimationWidget.fourRotatingDots(
                          color: Colors.blue[800]!,
                          size: 50,
                        ),
                      ),
                    ),
                  if (state.screenState != BasicCubitScreenState.sending)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 2,
                          child: GridList(
                            isReferee: false,
                          ),
                        ),
                        const Expanded(
                          flex: 2,
                          child: GridList(
                            isReferee: true,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: const ResultContent(),
                        )
                      ],
                    ),

                  //   const ResultContent(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class SelectFileTypeHeader extends StatefulWidget {
  const SelectFileTypeHeader({Key? key}) : super(key: key);

  @override
  State<SelectFileTypeHeader> createState() => _SelectFileTypeHeaderState();
}

class _SelectFileTypeHeaderState extends State<SelectFileTypeHeader> {
  static const String leagueLbl = 'Ver por liga';
  static const String otherLeagueLbl = 'Ver de otras ligas';

  @override
  Widget build(BuildContext context) {
    final match =
        context.select((TournamentMainCubit bloc) => bloc.state.selectedMatch);
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: SizedBox(
              width: 500,
              child: RadioListTile<int>(
                value: 0,
                groupValue:
                    context.read<EditGameRolCubit>().state.selectedFieldValue,
                onChanged: (value) {
                  context
                      .read<EditGameRolCubit>()
                      .validateFieldData(leagueManager.leagueId, value!);
                  // if (widget.requestType == LMRequestType.referee) {
                  // }
                  print(
                      "valor-------------------------------------------->$value");
                },
                title: const Text(leagueLbl,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    )),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: 500,
              child: RadioListTile<int>(
                value: 1,
                groupValue:
                    context.read<EditGameRolCubit>().state.selectedFieldValue,
                onChanged: (value) {
                  context
                      .read<EditGameRolCubit>()
                      .validateFieldData(leagueManager.leagueId, value!);

                  print(
                      "valor 2-------------------------------------------->$value");

                  // if (widget.requestType == LMRequestType.referee) {
                  // }
                },
                title: const Text(otherLeagueLbl,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectRefereeTypeHeader extends StatefulWidget {
  const SelectRefereeTypeHeader({Key? key}) : super(key: key);

  @override
  State<SelectRefereeTypeHeader> createState() =>
      _SelectRefereeTypeHeaderState();
}

class _SelectRefereeTypeHeaderState extends State<SelectRefereeTypeHeader> {
  static const String leagueLbl = 'Ver por liga';
  static const String otherLeagueLbl = 'Ver de otras ligas';

  @override
  Widget build(BuildContext context) {
    final match =
        context.select((TournamentMainCubit bloc) => bloc.state.selectedMatch);
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: SizedBox(
              width: 500,
              child: RadioListTile<int>(
                value: 0,
                groupValue:
                    context.read<EditGameRolCubit>().state.selectedRefereeValue,
                onChanged: (value) {
                  context
                      .read<EditGameRolCubit>()
                      .validateRefereeData(leagueManager.leagueId, value!);
                  // if (widget.requestType == LMRequestType.referee) {
                  // }
                  print(
                      "valor-------------------------------------------->$value");
                },
                title: const Text(leagueLbl,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    )),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: 500,
              child: RadioListTile<int>(
                value: 1,
                groupValue:
                    context.read<EditGameRolCubit>().state.selectedRefereeValue,
                onChanged: (value) {
                  context
                      .read<EditGameRolCubit>()
                      .validateRefereeData(0, value!);
                  print(
                      "valor 2-------------------------------------------->$value");
                  // if (widget.requestType == LMRequestType.referee) {
                  // }
                },
                title: const Text(otherLeagueLbl,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
