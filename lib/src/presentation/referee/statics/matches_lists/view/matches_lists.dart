import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../domain/leagues/entity/league.dart';
import '../../../../../service_locator/injection.dart';
import '../../../../app/app.dart';
import '../../matches_details/view/matches_details.dart';
import '../cubit/matches_lists_cubit.dart';

class MatchesListsStats extends StatelessWidget {
  const MatchesListsStats(
      {Key? key, required this.league, required this.eventType})
      : super(key: key);

  static Route route(final League league, final RefereeEventType eventType) =>
      MaterialPageRoute(
        builder: (_) => MatchesListsStats(
          league: league,
          eventType: eventType,
        ),
      );

  final League league;
  final RefereeEventType eventType;

  @override
  Widget build(BuildContext context) {
    final referee =
        context.select((AuthenticationBloc bloc) => bloc.state.refereeData);
    return BlocProvider(
      create: (_) => locator<MatchesListsCubit>()
        ..onLoadInitialData(referee.refereeId, league.leagueId, eventType),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Partidos de la liga ${league.leagueName}'),
          flexibleSpace: const Image(
            image: AssetImage('assets/images/imageAppBar25.png'),
            fit: BoxFit.cover,
          ),
          elevation: 0.0,
        ),
        body: BlocBuilder<MatchesListsCubit, MatchesListsState>(
          buildWhen: (previous, current) =>
              previous.screenState != current.screenState,
          builder: (context, state) {
            if (state.screenState == BasicCubitScreenState.loading) {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.blue[800]!,
                  size: 50,
                ),
              );
            }
            if (state.matches.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Sin partidos que mostrar'),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextButton(
                      onPressed:
                          context.read<MatchesListsCubit>().onLoadMatchesList,
                      child: const Text('REINTENTAR'),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final match = state.matches[index];
                  return ListTile(
                    leading: Image.asset(
                      'assets/images/equipo.png',
                      width: 32,
                    ),
                    title: Text(
                        '${match.teamLocal} (${match.scoreLocal}) VS (${match.scoreVisit}) ${match.teamVisit}'),
                    subtitle: Text(
                        'Tarjetas amarillas ${match.tarjetaAmarillas}\nTarjetas rojas ${match.tarjetasRojas}'),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 32,
                    ),
                    onTap: () => Navigator.push(
                        context, MatchesStaticsDetails.route(match)),
                  );
                },
                itemCount: state.matches.length,
              );
            }
          },
        ),
      ),
    );
  }
}
