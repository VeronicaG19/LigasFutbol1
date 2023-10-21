import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/presentation/widgets/qualification_to_topics/cubit/qualification_to_topics_cubit.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class QualificationToTopicsView extends StatelessWidget{
  const QualificationToTopicsView({super.key, required this.role});

  final Rolesnm role;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.grey[200],
          title: Text(
            'Evaluar',
            style:
            TextStyle(color: Colors.grey[200], fontWeight: FontWeight.w900),
          ),
          flexibleSpace: const Image(
            image: AssetImage('assets/images/imageAppBar25.png'),
            fit: BoxFit.cover,
          ),
          actions: const [],
          elevation: 0.0,
        ),
      ),
      body: Column(
        children: [
          if(role == Rolesnm.PLAYER)
            const _StarRating(topic: TypeTopic.PLAYER_TO_REFERE,),
          if(role == Rolesnm.PLAYER)
             const _StarRating(topic: TypeTopic.PLAYER_TO_FIELD,),
          if(role == Rolesnm.REFEREE)
            const _StarRating(topic: TypeTopic.REFEREE_TO_TEAM,),
          if(role == Rolesnm.REFEREE)
            const _StarRating(topic: TypeTopic.REFEREE_TO_FIELD,),
        ],
      ),
    );
  }
}

class _StarRating extends StatelessWidget{
  const _StarRating({required this.topic});
  final TypeTopic topic;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<QualificationToTopicsCubit>()
        ..getTopicsEvaluationByType(type: topic.name),
      child: BlocBuilder<QualificationToTopicsCubit, QualificationToTopicsState>(
        builder: (context, state){
          if (state.screenStatus == BasicCubitScreenState.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: const Color(0xff358aac),
                size: 50,
              ),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.listTopicsEvaluation.length,
              itemBuilder: (BuildContext ctx, index) {
                return Column(
                  children: [
                    const SizedBox(height: 25),
                    Text(
                      state.listTopicsEvaluation[index].topic ?? '',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const RatingScreen(),
                    const SizedBox(height: 25),
                    TextButton(
                      onPressed: () {
                        print('CALIFICACION -->${state.rating}');
                        print('TOPIC EVALUATION -->${state.listTopicsEvaluation[index].topicEvaluationId}');
                        //context.read<QualificationToTopicsCubit>().createQualification();
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Text(
                          'Enviar Calificación',
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
                );
              },
            );
          }
        },
      ),
    );
  }
}

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RatingScreenState();

}

class _RatingScreenState extends State<RatingScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QualificationToTopicsCubit, QualificationToTopicsState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 1; i <= 5; i++)
              GestureDetector(
                onTap: () {
                  context.read<QualificationToTopicsCubit>()
                      .updateRating(i);
                },
                child: Icon(
                  i <= state.rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 50.0,
                ),
              ),
          ],
        );
      },
    );
  }
}