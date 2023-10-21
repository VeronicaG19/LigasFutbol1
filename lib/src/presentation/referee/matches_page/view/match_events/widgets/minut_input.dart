import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/cubit/events/events_cubit.dart';

class MinutInput extends StatelessWidget {
  const MinutInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      buildWhen: (previous, current) =>
          previous.minutValidator != current.minutValidator,
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          maxLength: 3,
          onChanged: (value) =>
              context.read<EventsCubit>().onMinChange(mins: value),
          decoration: InputDecoration(
            labelText: "Minuto : ",
            labelStyle: const TextStyle(fontSize: 13),
            errorText: state.minutValidator.invalid ? "Datos no válidos" : null,
          ),
          style: const TextStyle(fontSize: 13),
        );
      },
    );
  }
}
