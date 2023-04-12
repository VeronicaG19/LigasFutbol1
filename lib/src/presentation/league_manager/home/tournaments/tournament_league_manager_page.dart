import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/home/tournaments/table_tournaments_lm.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/tournaments/lm_tournament_v1/create_tournaments/create_tournament_page.dart';

import '../../../app/app.dart';
import '../request/create_request_page.dart';
import '../widget/Staticts_League_Manager.dart';

class TournamentLeagueManegerPage extends StatelessWidget {
  const TournamentLeagueManegerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.leagueManager);
    return ListView(children: [
      Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            /*  TextButton(
              //onPressed: () => Navigator.pop(dialogContext),
              onPressed: () {},
              child: Container(
                padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                decoration: const BoxDecoration(
                  color: Color(0xff0791a3),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                height: 35,
                width: 150,
                child: Text(
                  'Ver estadisticas',
                  style: TextStyle(
                    fontFamily: 'SF Pro',
                    color: Colors.grey[200],
                    fontWeight: FontWeight.w500,
                    fontSize: 13.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),*/
            TextButton(
              //onPressed: () => Navigator.pop(dialogContext),
              onPressed: () {
                final response = Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateTournamentPage(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                decoration: const BoxDecoration(
                  color: Color(0xff0791a3),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                height: 35,
                width: 150,
                child: Text(
                  'Crear torneo',
                  style: TextStyle(
                    fontFamily: 'SF Pro',
                    color: Colors.grey[200],
                    fontWeight: FontWeight.w500,
                    fontSize: 13.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const CreateRequestPage()
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 15, bottom: 15),
          child: StatictsLeagueManager(),
        ),
        Column(children: <Widget>[
          //StatictsLeagueManager(),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Color(0xff0791a3),
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Torneo",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Categoría",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Número de equipos",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Fecha de inicio",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Estado",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Visibilidad",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ]),
      const TableTournamentLm(),
    ]);
  }
}
