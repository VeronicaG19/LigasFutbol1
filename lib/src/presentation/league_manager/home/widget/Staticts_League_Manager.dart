import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../service_locator/injection.dart';
import '../../../app/app.dart';
import 'cubit/staticts_lm_cubit.dart';

class StatictsLeagueManager extends StatelessWidget {
  const StatictsLeagueManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);

    return BlocProvider(
        create: (_) => locator<StatictsLmCubit>()
          ..loadStaticts(leagueId: leagueManager.leagueId),
        child: BlocBuilder<StatictsLmCubit, StatictsLmState>(
            //listener: (context, state) {},
            builder: (context, state) {
          if (state.screenStatus == ScreenStatusA.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: const Color(0xff358aac),
                size: 50,
              ),
            );
          } else {
            return Row(
              children: [
                _CategoryCounterCard(
                  counter: "${state.detailCategory.coundt1 ?? 0}",
                  title: "Total de categorias",
                ),
                const SizedBox(
                  height: 10,
                ),
                _CounterCard(
                  counter: "${state.detailTournament.coundt1 ?? 0}",
                  title: "Total de torneos",
                ),
                const SizedBox(
                  height: 10,
                ),
                _CounterCard(
                  counter: "${state.detailTeam.coundt1 ?? 0}",
                  title: "Total de equipos",
                ),
              ],
            );
          }
        }));
  }
}

class _CategoryCounterCard extends StatelessWidget {
  final String counter;
  final String title;

  const _CategoryCounterCard({
    Key? key,
    required this.counter,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: const Alignment(0.1, -0.9),
        children: [
          Visibility(
            visible: (counter == "0"),
            child: Icon(Icons.warning, color: Colors.red.shade900),
          ),
          Center(
            child: Column(
              children: [
                Text(
                  counter,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CounterCard extends StatelessWidget {
  final String counter;
  final String title;

  const _CounterCard({
    Key? key,
    required this.counter,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            counter,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
