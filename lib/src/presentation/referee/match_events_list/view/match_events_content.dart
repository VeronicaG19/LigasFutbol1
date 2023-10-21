import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/match_events_list/cubit/match_events_list_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

enum TypeEvent{goal, card}
enum TypeCardColor{red, yellow, blue}

class MatchEventsListContent extends StatelessWidget {
  const MatchEventsListContent({Key? key, required this.teamName, required this.teamMatchId, required this.teamMatchId2, required this.teamName2,}) : super(key: key);

  final int teamMatchId;
  final int teamMatchId2;
  final String teamName;
  final String teamName2;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchEventsListCubit, MatchEventsListState>(
        builder: (context, state) {
          if (state.screenState == BasicCubitScreenState.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: const Color(0xff358aac),
                size: 50,
              ),
            );
          } else{
            return state.eventsList.isEmpty
                ? const Center(child: Text("No tiene eventos creados."))
                :
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 5, 7, 5),
              child: ListView.builder(
                itemCount: state.eventsList.length,
                itemBuilder: (BuildContext context, index) {
                  return Container(
                    height: 115,
                    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5.0),
                    decoration: BoxDecoration(
                        color: state.eventsList[index].teamMatchId== teamMatchId ? Colors.white : const Color(0xFFE0E0E0),
                        border: Border.all(color: const Color(0xFFE0E0E0)),
                        borderRadius: BorderRadius.circular(8.0)),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        if(state.eventsList[index].eventType == 'Gol')
                          const _CardGoalEvent(eventType: TypeEvent.goal,),
                        if(state.eventsList[index].eventType == 'Tarjeta Roja')
                          const _CardColorEvent(cardColor: TypeCardColor.red,),
                        if(state.eventsList[index].eventType == 'Tarjeta Amarilla')
                          const _CardColorEvent(cardColor: TypeCardColor.yellow,),
                        if(state.eventsList[index].eventType == 'Tarjeta Azul')
                          const _CardColorEvent(cardColor: TypeCardColor.blue,),
                        const SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.eventsList[index].fullName!,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Text(state.eventsList[index].eventType!,),
                            const SizedBox(height: 5),
                            Text("Minuto: ${state.eventsList[index].matchEventTime.toString()}",),
                            const SizedBox(height: 5),
                            Text("Equipo: ${state.eventsList[index].teamMatchId== teamMatchId ? teamName : teamName2}",),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          }
        }
    );
  }
}

class _CardGoalEvent extends StatelessWidget{
  const _CardGoalEvent({Key? key, required this.eventType}) : super(key: key);
  final TypeEvent eventType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(50.0),
        image: const DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/equipo2.png')
        ),
      ),
    );
  }
}

class _CardColorEvent extends StatelessWidget{
  const _CardColorEvent({Key? key, required this.cardColor}) : super(key: key);
  final TypeCardColor cardColor;

  Color getDynamicColor(TypeCardColor cardColor) {
    if (TypeCardColor.red == cardColor) {
      return Colors.red;
    }
    if (TypeCardColor.yellow == cardColor) {
      return Colors.yellow;
    }
    if (TypeCardColor.blue == cardColor) {
      return Colors.blue;
    }
    return Colors.grey; //default color.
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 60,
      decoration: BoxDecoration(
        color: getDynamicColor(cardColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}