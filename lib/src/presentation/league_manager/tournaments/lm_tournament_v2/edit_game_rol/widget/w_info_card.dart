import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../domain/field/entity/field.dart';
import '../../../../../../domain/referee/dto/referee_by_address.dart';
import '../cubit/edit_game_rol_cubit.dart';

class InfoCard extends StatelessWidget {
  const InfoCard(
      {Key? key,
      required this.isReferee,
      this.referee,
      this.field,
      required this.isSelected})
      : super(key: key);
  final bool isReferee;
  final RefereeByAddress? referee;
  final Field? field;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        shape: isSelected
            ? RoundedRectangleBorder(
                side: const BorderSide(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(12.0),
              )
            : RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12.0),
              ),
        elevation: isSelected ? 2.5 : 1.0,
        color: Colors.grey[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 8,
                ),
                child: Image.asset(
                  isReferee
                      ? 'assets/images/referee.png'
                      : 'assets/images/footballfield.png',
                  fit: BoxFit.cover,
                  height: 35,
                  width: 35,
                  color: Colors.black54,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  isReferee ? referee!.name ?? '' : field!.fieldName ?? '',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: true,
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 12,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        if (isReferee) {
          context.read<EditGameRolCubit>().onSelectReferee(referee!);
        } else {
          context.read<EditGameRolCubit>().onSelectField(field!);
        }
      },
    );
  }
}
