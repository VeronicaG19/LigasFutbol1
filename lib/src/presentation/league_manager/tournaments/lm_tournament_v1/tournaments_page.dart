import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/tournaments/lm_tournament_v1/tournament_config_main.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/tournaments/lm_tournament_v1/tournaments_widgets/select_tournament_widget.dart';

import '../../../../service_locator/injection.dart';
import '../../../app/bloc/authentication_bloc.dart';
import 'cubit/tournament_cubit.dart';

class TournamenMainPage extends StatefulWidget {
  @override
  _TournamenMainPageState createState() => _TournamenMainPageState();
}

class _TournamenMainPageState extends State<TournamenMainPage> {
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (_) => locator<TournamentCubit>(),
        child: BlocConsumer<TournamentCubit, TournamentState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state.screenStatus == ScreenStatus.loaded ||
                  state.screenStatus == ScreenStatus.tournamentLoaded ||
                  state.screenStatus == ScreenStatus.changedTournament) {
                return Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: Container(
                            width: MediaQuery.of(context).size.width * 49,
                            child: const SelectTournamentWidget())),
                    Flexible(
                        flex: 2,
                        child: Card(
                            color: Colors.grey[200],
                            child: TournamentConfigMain())),
                  ],
                );
              } else {
                return Container();
              }
            })
        /* Container(
        child: SelectTournamentWiget(),
      ),*/
        );
  }
}
