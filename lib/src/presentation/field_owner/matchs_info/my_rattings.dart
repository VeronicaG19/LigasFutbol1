import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../service_locator/injection.dart';
import '../../widgets/rating_card.dart';
import 'cubit/myrattings_cubit.dart';

class MyRattings extends StatelessWidget {
  final int matchId;

  const MyRattings({super.key, required this.matchId});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
            locator<MyrattingsCubit>()..onGetCalifications(matchId, ['PLAYER_TO_FIELD', 'REFEREE_TO_FIELD']),
      child: BlocConsumer<MyrattingsCubit, MyrattingsState>(
        builder:(context, state){
          if(state.screenStatus ==  ScreenStatus.loaded){
            return ListView.builder( 
            itemBuilder: (context, index) {
              return  RatingCard(
                title: state.calificationsList[index].nameEvaluator!,
                rating: state.calificationsList[index].rating!,
                trailing: 'Evaluación de ${context.read<MyrattingsCubit>().onGetEvaluatorType(state.calificationsList[index].typeEvaluation!)}' ,
                subTitle: 'Evaluación echa a ${state.calificationsList[index].nameEvaluated}',
                description:
                    state.calificationsList[index].comments!,
              );
            },
            itemCount: state.calificationsList.length);
          }else{
            return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: const Color(0xff358aac),
                  size: 50,
                ),
              );
          }
        }, listener:  (context, state){

        }),
    );
  }
}