import 'package:flutter/material.dart';
import 'tournament_list.dart';

class TournamentsPage extends StatelessWidget {
  const TournamentsPage({Key? key, this.teamId}) : super(key: key);

  final int? teamId;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TournamentList(teamId: teamId!),
      ],
    );
  }
}
