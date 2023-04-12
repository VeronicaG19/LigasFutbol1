import 'package:flutter/material.dart';
import '../../../../../../domain/tournament/dto/tournament_by_team/tournament_by_team_dto.dart';

class TournamentInformationTab extends StatelessWidget {
  TournamentByTeamDTO tournamentEntity;

  TournamentInformationTab({
    super.key,
    required this.tournamentEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _InfoSection(
              infoTitle: 'Nombre del Torneo:',
              infoData: '${tournamentEntity.tournament?.tournamentName}',
            ),
            _InfoSection(
              infoTitle: 'Tipo de torneo:',
              infoData: '${tournamentEntity.typeTournament}',
            ),
          ],
        ),
        Row(
          children: [
            _InfoSection(
              infoTitle: 'Categoria:',
              infoData: '${tournamentEntity.tournament?.categoryId?.categoryName}',
            ),
            _InfoSection(
              infoTitle: 'Tipo de juego:',
              infoData: '${tournamentEntity.typeOfGame}',
            ),
          ],
        ),
        Row(
          children: [
            _InfoSection(
              infoTitle: 'Tiempo(s) totales:',
              infoData:
              '${tournamentEntity.tournament?.gameTimes}',
            ),
            _InfoSection(
              infoTitle: 'Duración de tiempo:',
              infoData:
                  '${tournamentEntity.tournament?.durationByTime}',
            ),
          ],
        ),
        Row(
          children: [
            _InfoSection(
              infoTitle: 'Multa por tarjeta amarilla:',
              infoData: '${tournamentEntity.tournament?.categoryId?.yellowForPunishment}',
            ),
            _InfoSection(
              infoTitle: 'Multa por tarjeta roja:',
              infoData: '${tournamentEntity.tournament?.categoryId?.redForPunishment}',
            ),
          ],
        ),
        Row(
          children: [
            _InfoSection(
              infoTitle: 'Cambios por juego:',
              infoData: '${tournamentEntity.tournament?.gameChanges ?? ''}',
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoSection extends StatelessWidget {
  _InfoSection({
    Key? key,
    required this.infoTitle,
    required this.infoData,
  }) : super(key: key);

  String infoTitle;
  String infoData;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 30, left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(infoTitle),
            Text(
              infoData,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
