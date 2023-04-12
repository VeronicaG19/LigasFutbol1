import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/tournaments/cubit/tournaments_invitations/tournaments_invitations_cubit.dart';
import 'package:ligas_futbol_flutter/src/domain/user_requests/entity/user_requests.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/tournaments/view/search/invites/tournament_invite_detail.dart';

class TournamentInvite extends StatelessWidget {
  TournamentInvite({super.key, required this.data, this.teamId});
  UserRequests data;
  final int? teamId;

  @override
  Widget build(BuildContext context) {
    final cardIcon = Expanded(
      flex: 3,
      child: CircleAvatar(
        backgroundColor: Colors.grey[100],
        child: Image.asset(
          'assets/images/equipo2.png',
          width: 60,
          height: 60,
        ),
      ),
    );

    final cardDataTitle = Expanded(
      child: Text(
        data.requestMadeBy,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.cyan,
        ),
      ),
    );

    final cardDataCategory = Expanded(
      child: RichText(
        text: TextSpan(
          text: "Categoria: ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.cyan,
          ),
          children: <TextSpan>[
            TextSpan(
              text: data.requestTo,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.cyan,
              ),
            )
          ],
        ),
      ),
    );

    return InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (_) {
          final exampleCubit = context.read<TournamentsInvitationsCubit>();
          return BlocProvider<TournamentsInvitationsCubit>.value(
              value: exampleCubit,
              child: TournamentInviteDetail(data: data, teamId: teamId,)
          );
        },
      ),
      child: Card(
        color: Colors.white,
        elevation: 3.0,
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [cardIcon, cardDataTitle, cardDataCategory],
          ),
        ),
      ),
    );
  }
}
