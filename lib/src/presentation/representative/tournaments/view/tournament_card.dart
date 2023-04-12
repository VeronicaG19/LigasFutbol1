import 'package:flutter/material.dart';
import '../../../../domain/tournament/dto/tournament_by_team/tournament_by_team_dto.dart';
import 'detail/tournament_detail_page.dart';

class TournamentCard extends StatelessWidget {
  TournamentByTeamDTO tournamentEntity;
  //LookUpValue footballType;
   TournamentCard({Key? key, required this.tournamentEntity}) : super(key: key);

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
          tournamentEntity.tournament?.tournamentName ?? '',
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
              text: tournamentEntity.tournament?.categoryId?.categoryName,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.cyan,
              ),
            )
          ],
        ),
      ),
    );

    final cardDataLeague = Expanded(
      child: RichText(
        text: TextSpan(
          text: "Liga: ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.cyan,
          ),
          children: <TextSpan>[

            TextSpan(
              text: tournamentEntity.tournament?.leagueId?.leagueName,
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TournamentDetailPage(
              tournamentEntity: tournamentEntity,
            ),
          ),
        );
      },
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
              cardDataLeague,
            ],
          ),
        ),
      ),
    );
  }
}
