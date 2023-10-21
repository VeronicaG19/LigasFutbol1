import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/qualification/dto/rating_topics/rating_topics_dto.dart';
import '../../../../../service_locator/injection.dart';
import '../../../../widgets/rating_card.dart';
import '../bloc/rating_detail_bloc.dart';

class MatchRatingDetails extends StatelessWidget {
  const MatchRatingDetails(
      {Key? key, required this.matchId, required this.topic})
      : super(key: key);
  final int matchId;
  final RatingTopicsDTO topic;

  static Route route({required int matchId, required RatingTopicsDTO topic}) =>
      MaterialPageRoute(
        builder: (_) => MatchRatingDetails(matchId: matchId, topic: topic),
      );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (_) => locator<RatingDetailBloc>()
        ..add(RatingDetailEvent.started(matchId ?? 0, topic.typeEvaluation)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            //  '${topic.topic} en ${match.localTeam} vs ${match.teamVisit} del ${match.dateMatch}',
            '${topic.description} ',
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
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: size.width * 0.10, vertical: 7),
          child: BlocBuilder<RatingDetailBloc, RatingDetailState>(
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
                        onPressed: () => context.read<RatingDetailBloc>().add(
                            RatingDetailEvent.started(
                                matchId ?? 0, topic.typeEvaluation)),
                        child: const Text('RECARGAR'),
                      ),
                    ],
                  ),
                ),
                ratingsLoaded: (ratings) => ListView.builder(
                    itemBuilder: (context, index) {
                      final rating = ratings[index];
                      return RatingCard(
                        title: rating.nameEvaluator ?? 'Calificación',
                        rating: rating.rating ?? 0,
                        description: rating.comments,
                        subTitle: 'Reseña hecha a ${rating.nameEvaluated}',
                        trailing: '(Reseña de ${rating.getEvaluation})',
                      );
                    },
                    itemCount: ratings.length),
              );
            },
          ),
        ),
      ),
    );
  }
}
