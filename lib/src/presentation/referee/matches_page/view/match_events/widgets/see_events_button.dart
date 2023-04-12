import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/cubit/events/events_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/view/match_events/widgets/button_custom.dart';
import '../../../../match_events_list/view/match_events_list_page.dart';

class SeeEventsButton extends StatelessWidget {
  const SeeEventsButton({
    super.key,
    required this.teamMatchId,
    required this.teamName,
  });

  final int teamMatchId;
  final String teamName;

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
                            )));
              },
              child: ButtonCustom(
                textBtn: ' Eventos',
                iconBtn: Icons.list_outlined,
                fontColor: Colors.white,
                backgroundColor: Colors.cyan.shade700,
                isOutline: true,
              ),
            ),
          ],
        );
      },
    );
  }
}
