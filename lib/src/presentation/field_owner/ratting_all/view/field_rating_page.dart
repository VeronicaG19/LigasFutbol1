import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../domain/field/entity/field.dart';
import '../../../../service_locator/injection.dart';
import '../../../widgets/rating_card.dart';
import '../cubit/rattingfield_cubit.dart';

class FieldRattingPage extends StatefulWidget {
  final Field field;

  const FieldRattingPage({super.key, required this.field});
  @override
  State<FieldRattingPage> createState() => _FieldRattingPageState();
}

class _FieldRattingPageState extends State<FieldRattingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
            locator<RattingfieldCubit>()..onGetCalifications(widget.field.fieldId!,  ['PLAYER_TO_FIELD', 'REFEREE_TO_FIELD']),
      child: BlocConsumer<RattingfieldCubit, RattingfieldState>(
        builder:(context, state){
          if(state.screenStatus ==  ScreenStatus.loaded){
            return ListView.builder(
            itemBuilder: (context, index) {
              return  RatingCard(
                title: state.calificationsList[index].nameEvaluator!,
                rating: state.calificationsList[index].rating!,
                trailing: 'Evaluación de ${state.calificationsList[index].getEvaluation}' ,
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