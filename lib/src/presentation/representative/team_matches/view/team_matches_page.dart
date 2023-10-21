import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/team_matches/cubit/team_matches_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/team_matches/view/team_matches_content.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';

class TeamMatchesPage extends StatelessWidget{
  const TeamMatchesPage({Key? key, required this.teamId}) : super(key: key);
  final teamId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
          create: (_) =>
          locator<TeamMatchesCubit>()..getMatchesByTeam(teamId: teamId),
          child: ListView(
            children: [
              const SizedBox(height: 15),
              TeamMatchesContent(teamId: teamId,),
            ],
          ),
        )
    );
  }
}
