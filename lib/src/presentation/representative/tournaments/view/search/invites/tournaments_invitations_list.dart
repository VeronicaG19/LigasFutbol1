import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/tournaments/cubit/tournaments_invitations/tournaments_invitations_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/tournaments/view/search/invites/tournament_invite.dart';
import 'package:ligas_futbol_flutter/src/presentation/splash/responsive_widget.dart';

class TournamentsInvitationsList extends StatelessWidget {
  const TournamentsInvitationsList({super.key, this.teamId});
  final int? teamId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentsInvitationsCubit,
        TournamentsInvitationsState>(
      builder: (context, state) {
        return GridView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(
              top: 100.0, right: 15.0, left: 15.0, bottom: 20.0),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: ResponsiveWidget.getMaxCrossAxisExtent(context),
            childAspectRatio: 1.2 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
          ),
          itemCount: state.invitationsList.length,
          itemBuilder: (context, index) =>
              TournamentInvite(
                data: state.invitationsList[index],
                teamId: teamId,
              ),
        );
      },
    );
  }
}
