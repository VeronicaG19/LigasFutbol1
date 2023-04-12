import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../domain/category/entity/category.dart';
import '../../../../domain/referee/entity/count_tournament_event.dart';
import '../../../../domain/referee/entity/referee_statics.dart';
import '../../../../domain/tournament/entity/tournament.dart';
import '../../../../service_locator/injection.dart';
import '../../../app/bloc/authentication_bloc.dart';
import '../cubit/statics_cubit.dart';

enum _GraphicType { tournament, event }

class StaticsPage extends StatelessWidget {
  const StaticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final league =
        context.select((AuthenticationBloc bloc) => bloc.state.refereeLeague);
    final person =
        context.select((AuthenticationBloc bloc) => bloc.state.user.person);
    final referee =
        context.select((AuthenticationBloc bloc) => bloc.state.refereeData);

    return BlocProvider(
      create: (_) => locator<StaticsCubit>()
        ..onLoadInitialData(
            person.personId ?? 0, league.leagueId, referee.refereeId ?? 0),
      child: const _PageContent(),
    );
  }
}

class _PageContent extends StatefulWidget {
  const _PageContent({Key? key}) : super(key: key);

  @override
  State<_PageContent> createState() => _PageContentState();
}

class _PageContentState extends State<_PageContent> {
  late Category category;

  // List<String> items = ['infantil', 'juvenil', 'adulta', 'femenil'];
  //
  late Tournament tournament;

  // List<String> tournamentItems = ['torneo1', 'juvenil', 'adulta', 'femenil'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StaticsCubit, StaticsState>(
      buildWhen: (previous, current) =>
          previous.screenState != current.screenState,
      builder: (context, state) {
        if (state.screenState == BasicCubitScreenState.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: Colors.blue[800]!,
              size: 50,
            ),
          );
        }
        return ListView(
          children: const [
            /*ListTile(
              title: const Text('Categorias'),
              subtitle: BlocBuilder<StaticsCubit, StaticsState>(
                // buildWhen: (previous, current) =>
                //     previous.categories != current.categories,
                builder: (context, state) {
                  return DropdownButton<Category>(
                    isExpanded: true,
                    value: state.selectedCategory,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: state.categories.map((Category item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item.categoryName ?? 'Sin valor'),
                      );
                    }).toList(),
                    onChanged: (Category? newValue) {
                      context.read<StaticsCubit>().onChangeCategory(newValue!);
                    },
                  );
                },
              ),
            ),
            ListTile(
              title: const Text('Torneos'),
              subtitle: BlocBuilder<StaticsCubit, StaticsState>(
                buildWhen: (previous, current) =>
                    previous.tournaments != current.tournaments,
                builder: (context, state) {
                  return DropdownButton<Tournament>(
                    isExpanded: true,
                    value: state.selectedTournament,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: state.tournaments.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e.tournamentName ?? ''),
                      );
                    }).toList(),
                    onChanged: (Tournament? newValue) {
                      setState(() {
                        tournament = newValue ?? const Tournament();
                      });
                    },
                  );
                },
              ),
            ),*/
            _TournamentStatics(
              title: 'Torneos en los que he participado',
              graphicType: _GraphicType.tournament,
            ),
            /*_TournamentStatics(
              title: 'Eventos señanalados',
              graphicType: _GraphicType.event,
            ),*/
            //const _TournamentStatics(),
          ],
        );
      },
    );
  }
}

class _TournamentStatics extends StatefulWidget {
  const _TournamentStatics(
      {Key? key, required this.title, required this.graphicType})
      : super(key: key);

  @override
  State<_TournamentStatics> createState() => _TournamentStaticsState();

  final String title;
  final _GraphicType graphicType;
}

class _TournamentStaticsState extends State<_TournamentStatics> {
  int touchedIndex = -1;
  final List<Color> colors = [];

  @override
  Widget build(BuildContext context) {
    List<Color> getRandomColors(int length) => List.generate(length,
        (index) => Color(Random().nextInt(0xffffffff)).withOpacity(0.7));

    double getTournamentValue(RefereeStatics static) {
      return context.read<StaticsCubit>().getTournamentStatics(static);
    }

    double getEventValue(CountEventTournament event) {
      return context.read<StaticsCubit>().getEventStatics(event);
    }

    List<PieChartSectionData> showingSections(List<dynamic> list) {
      return List.generate(
        list.length,
        (i) {
          final isTouched = i == touchedIndex;
          //final opacity = isTouched ? 1.0 : 0.6;

          const color0 = Color(0xff358aac);

          return PieChartSectionData(
            color: colors[i],
            value: widget.graphicType == _GraphicType.tournament
                ? getTournamentValue(list[i])
                : getEventValue(list[i]),
            title: widget.graphicType == _GraphicType.tournament
                ? '${getTournamentValue(list[i]).toStringAsFixed(2)}%'
                : '${getEventValue(list[i]).toStringAsFixed(2)}%',
            radius: 80,
            titleStyle: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            titlePositionPercentageOffset: 1.2,
            borderSide: isTouched
                ? const BorderSide(color: color0, width: 1)
                : BorderSide(color: color0.withOpacity(0)),
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: BlocBuilder<StaticsCubit, StaticsState>(
        builder: (context, state) {
          colors.addAll(getRandomColors(state.refereeStatics.length));
          return Column(
            children: [
              Text(
                widget.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              if ((widget.graphicType == _GraphicType.tournament &&
                      state.refereeStatics.isNotEmpty) ||
                  (widget.graphicType == _GraphicType.event &&
                      state.events.isNotEmpty))
                AspectRatio(
                  aspectRatio: 2,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(
                            () {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                touchedIndex = -1;
                                return;
                              }
                              touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            },
                          );
                        },
                      ),
                      startDegreeOffset: 90,
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 1.5,
                      centerSpaceRadius: 2,
                      sections: showingSections(
                          widget.graphicType == _GraphicType.tournament
                              ? state.refereeStatics
                              : state.events),
                    ),
                  ),
                ),
              ...List.generate(
                widget.graphicType == _GraphicType.tournament
                    ? state.refereeStatics.length
                    : state.events.length,
                (index) => Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Indicator(
                    color: colors[index],
                    text: widget.graphicType == _GraphicType.tournament
                        ? state.refereeStatics[index].tournamentName
                        : state.events[index].evento,
                    isSquare: false,
                    size: touchedIndex == 0 ? 20 : 18,
                    textColor:
                        touchedIndex == 0 ? Colors.black : Colors.blueGrey,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  });

  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
