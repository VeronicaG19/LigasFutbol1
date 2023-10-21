import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/teams/cubit/representative_teams_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/teams/view/representative_teams_content.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';

import '../../../app/app.dart';

class RepresentativeTeamsPage extends StatelessWidget {
  const RepresentativeTeamsPage({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (_) => const RepresentativeTeamsPage());

  @override
  Widget build(BuildContext context) {
    final personId =
        context.read<AuthenticationBloc>().state.user.person.personId;
    return BlocProvider(
      create: (_) => locator<RepresentativeTeamsCubit>()
        ..getRepresentativeTeams(personId: personId!),
      child: const RepresentativeTeamsContent(),
    );
  }
}
