// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/tournament_cubit.dart';

class DaysCheckBoc extends StatelessWidget {
  const DaysCheckBoc({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentCubit, TournamentState>(
      builder: (context, state) {
       /* final list = List.generate(state.daysList.length, (index) => Expanded(
                  child: CheckboxListTile(
                    enabled: true,
                    title: Text(state.daysList[index].daysEnum?.name ?? ''),
                    value: state.daysList[index].isSelected,
                    onChanged: (bool? value) {
                      context.read<TournamentCubit>().inchangeDays(value!,state.daysList[index]);
                    }, //  <-- leading Checkbox
                  ),
                ));*/
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 180,
            childAspectRatio: 5/2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 15
            ),
          itemCount: state.daysList.length,
          itemBuilder:(context, index){
           return Expanded(
                  child: CheckboxListTile(
                    enabled: true,
                    title: Text(state.daysList[index].daysEnum?.name ?? ''),
                    value: state.daysList[index].isSelected,
                    onChanged: (bool? value) {
                      context.read<TournamentCubit>().inchangeDays(value!,state.daysList[index]);
                    }, //  <-- leading Checkbox
                  ),
                );
          } ,
        );
        
      });

      }
    }