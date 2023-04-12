import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/getOpenTournamentsInterface/get_open_tournaments_interface.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/tournaments/cubit/tournaments_available/tournaments_available_cubit.dart';

class TournamentAvailableDetail extends StatelessWidget {
  GetOpenTournamentsInterface tournament;
  final int? teamId;

  TournamentAvailableDetail({super.key, this.teamId, required this.tournament});

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;

    const title = Expanded(
      flex: 1,
      child: Center(
        child: Text(
          'Detalle de torneo',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
        ),
      ),
    );

    final subTitle = Expanded(
      flex: 1,
      child: Center(
        child: Text(
          '${tournament.tournamentName}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
      ),
    );

    final category = Expanded(
      flex: 1,
      child: RichText(
        text: TextSpan(
          text: 'Categoría: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          children: <TextSpan>[
            TextSpan(
              text: tournament.categoryName,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );

    final gameType = Expanded(
      flex: 1,
      child: RichText(
        text: TextSpan(
          text: 'Tipo de juego: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          children: <TextSpan>[
            TextSpan(
              text: '${tournament.typeTournament}',
              style: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );

    final definition = Expanded(
      flex: 1,
      child: RichText(
        text: TextSpan(
          text: 'Definición por: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          children: <TextSpan>[
            TextSpan(
              text: '${tournament.tyoeOfTournament}',
              style: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );

    final players = Expanded(
      flex: 1,
      child: RichText(
        text: TextSpan(
          text: 'Jugadores: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          children: <TextSpan>[
            TextSpan(
              text: '${tournament.numberPlayers}',
              style: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );

    final time = Expanded(
      flex: 1,
      child: RichText(
        text: TextSpan(
          text: 'Tiempos por juego: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          children: <TextSpan>[
            TextSpan(
              text: '${tournament.timesByGame}',
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
        padding:
            EdgeInsets.only(top: 5.0, bottom: 5.0, right: 15.0, left: 15.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3.0),
            border: Border.all(color: Colors.black, width: 1.0)),
        child: Row(
          children: [Icon(Icons.arrow_back), Text('Regresar')],
        ),
      ),
    );

    return BlocBuilder<TournamentsAvailableCubit, TournamentsAvailableState>(
      builder: (ctxt, state) {
        return AlertDialog(
          content: Container(
            height: (heightScreen / 100 * 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title,
                subTitle,
                category,
                gameType,
                definition,
                players,
                time
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                back,
                InkWell(
                  onTap: () {
                    ctxt
                        .read<TournamentsAvailableCubit>()
                        .sendTournamentRegistrationRequest(
                          tournamentId: tournament.tournamentId!,
                          teamId: teamId!,
                        );
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 5.0, bottom: 5.0, right: 15.0, left: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.green.shade600,
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    child: Row(
                      children: [
                        Text('Inscribirse',
                            style: TextStyle(color: Colors.white)),
                        Icon(Icons.check, color: Colors.white)
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
