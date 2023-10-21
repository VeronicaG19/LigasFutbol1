import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/home/tournaments/cubit/tournament_lm_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../app/app.dart';
import '../widget/report_tournaments.dart';

class TableTournamentLm extends StatelessWidget {
  const TableTournamentLm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);

    return BlocBuilder<TournamentLmCubit, TournamentLmState>(
        builder: (context, state) {
      if (state.screenStatus == ScreenStatus.loading) {
        return Center(
          child: LoadingAnimationWidget.fourRotatingDots(
            color: const Color(0xff358aac),
            size: 20,
          ),
        );
      } else if (state.screenStatus == ScreenStatus.loaded) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: state.tournamentList.length,
            itemBuilder: (context, index) {
              return Column(children: [
                ReportTournament(
                    torneo: "${state.tournamentList[index].tournamentName}",
                    categoria:
                        "${state.tournamentList[index].categoryId?.categoryName}",
                    //modalidad: "${state.tournamentList[index].typeOfGame}",
                    nEquipos: state.tournamentList[index].maxTeams ?? 0,
                    fecha:
                        "${state.tournamentList[index].inscriptionDate ?? '-'}",
                    estado: "${state.tournamentList[index].statusBegin}",
                    visibilidad:
                        "${state.tournamentList[index].tournamentPrivacy}"),
              ]);
            });
      } else {
        return Container();
      }
    });
  }
}
