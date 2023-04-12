import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../lm_tournament_v1/clasification/widgets/d_assign_match_field.dart';
import '../cubit/edit_game_rol_cubit.dart';

class ResultContent extends StatelessWidget {
  const ResultContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final referee =
        context.select((EditGameRolCubit bloc) => bloc.state.selectedReferee);
    final field =
        context.select((EditGameRolCubit bloc) => bloc.state.selectedField);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: SizedBox(
        height: 330,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              BlocBuilder<EditGameRolCubit, EditGameRolState>(
                builder: (context, state) {
                  final date = state.selectedDate != null
                      ? DateFormat('dd-MM-yyyy').format(state.selectedDate!)
                      : '';
                  final hour = state.selectedHour != null
                      ? DateFormat('HH:mm').format(state.selectedHour!)
                      : '';
                  return ListTile(
                    title: const Text('FECHA DEL PARTIDO'),
                    subtitle: Text('$date $hour'),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
                child: SizedBox(
                  width: 350,
                  height: 80,
                  child: Card(
                    shadowColor: Colors.black,
                    color: Colors.grey[100],
                    elevation: 10,
                    child: ListTile(
                      title: const Text('ÁRBITRO'),
                      subtitle: Text(
                        referee.firstName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                      ),
                      trailing:
                          const _InfoButton(requestType: LMRequestType.referee),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 0, 12),
                child: SizedBox(
                  width: 350,
                  height: 80,
                  child: Card(
                    shadowColor: Colors.black,
                    color: Colors.grey[100],
                    elevation: 10,
                    child: ListTile(
                      title: const Text('CAMPO'),
                      subtitle: Text(
                        field.fieldName ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                      ),
                      trailing: const _InfoButton(
                          requestType: LMRequestType.fieldOwner),
                    ),
                  ),
                ),
              ),
              BlocBuilder<EditGameRolCubit, EditGameRolState>(
                //buildWhen: (_, state) => state.,
                builder: (context, state) {
                  if (state.screenState ==
                      BasicCubitScreenState.submissionInProgress) {
                    return Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: Colors.blue[800]!,
                        size: 50,
                      ),
                    );
                  }
                  return Center(
                    child: OutlinedButton(
                      onPressed: () {
                        context.read<EditGameRolCubit>().onSubmit();
                      },
                      child: const Text('SOLICITAR'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoButton extends StatelessWidget {
  const _InfoButton({Key? key, required this.requestType}) : super(key: key);
  final LMRequestType requestType;

  @override
  Widget build(BuildContext context) {
    final field =
        context.select((EditGameRolCubit bloc) => bloc.state.selectedField);
    final referee =
        context.select((EditGameRolCubit bloc) => bloc.state.selectedReferee);
    return OutlinedButton(
      onPressed: () {
        if (requestType == LMRequestType.referee && referee.isEmpty) return;
        if (requestType == LMRequestType.fieldOwner && field.isEmpty) return;
        showDialog(
          context: context,
          builder: (_) {
            return AssignMatchFieldDialog(
              // match: match,
              selectedField: field,
              selectedReferee: referee,
              type: requestType,
            );
          },
        );
      },
      child: const Text('Ver información'),
    );
  }
}
