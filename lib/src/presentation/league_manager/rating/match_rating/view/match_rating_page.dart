import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/matches/dto/detail_rol_match_dto/detail_rol_match_DTO.dart';
import '../../../../../service_locator/injection.dart';
import '../../../../widgets/general_rating_card.dart';
import '../../rating_details/view/match_rating_details.dart';
import '../bloc/match_rating_bloc.dart';

class MatchRatingPage extends StatelessWidget {
  const MatchRatingPage({Key? key, required this.match}) : super(key: key);
  final DeatilRolMatchDTO match;

  static Route route({required DeatilRolMatchDTO match}) =>
      MaterialPageRoute(builder: (_) => MatchRatingPage(match: match));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<MatchRatingBloc>()
        ..add(MatchRatingEvent.started(match.matchId ?? 0)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Partido ${match.localTeam} VS ${match.teamVisit}',
            textAlign: TextAlign.center,
          ),
          centerTitle: false,
          backgroundColor: Colors.grey[200],
          flexibleSpace: const Image(
            image: AssetImage('assets/images/imageAppBar25.png'),
            fit: BoxFit.fitWidth,
          ),
          elevation: 0.0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 350,
              child: ListTile(
                title: const Text('Fecha del partido:'),
                trailing: Text(match.dateMatch ?? ''),
              ),
            ),
            SizedBox(
              width: 350,
              child: ListTile(
                title: const Text('Lugar del encuentro:'),
                trailing: Text(match.fieldMatch ?? ''),
              ),
            ),
            SizedBox(
              width: 350,
              child: ListTile(
                title: const Text('Árbitro del partido:'),
                trailing: Text(match.refereeName ?? ''),
              ),
            ),
            /*const HelpMeButton(
                iconData: Icons.help, tuto: TutorialType.qualifyLeagueManager),*/
            BlocBuilder<MatchRatingBloc, MatchRatingState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox(),
                  loading: () => const Padding(
                    padding: EdgeInsets.only(top: 85),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (error) => Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 185),
                          child: Text(error),
                        ),
                        TextButton(
                          onPressed: () => context.read<MatchRatingBloc>().add(
                              MatchRatingEvent.started(match.matchId ?? 0)),
                          child: const Text('RECARGAR'),
                        ),
                      ],
                    ),
                  ),
                  ratingsLoaded: (ratings) {
                    if (ratings.isEmpty) {
                      return const Center(
                        child: Text('No hay reseñas'),
                      );
                    } else {
                      return SingleChildScrollView(
                        child: GridView.count(
                          shrinkWrap: true,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          childAspectRatio: 1.9,
                          crossAxisCount: 4,
                          padding: const EdgeInsets.all(15.0),
                          children: List.generate(
                            ratings.length,
                            (index) => GeneralRatingCard(
                              title: ratings[index].description,
                              rating: ratings[index].rating,
                              onPressed: () => Navigator.push(
                                context,
                                MatchRatingDetails.route(
                                    matchId: match.matchId ?? 0,
                                    topic: ratings[index]),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
