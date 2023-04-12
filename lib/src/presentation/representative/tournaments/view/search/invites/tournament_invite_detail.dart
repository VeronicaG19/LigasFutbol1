import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/tournaments/cubit/tournaments_invitations/tournaments_invitations_cubit.dart';
import 'package:ligas_futbol_flutter/src/domain/user_requests/entity/user_requests.dart';

class TournamentInviteDetail extends StatelessWidget {
  UserRequests data;
  int? teamId;
  TournamentInviteDetail({super.key, required this.data, required this.teamId});

  @override
  Widget build(BuildContext context) {
    final title = Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: const Center(
        child: Text(
          "Invitación al torneo",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
        ),
      ),
    );

    final subTitle = Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Center(
        child: Text(
          data.requestMadeBy,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
      ),
    );

    final category = Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: RichText(
        text: TextSpan(
          text: "Categoría: ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          children: <TextSpan>[
            TextSpan(
              text: data.requestTo,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );

    final back = InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.only(
          top: 5.0,
          bottom: 5.0,
          right: 15.0,
          left: 15.0,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3.0),
            border: Border.all(color: Colors.black, width: 1.0)),
        child: Row(
          children: const [
            //Icon(Icons.arrow_back),
            Text("Regresar")
          ],
        ),
      ),
    );

    return BlocBuilder<TournamentsInvitationsCubit,
        TournamentsInvitationsState>(
      builder: (context, state) {
        return AlertDialog(
          content: Container(
            height: 200.0,
            child: Column(
              children: [title, subTitle, category],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                back,
                InkWell(
                  onTap: () {
                    context
                        .read<TournamentsInvitationsCubit>()
                        .cancelUserRequest(requestId: data.requestId, teamId: teamId!);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 5.0,
                      bottom: 5.0,
                      right: 15.0,
                      left: 15.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    child: Row(
                      children: const [
                        Text("Cancelar", style: TextStyle(color: Colors.white)),
                        //Icon(Icons.check, color: Colors.white)
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
