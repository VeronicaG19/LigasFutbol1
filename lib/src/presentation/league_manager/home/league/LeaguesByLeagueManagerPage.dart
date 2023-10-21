import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/home/league/widgets/delete_league_dialog.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/home/request/create_request_page.dart';

import '../../../app/bloc/authentication_bloc.dart';

class LeaguesByLeagueManagerPage extends StatelessWidget {
  const LeaguesByLeagueManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.managerLeagues);

    return ListView(
      children: [
        const ListTile(
          trailing: CreateRequestPage(),
        ),
        Column(children: <Widget>[
          //StatictsLeagueManager(),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: const Color(0xff0791a3),
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Liga",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Comentario",
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
                    "Acción",
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
        ListView.builder(
            shrinkWrap: true,
            itemCount: leagueManager.length,
            itemBuilder: (context, index) {
              return Column(children: [
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 6, top: 6),
                      color: Colors.grey[200],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              leagueManager[index].leagueName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              leagueManager[index].leagueDescription ?? '-',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              leagueManager[index].leagueStatus == '1'
                                  ? "Activa"
                                  : "Inactiva",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Icon(Icons.delete,
                                  size: 18, color: Colors.red[800]),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (dialogContext) {
                                    return DeleteLeagueDialog(
                                        nameLeague:
                                            leagueManager[index].leagueName,
                                        leagueId: leagueManager[index]);
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(indent: 1),
                  ],
                ),
              ]);
            })
      ],
    );
  }
}
