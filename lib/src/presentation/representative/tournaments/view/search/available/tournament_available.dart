import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/getOpenTournamentsInterface/get_open_tournaments_interface.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/tournaments/cubit/tournaments_available/tournaments_available_cubit.dart';
import 'tournament_available_detail.dart';

class TournamentAvailable extends StatelessWidget {
  GetOpenTournamentsInterface tournament;
  final int? teamId;

  TournamentAvailable({super.key, this.teamId, required this.tournament});

  @override
  Widget build(BuildContext context) {
    final cardIcon = Expanded(
      flex: 2,
      child: Container(
        alignment: Alignment.center,
        child: CircleAvatar(
          backgroundColor: Colors.grey[100],
          child: Image.asset(
            'assets/images/equipo2.png',
            width: 60,
            height: 60,
          ),
        ),
      ),
    );

    final cardDataTitle = Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Text(
          "${tournament.tournamentName}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.cyan,
          ),
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
              text: "${tournament.categoryName}",
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.cyan,
              ),
            )
          ],
        ),
      ),
    );

    final cardDataType = Expanded(
      child: RichText(
        text: TextSpan(
          text: "Tipo de torneo: ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.cyan,
          ),
          children: <TextSpan>[
            TextSpan(
              text: "${tournament.typeTournament}",
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.cyan,
              ),
            )
          ],
        ),
      ),
    );

    final cardDataDefinition = Expanded(
      child: RichText(
        text: TextSpan(
          text: "Forma de definición: ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.cyan,
          ),
          children: <TextSpan>[
            TextSpan(
              text: "${tournament.tyoeOfTournament}",
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
            final exampleCubit = context.read<TournamentsAvailableCubit>();
            return BlocProvider<TournamentsAvailableCubit>.value(
                value: exampleCubit,
                child: TournamentAvailableDetail(
                  teamId: teamId,
                  tournament: tournament,
                ));
          }),
      child: Card(
        color: Colors.white,
        elevation: 3.0,
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cardIcon,
              cardDataTitle,
              cardDataCategory,
              cardDataType,
              cardDataDefinition
            ],
          ),
        ),
      ),
    );
  }
}
