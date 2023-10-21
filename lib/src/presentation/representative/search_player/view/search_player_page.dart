import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/soccer_team/players/data_player/data_player_content.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../cubit/search_player_cubit.dart';

class SearchPlayerPage extends StatelessWidget {
  const SearchPlayerPage({Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute(
        builder: (_) => const SearchPlayerPage(),
      );

  @override
  Widget build(BuildContext context) {
    // final user = context.read<AuthenticationBloc>().state.user.person.personId;
    final teamId = context.read<AuthenticationBloc>().state.selectedTeam.teamId;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: const Text(
          'Buscar jugadores',
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
        flexibleSpace: const Image(
          image: AssetImage('assets/images/imageAppBar25.png'),
          fit: BoxFit.cover,
        ),
        elevation: 0.0,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(130),
          child: Column(
            children: [
              DataPlayerContent(),
            ],
          ),
        ),
      ),
      body: BlocProvider(
        create: (_) => locator<SearchPlayerCubit>()..initPage(teamId: teamId!),
        child: const _PageContent(),
      ),
      /*body: Container(
        child: _PageContent(),
      ),*/
    );
  }
}

class _PageContent extends StatelessWidget {
  const _PageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final person = context.select((AuthenticationBloc bloc) => bloc.state.user.person);

    return Stack(
      clipBehavior: Clip.hardEdge,
      alignment: AlignmentDirectional.bottomEnd,
      fit: StackFit.loose,
      children: [
        BlocConsumer<SearchPlayerCubit, SearchPlayerState>(
          listener: (context, state) {
            if (state.screenStatus == ScreenStatus.error) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.msm),
                  ),
                );
            } else if (state.screenStatus == ScreenStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Se ha enviado una solicitud correctamente')));
              /*  ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text('Buscar jugadores'),
            ),
          );*/
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
            } else {
              return ListView(
                shrinkWrap: true,
                children: [
                  const SearchBarPlayer(),
                  state.noMatches
                      ? const _NoMatches()
                      : const SizedBox(height: 0),
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
                      itemCount: state.listPlayers.length,
                      physics: const NeverScrollableScrollPhysics(),
                      //physics: const ScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          child: Card(
                            color: Colors.grey[100],
                            elevation: 3.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '${state.listPlayers[index].fullName}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            showModalBottomSheet<void>(
                              context: context,
                              isScrollControlled: true,
                              builder: (_) {
                                return Container(
                                  height: 300,
                                  color:
                                      const Color.fromARGB(255, 236, 236, 236),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Text(
                                        '¿Desea enviar invitación al jugador ${state.listPlayers[index].fullName}?',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 50,
                                          right: 12,
                                          left: 12,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                    16.0,
                                                    10.0,
                                                    16.0,
                                                    10.0,
                                                  ),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xff740411),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(15.0),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'Salir',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'SF Pro',
                                                      color: Colors.grey[200],
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 10.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: TextButton(
                                                onPressed: () {
                                                  context
                                                      .read<SearchPlayerCubit>()
                                                      .onSendTeamToPlayerRequest(
                                                          state
                                                                  .listPlayers[
                                                                      index]
                                                                  .playerId ??
                                                              0,
                                                          context
                                                                  .read<
                                                                      AuthenticationBloc>()
                                                                  .state
                                                                  .selectedTeam
                                                                  .teamId ??
                                                              0);

                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          16.0,
                                                          10.0,
                                                          16.0,
                                                          10.0),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xff045a74),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(15.0),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'Enviar invitación',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'SF Pro',
                                                      color: Colors.grey[200],
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 10.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
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
              );
            }
          },
        ),
        BlocBuilder<SearchPlayerCubit, SearchPlayerState>(
          builder: (context, state) {
            return Container(
              height: 40.0,
              color: Colors.blueGrey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: state.screenStatus == ScreenStatus.loading
                        ? null
                        : context.read<SearchPlayerCubit>().goToFirstPage,
                    icon: const Icon(Icons.keyboard_double_arrow_left),
                  ),
                  IconButton(
                    onPressed: state.screenStatus == ScreenStatus.loading
                        ? null
                        : context.read<SearchPlayerCubit>().onPreviousPage,
                    icon: const Icon(Icons.keyboard_arrow_left),
                  ),
                  Text(
                    '${state.playerPageable.number + 1}/${state.playerPageable.totalPages}',
                  ),
                  IconButton(
                    onPressed: state.screenStatus == ScreenStatus.loading
                        ? null
                        : context.read<SearchPlayerCubit>().onNextPage,
                    icon: const Icon(Icons.keyboard_arrow_right),
                  ),
                  IconButton(
                    onPressed: state.screenStatus == ScreenStatus.loading
                        ? null
                        : context.read<SearchPlayerCubit>().goToLastPage,
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

class SearchBarPlayer extends StatelessWidget {
  const SearchBarPlayer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPlayerCubit, SearchPlayerState>(
        builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 18.0),
        child: TextField(
          onChanged: context.read<SearchPlayerCubit>().onFilterList,
          decoration: InputDecoration(
            labelText: 'Buscar por nombre de jugador',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: GestureDetector(
              child: const Icon(Icons.format_list_bulleted),
              onTap: () {
                //  showDialog(
                //               context: context,
                //               builder: (_) {
                //                 final exampleCubit =
                //                     context.read<SearchTeamCubit>();
                //                 return BlocProvider<
                //                         SearchTeamCubit>.value(
                //                     value: exampleCubit,
                //                     child: FiltersModal(),);
                //               });
              },
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25.0),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _NoMatches extends StatelessWidget {
  const _NoMatches({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.amber,
        ),
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: Text("No se encontraron coincidencias"),
        ),
      ),
    );
  }
}
