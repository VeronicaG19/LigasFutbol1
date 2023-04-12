import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/cubit/events/events_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/cubit/ref_matches_cubit.dart';

class MinutInput extends StatelessWidget {
  const MinutInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      buildWhen: (previous, current) =>
          previous.minutValidator != current.minutValidator,
      builder: (context, state) {
        return TextFormField(
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          maxLength: 30,
          onChanged: (value) =>
              context.read<EventsCubit>().onMinChange(mins: value),
          decoration: InputDecoration(
            labelText: "Minuto : ",
            labelStyle: const TextStyle(fontSize: 13),
            errorText: state.minutValidator.invalid ? "Marca el tiempo" : null,
          ),
          style: const TextStyle(fontSize: 13),
        );
      },
    );
  }
}
