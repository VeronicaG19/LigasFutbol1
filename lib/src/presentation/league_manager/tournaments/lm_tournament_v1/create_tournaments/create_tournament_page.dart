import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/widgets/app_bar_page.dart';

import '../../../../../service_locator/injection.dart';
import '../../../../app/app.dart';
import 'crteate_tournament.dart';
import 'cubit/create_tournament_cubit.dart';

class CreateTournamentPage extends StatelessWidget {
  const CreateTournamentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leagueId =
        context.select((AuthenticationBloc bloc) => bloc.state.leagueManager);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBarPage(
          title: "Crear torneo",
          size: 100,
        ),
      ),
      body: BlocProvider(
        create: (context) => locator<CreateTournamentCubit>()
          ..getTypeTournaments(leagueId.leagueId),
        child: const CreateTournament(),
      ),
    );
  }
}
