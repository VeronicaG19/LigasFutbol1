import 'package:flutter/material.dart';

import '../../../../../domain/tournament/entity/tournament.dart';
import 'matchs_roles_page.dart';

class MatchRolesMain extends StatelessWidget {
  final Tournament tournament;

  const MatchRolesMain({super.key, required this.tournament});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Roles'),
      ),
      body: MatchsRolesPage(
        tournament: tournament,
      ),
    );
  }
}
