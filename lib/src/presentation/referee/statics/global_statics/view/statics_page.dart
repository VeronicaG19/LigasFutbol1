import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../core/enums.dart';
import '../../../../../domain/leagues/entity/league.dart';
import '../../../../../service_locator/injection.dart';
import '../../../../app/bloc/authentication_bloc.dart';
import '../../matches_lists/view/matches_lists.dart';
import '../cubit/statics_cubit.dart';

class StaticsPage extends StatelessWidget {
  const StaticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final referee =
        context.select((AuthenticationBloc bloc) => bloc.state.refereeData);

    return BlocProvider(
      create: (_) =>
          locator<StaticsCubit>()..onLoadInitialData(referee.refereeId),
      child: const _PageContent(),
    );
  }
}

class _PageContent extends StatelessWidget {
  const _PageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StaticsCubit, StaticsState>(
      buildWhen: (previous, current) =>
          previous.screenState != current.screenState,
      builder: (context, state) {
        if (state.screenState == RefereeStaticsScreenState.loadingLeagues) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: Colors.blue[800]!,
              size: 50,
            ),
          );
        }
        if (state.screenState == RefereeStaticsScreenState.emptyLeaguesList) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Parece que aún no has arbitrado partidos'),
                const SizedBox(
                  height: 15.0,
                ),
                TextButton(
                  onPressed: context.read<StaticsCubit>().onLoadRefereeLeagues,
                  child: const Text('REINTENTAR'),
                ),
              ],
            ),
          );
        }
        return Column(
          children: [
            const _LeaguesMenu(),
            ListTile(
              leading: Image.asset(
                'assets/images/equipo.png',
                width: 32,
              ),
              title: const Text('Total de partidos'),
              trailing: state.screenState ==
                      RefereeStaticsScreenState.loadingGlobalStatics
                  ? const CircularProgressIndicator()
                  : Text('${state.globalStatics.totalMatches}'),
              onTap: () => Navigator.push(
                  context,
                  MatchesListsStats.route(
                      state.selectedLeague, RefereeEventType.all)),
            ),
            ListTile(
              leading: Icon(
                Icons.style,
                size: 32,
                color: Colors.yellow[700],
              ),
              title: const Text('Tarjetas amarillas'),
              trailing: state.screenState ==
                      RefereeStaticsScreenState.loadingGlobalStatics
                  ? const CircularProgressIndicator()
                  : Text('${state.globalStatics.yellowCards}'),
              onTap: () => Navigator.push(
                  context,
                  MatchesListsStats.route(
                      state.selectedLeague, RefereeEventType.yellowCard)),
            ),
            ListTile(
              leading: const Icon(
                Icons.style,
                size: 32,
                color: Colors.red,
              ),
              title: const Text('Tarjetas rojas'),
              trailing: state.screenState ==
                      RefereeStaticsScreenState.loadingGlobalStatics
                  ? const CircularProgressIndicator()
                  : Text('${state.globalStatics.redCards}'),
              onTap: () => Navigator.push(
                  context,
                  MatchesListsStats.route(
                      state.selectedLeague, RefereeEventType.redCard)),
            ),
          ],
        );
      },
    );
  }
}

class _LeaguesMenu extends StatelessWidget {
  const _LeaguesMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const dropdownDecoration = InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.5,
        ),
      ),
      labelStyle: TextStyle(fontSize: 15),
      helperText: '',
    );

    return Padding(
      padding: const EdgeInsets.all(15),
      child: BlocBuilder<StaticsCubit, StaticsState>(
        buildWhen: (previous, current) =>
            previous.refereeLeagues != current.refereeLeagues ||
            previous.selectedLeague != current.selectedLeague,
        builder: (context, state) {
          return DropdownButtonFormField<League>(
            decoration: dropdownDecoration.copyWith(
                labelText: 'Ligas', hintText: 'Ligas'),
            onChanged: context.read<StaticsCubit>().onChangeLeague,
            value:
                state.refereeLeagues.isNotEmpty ? state.selectedLeague : null,
            isExpanded: true,
            items: List.generate(
              state.refereeLeagues.length,
              (index) => DropdownMenuItem<League>(
                value: state.refereeLeagues[index],
                child: Text(state.refereeLeagues[index].leagueName),
              ),
            ),
          );
        },
      ),
    );
  }
}
/*
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
}*/
