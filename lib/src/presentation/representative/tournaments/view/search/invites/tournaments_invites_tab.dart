import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/tournaments/cubit/tournaments_invitations/tournaments_invitations_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/tournaments/view/search/invites/tournaments_invitations_list.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TournamentsInvitesTab extends StatelessWidget {
  TournamentsInvitesTab({super.key, required this.teamId});

  final int? teamId;

  final header = Container(
    color: Colors.white,
    height: 90.0,
    child: Container(
      margin: const EdgeInsets.only(top: 20.0, bottom: 15.0),
      child: Center(
        child: Text(
          "Invitaciones a torneos",
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    ),
  );

  final message_empty_list = Container(
    padding: const EdgeInsets.only(top: 50.0),
    child: const Center(
      child: Text(
        "No hay invitaciones a torneos",
        style: TextStyle(fontSize: 20.0),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<TournamentsInvitationsCubit>()
        ..getAllTournamentsInvitations(teamId: teamId!),
      child: BlocConsumer<TournamentsInvitationsCubit,
          TournamentsInvitationsState>(
        listener: (context, state) {
          if (state.screenStatus == ScreenStatus.sendingResponse) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Enviando respuesta...'),
                ),
              );
          } else if (state.screenStatus == ScreenStatus.responseSended) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Se ha enviado la respuesta a la invitación'),
                ),
              );
          }
        },
        builder: (context, state) {
          if (state.screenStatus == ScreenStatus.loaded ||
              state.screenStatus == ScreenStatus.responseSended) {
            return Stack(
              children: [
                (state.invitationsList.isEmpty)
                    ? message_empty_list
                    : TournamentsInvitationsList(teamId: teamId,),
                header,
              ],
            );
          } else {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.blue[800]!,
                size: 50,
              ),
            );
          }
        },
      ),
    );
  }
}
