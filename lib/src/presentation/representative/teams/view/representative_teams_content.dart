import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../app/app.dart';
import '../../requests/request_new_team/view/request_new_team_page.dart';
import '../cubit/representative_teams_cubit.dart';

class RepresentativeTeamsContent extends StatelessWidget {
  const RepresentativeTeamsContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final teamManager = context.read<AuthenticationBloc>().state.selectedTeam;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.grey[200],
          title: Text(
            'Mis equipos',
            style:
                TextStyle(color: Colors.grey[200], fontWeight: FontWeight.w900),
          ),
          flexibleSpace: const Image(
            image: AssetImage('assets/images/imageAppBar25.png'),
            fit: BoxFit.cover,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.push(context, RequestNewTeamPage() as Route<Object?>);
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Text(
                  'Agregar',
                  style: TextStyle(
                    fontFamily: 'SF Pro',
                    color: Colors.grey[200],
                    fontWeight: FontWeight.w500,
                    fontSize: 10.0,
                  ),
                ),
              ),
            ),
          ],
          elevation: 0.0,
        ),
      ),
      body: BlocBuilder<RepresentativeTeamsCubit, RepresentativeTeamsState>(
        builder: (context, state) {
          if (state.screenStatus == ScreenStatus.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: const Color(0xff358aac),
                size: 50,
              ),
            );
          }
          return state.teamList.isNotEmpty
              ? ListView.builder(
                  itemCount: state.teamList.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.all(15),
                      elevation: 5,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            contentPadding:
                                const EdgeInsets.fromLTRB(15, 10, 25, 0),
                            title: Text(
                              state.teamList[index].teamName!,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900),
                            ),
                            subtitle: Text(
                              'Liga: ${state.teamList[index].leagueIdAux?.leagueName ?? '-'}\n'
                              'Categoría: ${state.teamList[index].categoryId?.categoryName ?? '-'}',
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey[100],
                              backgroundImage:
                                  state.teamList[index].logoId?.document == null
                                      ? const AssetImage(
                                          'assets/images/equipo2.png')
                                      : Image.memory(
                                          base64Decode(state
                                              .teamList[index].logoId!.document
                                              .toString()),
                                        ).image,
                            ),
                          ),
                          if (teamManager.teamId !=
                              state.teamList[index].teamId)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      context.read<AuthenticationBloc>().add(
                                          ChangeTeamManagerTeamEvent(
                                              state.teamList[index]));
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cambiar'))
                              ],
                            )
                        ],
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text('No tiene equipos creados'),
                );
        },
      ),
    );
  }
}
