import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/cubit/events/events_cubit.dart';

import '../../../../match_events_list/view/match_events_list_page.dart';

class SeeEventsButton extends StatelessWidget {
  const SeeEventsButton(
      {super.key,
      required this.teamMatchId,
      required this.teamMatchId2,
      required this.teamName,
      required this.teamName2,
      required this.matchId});

  final int teamMatchId;
  final int teamMatchId2;
  final String teamName;
  final String teamName2;
  final int matchId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MatchEventsListPage(
                              teamMatchId: teamMatchId ?? 0,
                              teamName: teamName ?? '',
                              matchId: matchId,
                              teamName2: teamName2,
                              teamMatchId2: teamMatchId2,
                            )));
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Text(
                  'Ver eventos',
                  style: TextStyle(
                    fontFamily: 'SF Pro',
                    color: Colors.grey[200],
                    fontWeight: FontWeight.w500,
                    fontSize: 10.0,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
