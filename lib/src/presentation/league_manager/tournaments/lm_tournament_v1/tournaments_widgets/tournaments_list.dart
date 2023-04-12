import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../cubit/tournament_cubit.dart';

class TournamentsList extends StatelessWidget {
  const TournamentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentCubit, TournamentState>(
      builder: (context, state) {
        if (state.screenStatus == ScreenStatus.tournamentLoading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: Colors.blue[800]!,
              size: 50,
            ),
          );
        } else if (state.screenStatus == ScreenStatus.tournamentLoaded ||
            state.screenStatus == ScreenStatus.changedTournament) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.tournaments.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      onTap: () => context
                          .read<TournamentCubit>()
                          .getTournamentDetail(
                              tournamentId:
                                  state.tournaments[index].tournamentId!),
                      leading: const Icon(
                        Icons.add_to_photos_rounded,
                        color: Colors.amber,
                      ),
                      title: Text(state.tournaments[index].tournamentName!),
                      subtitle: Text(
                          state.tournaments[index].categoryId!.categoryName),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
