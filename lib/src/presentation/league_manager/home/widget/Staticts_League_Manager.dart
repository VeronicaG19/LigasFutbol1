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
        context.select((AuthenticationBloc bloc) => bloc.state.leagueManager);

    return BlocProvider(
        create: (_) => locator<StatictsLmCubit>()
          ..loadStaticts(leagueId: leagueManager.leagueId),
        child: BlocBuilder<StatictsLmCubit, StatictsLmState>(
            //listener: (context, state) {},
            builder: (context, state) {
              if (state.screenStatus == ScreenStatus.loading) {
                return Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                    color: const Color(0xff358aac),
                    size: 50,
                  ),
                );
              } else {
                return Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        Text(
                          "${state.detailCategory.coundt1 ?? 0}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        Text("Total de categorias",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                      ],
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        Text(
                          "${state.detailTournament.coundt1 ?? 0}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        Text("Total de torneos",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                      ],
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        Text(
                        "${state.detailTeam.coundt1 ?? 0}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        Text("Total de equipos",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                      ],
                    )),
                  ],
                );
              }
            }));
  }
}
