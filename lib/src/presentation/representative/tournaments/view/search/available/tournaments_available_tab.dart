import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/tournaments/cubit/tournaments_available/tournaments_available_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/splash/responsive_widget.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:styled_widget/styled_widget.dart';
import 'tournament_available_list.dart';

class TournamentsAvailableTab extends StatelessWidget {
  TournamentsAvailableTab({super.key, required this.teamId});

  final int? teamId;

  final header = Container(
    color: Colors.white,
    height: 90.0,
    child: Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 20.0, bottom: 15.0),
            child: Center(
                child: Text(
              "Torneos abiertos",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ))),
        Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: Center(
            child: Text(
              "Seleccione el torneo al cual se quiere unir",
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade500,
              ),
            ),
          ),
        )
      ],
    ),
  );

  final message_empty_list = Container(
    padding: EdgeInsets.only(top: 200.0),
    child: Center(
      child: Column(
        children: const [
          Text(
            "No hay torneos disponibles",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
          ),
          Text(
            "seleccione otra opción",
            style: TextStyle(fontSize: 20.0),
          ),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          locator<TournamentsAvailableCubit>()..getAllLeagues(teamId: teamId),
      child: BlocConsumer<TournamentsAvailableCubit, TournamentsAvailableState>(
        listener: (context, state) {
          if (state.screenStatus == ScreenStatus.sendingRequest) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Enviando solicitud...'),
                ),
              );
          } else if (state.screenStatus == ScreenStatus.requestSend) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Se ha enviado la solicitud al equipo'),
                ),
              );
          }
        },
        builder: (context, state) {
          if (state.screenStatus == ScreenStatus.loaded ||
              state.screenStatus == ScreenStatus.availableTournamentsLoaded ||
              state.screenStatus == ScreenStatus.requestSend) {
            return Stack(
              children: [
                (state.tournamentsList.isEmpty)
                    ? message_empty_list
                    : TournamentAvailableList(teamId: teamId),
                Column(
                  children: [
                    header,
                    Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text(
                              "Buscar por liga: ",
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: DropdownButton<int>(
                              isExpanded: true,
                              icon: const Icon(Icons.search),
                              elevation: 10,
                              style: const TextStyle(
                                color: Color(0xFF00838F),
                              ),
                              underline: Container(
                                height: 2,
                                color: const Color(0xFF00838F),
                              ),
                              hint: const Text('Selecciona una liga'),
                              value: state.leaguesList[state.indexLeagueSelec!]
                                  .leagueId,
                              items: List.generate(
                                state.leaguesList.length,
                                (index) {
                                  final content =
                                      state.leaguesList[index].leagueName;
                                  return DropdownMenuItem(
                                    child: Text(
                                      content.trim().isEmpty
                                          ? '- selecciona una liga -'
                                          : content,
                                    ),
                                    value: state.leaguesList[index].leagueId,
                                  );
                                },
                              ),
                              onChanged: (value) {
                                int ind = state.leaguesList.indexWhere(
                                  (element) => element.leagueId == value,
                                );
                                context
                                    .read<TournamentsAvailableCubit>()
                                    .getTournamentsByTeamAndLeague(
                                        teamId: teamId!,
                                        leagueId: value,
                                        selectedIndex: ind);
                              },
                            ),
                          ),
                          Expanded(
                              flex: (ResponsiveWidget.isSmallScreen(context)
                                  ? 0
                                  : 1),
                              child: Text(""))
                        ],
                      ),
                    ),
                  ],
                )
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
