import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/referee_match.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/cubit/events/events_cubit.dart';

class TypeMatchTeamRadioIput extends StatelessWidget {
  const TypeMatchTeamRadioIput({super.key, required this.match});

  final RefereeMatchDTO match;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Evento",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
        const SizedBox(height: 20),
        BlocBuilder<EventsCubit, EventsState>(
          builder: (context, state) {
            return Row(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          Text(
                            state.matchDetail.localTeam ?? '',
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Local",
                            style: TextStyle(
                              color: Colors.cyan.shade700,
                              fontSize: 20.0,
                            ),
                          ),
                          Radio<TypeMatchTem>(
                            value: TypeMatchTem.local,
                            groupValue: state.typeMatchTeamSelected,
                            onChanged: (TypeMatchTem? value) {
                              context.read<EventsCubit>().onTypeMatchTeamChange(
                                    type: value!,
                                    teamId: match.teamIdLocal,
                                  );
                            },
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          Text(
                            state.matchDetail.visitTeam ?? '',
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Visitante",
                            style: TextStyle(
                              color: Colors.cyan.shade700,
                              fontSize: 20.0,
                            ),
                          ),
                          Radio<TypeMatchTem>(
                            value: TypeMatchTem.vist,
                            groupValue: state.typeMatchTeamSelected,
                            onChanged: (TypeMatchTem? value) => context
                                .read<EventsCubit>()
                                .onTypeMatchTeamChange(
                                  type: value!,
                                  teamId: match.teamIdVisit,
                                ),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
