import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/enums.dart';
import '../../../../domain/category/entity/category.dart';
import '../../../../domain/tournament/entity/tournament.dart';
import '../../../../service_locator/injection.dart';
import 'cubit/request_team_by_league_cubit.dart';

class RequestTeamByLeaguePage extends StatelessWidget {
  const RequestTeamByLeaguePage(
      {Key? key, required this.tournament, required this.category})
      : super(key: key);
  final Tournament tournament;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<RequestTeamByLeagueCubit>()
        ..getRequestTeamByLeague(tournamentId: tournament.tournamentId),
      child: BlocBuilder<RequestTeamByLeagueCubit, RequestTeamByLeagueState>(
        builder: (context, state) {
          if (state.screenStatus == BasicCubitScreenState.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: const Color(0xff358aac),
                size: 50,
              ),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.only(
                top: 5,
              ),
              itemCount: state.postsList.length,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.white38,
                  padding: const EdgeInsets.only(
                      right: 20, left: 12, top: 15, bottom: 15),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                      ),
                      child: Container(
                        width: 6.0,
                        height: 20.0,
                        color: const Color(0xff358aac),
                      ),
                    ),
                    title: Text(
                      "Equipo: ${state.postsList[index].name}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w900),
                    ),
                    subtitle: Text(
                      "${state.postsList[index].title}\n"
                          "${state.postsList[index].description}"
                    ),
                    onTap: () {
                      context
                          .read<RequestTeamByLeagueCubit>()
                          .onSelectPost(state.postsList[index], false);
                      showDialog(
                        context: context,
                        builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<RequestTeamByLeagueCubit>(
                              context),
                          child: _DialogContent(
                            tournament: tournament,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class _DialogContent extends StatelessWidget {
  const _DialogContent({Key? key, required this.tournament}) : super(key: key);
  final Tournament tournament;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestTeamByLeagueCubit, RequestTeamByLeagueState>(
      builder: (context, state) {
        final contactIfo = [
          ListTile(
            leading: const SizedBox(width: 80, child: Text('Contacto:')),
            title: Text(state.contactInfo.getFullName),
          ),
          ListTile(
            leading: const SizedBox(width: 80, child: Text('Teléfono:')),
            title: Text(state.contactInfo.getFormattedMainPhone),
          ),
          ListTile(
            leading: const SizedBox(width: 80, child: Text('Email:')),
            title: Text(state.contactInfo.getMainEmail),
          ),
        ];
        final items = [
          ListTile(
            leading: const SizedBox(width: 80, child: Text('Liga:')),
            title: Text(tournament.leagueId?.leagueName ?? ''),
          ),
          ListTile(
            leading: const SizedBox(width: 80, child: Text('Categoría:')),
            title: Text(tournament.categoryId?.categoryName ?? ''),
          ),
          ListTile(
            leading: const SizedBox(width: 80, child: Text('Equipo:')),
            title: Text(state.selectedPost.name),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15, top: 12),
            child: Text(
              'Descripción',
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 8, 15, 5),
            child: Text(state.selectedPost.description),
          ),
        ];
        return AlertDialog(
          title: Text(state.selectedPost.title),
          content: state.screenStatus == BasicCubitScreenState.validating
              ? const SizedBox(
                  height: 50,
                  child: Center(child: CircularProgressIndicator()),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: items,
                ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('ACEPTAR'))
          ],
        );
      },
    );
  }
}
