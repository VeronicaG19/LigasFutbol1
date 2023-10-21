import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/tournament/entity/tournament.dart';
import '../../lm_tournament_v2/main_page/cubit/tournament_main_cubit.dart';
import 'matchs_l_roles_page.dart';

class MatchLRolesMain extends StatelessWidget {
  const MatchLRolesMain({super.key, required this.tournament});

  static Route route(
          final TournamentMainCubit cubit, final Tournament tournament) =>
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: MatchLRolesMain(tournament: tournament),
        ),
      );

  final Tournament tournament;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear partidos de liguilla ${tournament.tournamentName}'),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        flexibleSpace: const Image(
          image: AssetImage('assets/images/imageAppBar25.png'),
          fit: BoxFit.fitWidth,
        ),
        elevation: 0.0,
      ),
      body: MatchesLRolesPage(tournament: tournament),
    );
  }
}
