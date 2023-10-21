import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/domain/category/category.dart';
import 'package:ligas_futbol_flutter/src/domain/resource_file/entity/resource_file.dart';
import 'package:ligas_futbol_flutter/src/domain/team/entity/team.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/teams/add_team_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/teams/cubit/team_league_manager_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/teams/detail_team_tab.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LMTeamPage extends StatelessWidget {
  const LMTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
    return BlocProvider(
      create: (_) =>
          locator<TeamLeagueManagerCubit>()..getTeams(leagueManager.leagueId),
      child: const LMTeamContent(),
    );
  }
}

class LMTeamContent extends StatelessWidget {
  const LMTeamContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
    final Color? color2 = Colors.green[800];
    return Stack(
      clipBehavior: Clip.hardEdge,
      alignment: AlignmentDirectional.bottomEnd,
      fit: StackFit.loose,
      children: [
        BlocConsumer<TeamLeagueManagerCubit, TeamLeagueManagerState>(
          listenWhen: (previous, current) =>
              previous.screenStatus != current.screenStatus,
          listener: (context, state) {
            if (state.screenStatus == ScreenStatus.createdSucces) {
              showTopSnackBar(
                context,
                CustomSnackBar.success(
                  backgroundColor: color2!,
                  textScaleFactor: 1.0,
                  message: "Se creo el equipo correctamente",
                ),
              );
            }
            if (state.screenStatus == ScreenStatus.updateSucces) {
              showTopSnackBar(
                context,
                CustomSnackBar.success(
                  backgroundColor: color2!,
                  textScaleFactor: 1.0,
                  message: "Se actualizarón correctamente los datos del equipo",
                ),
              );
            }
            if (state.screenStatus == ScreenStatus.deleteSucces) {
              showTopSnackBar(
                context,
                CustomSnackBar.success(
                  backgroundColor: color2!,
                  textScaleFactor: 1.0,
                  message: "Se elimino el equipo correctamente",
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.screenStatus == ScreenStatus.loading) {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: const Color(0xff358aac),
                  size: 50,
                ),
              );
            }
            return ListView(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 15, left: 15, top: 20),
                        child: SizedBox(
                          height: 45,
                          child: TextField(
                            onChanged: context
                                .read<TeamLeagueManagerCubit>()
                                .onFilterList,
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(fontSize: 15),
                              labelText: 'Buscar por nombre de equipo',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 15, left: 15, top: 20),
                        child: InkWell(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(
                                16.0, 10.0, 16.0, 10.0),
                            decoration: const BoxDecoration(
                              color: Color(0xff0791a3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            height: 40,
                            child: Text(
                              'Agregar Equipos',
                              style: TextStyle(
                                fontFamily: 'SF Pro',
                                color: Colors.grey[200],
                                fontWeight: FontWeight.w500,
                                fontSize: 13.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              AddTeamPage.route(
                                  BlocProvider.of<TeamLeagueManagerCubit>(
                                      context),
                                  leagueManager.leagueId),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.only(top: 15, left: 15, right: 15),
                    itemCount: state.teamPageable.content.length,
                    physics: const NeverScrollableScrollPhysics(),
                    //physics: const ScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            childAspectRatio: 1,
                            crossAxisSpacing: 12.0,
                            mainAxisSpacing: 12.0),
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                        child: Card(
                          color: Colors.grey[100],
                          elevation: 3.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 15,
                                  bottom: 8,
                                ),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image(
                                    image: (state.teamPageable.content[index]
                                                    .logo !=
                                                '' &&
                                            state.teamPageable.content[index]
                                                    .logo !=
                                                null)
                                        ? Image.memory(base64Decode(state
                                                .teamPageable
                                                .content[index]
                                                .logo!))
                                            .image
                                        : Image.asset(
                                                'assets/images/equipo2.png')
                                            .image,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: Text(
                                  '${state.teamPageable.content[index].teamName}',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                              /* Padding(
                                padding: EdgeInsets.only(bottom: 8, top: 8),
                                child: Text(
                                  state.teamPageable.content[index].categoryId!
                                          .categoryName ??
                                      '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900),
                                ),
                              )*/
                            ],
                          ),
                        ),
                        onTap: () {
                          Team teamData = Team(
                            teamId: state.teamPageable.content[index].teamId,
                            teamName:
                                state.teamPageable.content[index].teamName,
                            categoryId: Category(
                                categoryId: state
                                    .teamPageable.content[index].categoryId,
                                categoryName: '-'),
                            firstManager:
                                state.teamPageable.content[index].firstManager,
                            logoId: ResourceFile(
                                document:
                                    state.teamPageable.content[index].logo),
                          );

                          context
                              .read<TeamLeagueManagerCubit>()
                              .onChangeUpdateTeam(teamData);
                          context
                              .read<TeamLeagueManagerCubit>()
                              .getImagesOfUniforms(teamId: teamData.teamId!);
                          Navigator.push(
                            context,
                            DetailTeamTab.route(
                              leagueId: leagueManager.leagueId,
                              team: teamData,
                              value: BlocProvider.of<TeamLeagueManagerCubit>(
                                  context),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
        BlocBuilder<TeamLeagueManagerCubit, TeamLeagueManagerState>(
          builder: (context, state) {
            return Container(
              height: 40.0,
              color: const Color(0xff058299),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: state.screenStatus ==
                            BasicCubitScreenState.loading
                        ? null
                        : context.read<TeamLeagueManagerCubit>().goToFirstPage,
                    icon: Icon(Icons.keyboard_double_arrow_left,
                        color: Colors.grey[300]),
                  ),
                  IconButton(
                    onPressed: state.screenStatus ==
                            BasicCubitScreenState.loading
                        ? null
                        : context.read<TeamLeagueManagerCubit>().onPreviousPage,
                    icon: Icon(Icons.keyboard_arrow_left,
                        color: Colors.grey[300]),
                  ),
                  Text(
                      'Total de equipos: ${state.teamPageable.totalElements}  -  Página: ${state.teamPageable.number + 1}/${state.teamPageable.totalPages} ',
                      style: TextStyle(color: Colors.grey[200])),
                  IconButton(
                    onPressed:
                        state.screenStatus == BasicCubitScreenState.loading
                            ? null
                            : context.read<TeamLeagueManagerCubit>().onNextPage,
                    icon: Icon(Icons.keyboard_arrow_right,
                        color: Colors.grey[300], size: 15),
                  ),
                  IconButton(
                    onPressed: state.screenStatus ==
                            BasicCubitScreenState.loading
                        ? null
                        : context.read<TeamLeagueManagerCubit>().goToLastPage,
                    icon: Icon(Icons.keyboard_double_arrow_right,
                        color: Colors.grey[300]),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
