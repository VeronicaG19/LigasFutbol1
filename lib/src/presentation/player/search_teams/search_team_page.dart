import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/enums.dart';
import '../../../domain/team/entity/team.dart';
import '../../../service_locator/injection.dart';
import '../soccer_team/players/team_players/team_player_page.dart';
import 'cubit/search_team_cubit.dart';
import 'filters_modal.dart';

class SearchTeamPage extends StatelessWidget {
  const SearchTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<SearchTeamCubit>()..getTeams(),
      child: const _PageContent(),
    );
  }
}

class _PageContent extends StatelessWidget {
  const _PageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      alignment: AlignmentDirectional.bottomEnd,
      fit: StackFit.loose,
      children: [
        BlocBuilder<SearchTeamCubit, SearchTeamState>(
          builder: (context, state) {
            if (state.screenState == BasicCubitScreenState.loading) {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: const Color(0xff358aac),
                  size: 50,
                ),
              );
            }
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 18.0),
                  child: TextField(
                    onChanged: context.read<SearchTeamCubit>().onFilterList,
                    decoration: InputDecoration(
                      labelText: 'Buscar por nombre de equipo',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: GestureDetector(
                        child: const Icon(Icons.format_list_bulleted),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                final exampleCubit =
                                    context.read<SearchTeamCubit>();
                                return BlocProvider<SearchTeamCubit>.value(
                                    value: exampleCubit, child: FiltersModal());
                              });
                        },
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(
                      top: 15,
                      left: 15,
                      right: 15,
                      bottom: 65,
                    ),
                    itemCount: state.teamPageable.content.length,
                    physics: const NeverScrollableScrollPhysics(),
                    //physics: const ScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 2 / 3,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0),
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                        child: Card(
                          color: Colors.grey[100],
                          elevation: 3.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[100],
                                  child: Image.asset(
                                    'assets/images/equipo2.png',
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '${state.teamPageable.content[index].teamName}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  " ${state.teamPageable.content[index].categoryId?.categoryName ?? ''}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  " ${state.teamPageable.content[index].requestPlayers == 'Y' ? 'En busca de jugadores' : ''}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          final team = Team(
                            teamId: state.teamPageable.content[index].teamId!,
                            teamName:
                                state.teamPageable.content[index].teamName!,
                          );
                          Navigator.push(
                            context,
                            TeamPlayerPage.route(team: team),
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
        BlocBuilder<SearchTeamCubit, SearchTeamState>(
          builder: (context, state) {
            return Container(
              height: 40.0,
              color: Colors.blueGrey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed:
                        state.screenState == BasicCubitScreenState.loading
                            ? null
                            : context.read<SearchTeamCubit>().goToFirstPage,
                    icon: const Icon(Icons.keyboard_double_arrow_left),
                  ),
                  IconButton(
                    onPressed:
                        state.screenState == BasicCubitScreenState.loading
                            ? null
                            : context.read<SearchTeamCubit>().onPreviousPage,
                    icon: const Icon(Icons.keyboard_arrow_left),
                  ),
                  Text(
                      '${state.teamPageable.number + 1}/${state.teamPageable.totalPages}'),
                  IconButton(
                    onPressed:
                        state.screenState == BasicCubitScreenState.loading
                            ? null
                            : context.read<SearchTeamCubit>().onNextPage,
                    icon: const Icon(Icons.keyboard_arrow_right),
                  ),
                  IconButton(
                    onPressed:
                        state.screenState == BasicCubitScreenState.loading
                            ? null
                            : context.read<SearchTeamCubit>().goToLastPage,
                    icon: const Icon(Icons.keyboard_double_arrow_right),
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
