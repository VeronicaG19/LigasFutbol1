import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/edit_game_rol_cubit.dart';
import 'w_info_card.dart';

class GridList extends StatelessWidget {
  const GridList({Key? key, required this.isReferee}) : super(key: key);
  //true referee
  final bool isReferee;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      width: 400,
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: BlocBuilder<EditGameRolCubit, EditGameRolState>(
          builder: (context, state) {
            if (isReferee && state.refereeList.isEmpty) {
              return const Center(
                child: Text('No hay árbitros disponibles'),
              );
            }
            if (!isReferee && state.fieldList.isEmpty) {
              return const Center(
                child: Text('No hay campos disponibles'),
              );
            }
            return GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              itemCount:
                  isReferee ? state.refereeList.length : state.fieldList.length,
              physics: const NeverScrollableScrollPhysics(),
              //physics: const ScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 5 / 7,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0),
              itemBuilder: (BuildContext ctx, index) {
                if (isReferee) {
                  return InfoCard(
                    isReferee: isReferee,
                    referee: state.refereeList[index],
                    isSelected:
                        state.refereeList[index] == state.selectedReferee,
                  );
                }
                return InfoCard(
                  isReferee: isReferee,
                  field: state.fieldList[index],
                  isSelected: state.fieldList[index] == state.selectedField,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
