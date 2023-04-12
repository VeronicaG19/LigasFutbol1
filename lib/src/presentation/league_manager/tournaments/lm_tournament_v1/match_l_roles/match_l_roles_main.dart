import 'package:flutter/material.dart';

import '../../../../../domain/tournament/entity/tournament.dart';
import 'matchs_l_roles_page.dart';

class MatchLRolesMain extends StatelessWidget {
  final Tournament tournament;
  final String rondaL;

  const MatchLRolesMain({super.key, required this.tournament, required this.rondaL});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear partidos de liguilla'),
      ),
      body: MatchsLRolesPage(
        tournament: tournament, seccion: rondaL,
      ),
    );
  }
}
