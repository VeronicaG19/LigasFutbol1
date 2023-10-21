import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/cubit/events/events_cubit.dart';

class SaveEventButton extends StatelessWidget {
  const SaveEventButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                if (state.playersList[0].fullName == 'No hay jugadores...') {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Equipo sin jugadores'),
                      content: const Text(
                          'Para guardar un evento se necesitan jugadores.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else if (state.playerValidator.value == '0') {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Selecciona un jugador'),
                      content: const Text(
                          'Para asignar un evento se necesita el jugador.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else if (state.eventUtilSelected.code == '0') {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Selecciona un evento.'),
                      content: const Text('Selecciona el evento para asignar.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else if (state.minutValidator.value.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Agrega el minuto.'),
                      content:
                          const Text('Minuto en el que ocurrió el evento.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else {
                  print("TODO CORRECTO");
                  print("EVENTO --> ${state.eventUtilSelected}");
                  print("VALIDACION DEL JUGADOR --> ${state.playerValidator}");
                  print("INPUT MINUTO -->${state.minutValidator.value}");
                  context.read<EventsCubit>().onPressSaveEvent();
                }
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(90.0, 10.0, 90.0, 10.0),
                decoration: const BoxDecoration(
                  color: Color(0xff045a74),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Text(
                  'Guardar eventos',
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
}
