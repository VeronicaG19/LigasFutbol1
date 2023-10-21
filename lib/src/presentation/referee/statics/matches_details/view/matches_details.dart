import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../core/enums.dart';
import '../../../../../domain/match_event/dto/referee_match_event/matches_referee_stats.dart';
import '../../../../../service_locator/injection.dart';
import '../cubit/matches_details_cubit.dart';

class MatchesStaticsDetails extends StatelessWidget {
  const MatchesStaticsDetails({Key? key, required this.match})
      : super(key: key);

  static Route route(final MatchesRefereeStats match) => MaterialPageRoute(
        builder: (_) => MatchesStaticsDetails(match: match),
      );

  final MatchesRefereeStats match;

  Widget _selectLeadingIcon(String eventType) {
    switch (eventType.toLowerCase()) {
      case 'gol':
        return Image.asset(
          'assets/images/equipo2.png',
          width: 32,
        );
      case 'tarjeta amarilla':
        return Icon(
          Icons.style,
          size: 32,
          color: Colors.yellow[700],
        );
      case 'tarjeta roja':
        return const Icon(
          Icons.style,
          size: 32,
          color: Colors.red,
        );
      default:
        return Image.asset(
          'assets/images/equipo.png',
          width: 32,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          locator<MatchesDetailsCubit>()..onLoadInitialData(match.matchId),
      child: Scaffold(
        appBar: AppBar(
          title: Text('${match.teamLocal} VS ${match.teamVisit}'),
          flexibleSpace: const Image(
            image: AssetImage('assets/images/imageAppBar25.png'),
            fit: BoxFit.cover,
          ),
          elevation: 0.0,
        ),
        body: BlocBuilder<MatchesDetailsCubit, MatchesDetailsState>(
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
            if (state.matchDetail.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Sin eventos que mostrar'),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextButton(
                      onPressed:
                          context.read<MatchesDetailsCubit>().onLoadMatchDetail,
                      child: const Text('REINTENTAR'),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final event = state.matchDetail[index];
                  return ListTile(
                    leading: _selectLeadingIcon(event.eventType ?? ''),
                    title: Text(event.fullName ?? ''),
                    subtitle: Text(event.eventType ?? ''),
                    trailing: Text('Minuto ${event.matchEventTime ?? '00:00'}'),
                  );
                },
                itemCount: state.matchDetail.length,
              );
            }
          },
        ),
      ),
    );
  }
}
