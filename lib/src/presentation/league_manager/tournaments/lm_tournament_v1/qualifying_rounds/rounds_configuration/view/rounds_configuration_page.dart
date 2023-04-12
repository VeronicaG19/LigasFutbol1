import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import '../../../../../../../domain/player/entity/position.dart';
import '../../../../lm_tournament_v2/main_page/cubit/tournament_main_cubit.dart';

class RoundsConfigurationPage extends StatelessWidget {
  const RoundsConfigurationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      child: SimpleDialog(
        contentPadding: const EdgeInsets.all(25),
        title: const Text(
          'Configuración de liguilla',
          textAlign: TextAlign.center,
        ),
        children: [
          BlocBuilder<TournamentMainCubit, TournamentMainState>(
            /*listener: (context, state){
              /*if(state.screenStatus == CLScreenStatus.createdConfiguration){
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text('Configuración de liguilla correctamente'),
                        duration: Duration(seconds: 5)),
                  );
              }else{
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text(state.errorMessage ?? ''),
                        duration: const Duration(seconds: 5)),
                  );
              }*/
            },*/
            builder: (context, state) {
              return Column(
                children: [
                  _Rounds(),
                  const _MatchForRound(type: 'Partidos ida y vuelta',),
                  const _NumberOrFinals(type: 'Juegos para la final',),
                  const _TieBreakerType(),
                  const SizedBox(height: 25,),
                  const Text("Selecciona los equipos que clasificarón"),
                  const SizedBox(
                    width: 600,
                    height: 150, // constrain height
                    child: _ListTeamsToRegister(),
                  ),
                  _ActionButtons(),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

class _Rounds extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    List positions = [
      Positions(preferencePosition: '1.- Semifinal', preferencePositionId: 4),
      Positions(preferencePosition: '2.- 4tos', preferencePositionId: 8),
      Positions(preferencePosition: '3.- 8vos', preferencePositionId: 16),
      Positions(preferencePosition: '4.- 16vos', preferencePositionId: 32),
    ];

    return BlocBuilder<TournamentMainCubit, TournamentMainState>(
        builder: (context, state){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: DropdownButtonFormField<Positions>(
              value: positions.firstWhere(
                      (element) =>
                  element.preferencePositionId ==
                      state.num,
                  orElse: () {
                    return positions[0];
                  }),
              decoration: const InputDecoration(
                icon: Icon(Icons.sports_soccer),
                border: OutlineInputBorder(),
              ),
              isExpanded: true,
              hint: const Text('Selecciona una posición'),
              items: List.generate(
                positions.length, (index) {
                return DropdownMenuItem(
                  value: positions[index],
                  child: Text(positions[index].preferencePosition),
                );
              },
              ),
              onChanged: (value) {
                //print(value?.preferencePositionId);
                context.read<TournamentMainCubit>().onChangeRound(value: value?.preferencePositionId ?? 0);
              },
            ),
          );
        }
    );
  }
}

class _MatchForRound extends StatelessWidget{
  const _MatchForRound({Key? key, required this.type}) : super(key: key);

  final String type;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentMainCubit, TournamentMainState>(
        builder: (context, state){
          return Row(
            children: [
              Text(type),
              Expanded(
                child: ListTile(
                  title: const Text('Un partido'),
                  leading: Radio<String>(
                    value: MatchForRound.ONEMATCH.name,
                    groupValue: state.matchForRound,
                    onChanged: (value) {
                      //print(value);
                      context.read<TournamentMainCubit>()
                          .onChangeMatchForRound(value!);
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: const Text('Ida y vuelta'),
                  leading: Radio<String>(
                    value: MatchForRound.ROUNDTRIP.name,
                    groupValue: state.matchForRound,
                    onChanged: (value) {
                      //print(value);
                      context.read<TournamentMainCubit>()
                          .onChangeMatchForRound(value!);
                    },
                  ),
                ),
              )
            ],
          );
        }
    );
  }
}

class _NumberOrFinals extends StatelessWidget{
  const _NumberOrFinals({Key? key, required this.type}) : super(key: key);

  final String type;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentMainCubit, TournamentMainState>(
        builder: (context, state){
          return Row(
            children: [
              Text(type),
              Expanded(
                child: ListTile(
                  title: const Text('Un partido'),
                  leading: Radio<String>(
                    value: MatchForRound.ONEMATCH.name,
                    groupValue: state.numberOrFinals,
                    onChanged: (value) {
                      //print(value);
                      context.read<TournamentMainCubit>()
                          .onChangeNumberOrFinals(value!);
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: const Text('Ida y vuelta'),
                  leading: Radio<String>(
                    value: MatchForRound.ROUNDTRIP.name,
                    groupValue: state.numberOrFinals,
                    onChanged: (value) {
                      //print(value);
                      context.read<TournamentMainCubit>()
                          .onChangeNumberOrFinals(value!);
                    },
                  ),
                ),
              )
            ],
          );
        }
    );
  }
}

class _TieBreakerType extends StatelessWidget{
  const _TieBreakerType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentMainCubit, TournamentMainState>(
        builder: (context, state){
          return Row(
            children: [
              const Text("Desempatar por"),
              Expanded(
                child: ListTile(
                  title: const Text('Posición en la tabla'),
                  leading: Radio<String>(
                    value: TieBreakerType.TABLEPOSITIONS.name,
                    groupValue: state.tieBreakerType,
                    onChanged: (value) {
                      //print(value);
                      context.read<TournamentMainCubit>()
                          .onChangeTieBreakerType(value!);
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: const Text('Penales/Shoot out'),
                  leading: Radio<String>(
                    value: TieBreakerType.PENALTIESORSHOOTOUT.name,
                    groupValue: state.tieBreakerType,
                    onChanged: (value) {
                      //print(value);
                      context.read<TournamentMainCubit>()
                          .onChangeTieBreakerType(value!);
                    },
                  ),
                ),
              )
            ],
          );
        }
    );
  }
}

class _ListTeamsToRegister extends StatelessWidget {
  const _ListTeamsToRegister({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentMainCubit, TournamentMainState>(
      builder: (context, state) {
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
          itemCount: state.cardTeamsSlc.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              enabled: true,
              selected: state.cardTeamsSlc[index].isSelected!,
              title: Text(state.cardTeamsSlc[index].teamName ?? ""),
              value: state.cardTeamsSlc[index].isSelected!,
              onChanged: (bool? value) {
                //print(value);
                context.read<TournamentMainCubit>().markTeamToSuscribe(
                    !state.cardTeamsSlc[index].isSelected!, index);
              }, //  <-- leading Checkbox
            );
          },
        );
      },
    );
  }
}

class _ActionButtons extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentMainCubit, TournamentMainState>(
        builder: (context, state){
          return Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.backspace, size: 24.0,),
                  label: const Text('Regresar'), // <-- Text
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              Expanded(
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.green)),
                  onPressed: () async {
                    print("RONDAS---> ${state.num}");
                    print("NUM EQUIPOS ---> ${state.countSelected}");
                    if(state.num == state.countSelected) {
                      print("IGUAL");
                      context.read<TournamentMainCubit>()
                          .createRoundsConfiguration(
                          tournamentId: state.selectedTournament.tournamentId!
                      );
                      Navigator.of(context).pop();
                    } else{
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Número de equipos incorrecto'),
                          content: const Text('La ronda no corresponde al número de equipos. \n'
                              'Seleccione la cantidad de equipos correctamente.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.save, size: 24.0,),
                  label: const Text('Guardar'), // <-- Text
                ),
              ),
            ],
          );
        }
    );
  }
}
