import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/domain/category/entity/category.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/tournaments/lm_tournament_v1/cubit/tournament_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/tournaments/lm_tournament_v1/tournaments_widgets/tournaments_list.dart';

import '../create_tournaments/create_tournament_page.dart';

class SelectTournamentWidget extends StatelessWidget {
  const SelectTournamentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentCubit, TournamentState>(
        builder: (context, state) {
      return SingleChildScrollView(
        //color: Colors.grey[200],
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Card(
              child: TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  CreateTournamentPage(fromPage:1),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.add,
                  size: 29.0,
                ),
                label: const Text(
                  'Crear nuevo Torneo',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Torneos Creados',
              style: TextStyle(fontSize: 29),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Categorías',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 5,
            ),
            (state.categories.length > 0)
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 16),
                    child: DropdownButtonFormField<Category>(
                      value: state.categories[state.indexCatSelec!],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      //icon: const Icon(Icons.sports_soccer),
                      isExpanded: true,
                      hint: const Text('Selecciona una categoria'),
                      items: List.generate(
                        state.categories.length,
                        (index) {
                          final content = state.categories[index].categoryName!;
                          return DropdownMenuItem(
                            child: Text(content.trim().isEmpty
                                ? 'Selecciona una categoria'
                                : content),
                            value: state.categories[index],
                          );
                        },
                      ),
                      onChanged: (value) {
                        context
                            .read<TournamentCubit>()
                            .getTournamentsByCategory(category: value!);
                      },
                    ),
                  )
                : const Text('No hay categorías disponibles'),
            const SizedBox(
              height: 5,
            ),
            const TournamentsList()
          ],
        ),
      );
    });
  }
}
