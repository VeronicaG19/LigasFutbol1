import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/scoring_by_tournament/scoring_tournament_dto.dart';
import 'package:ligas_futbol_flutter/src/presentation/introduction/leagues/classification_by_tournament/cubit/classification_by_tournament_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/splash/responsive_widget.dart';

class TournamentRankingStatistics extends StatelessWidget {
  const TournamentRankingStatistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> headers = [], columns = [];

    List<Widget> buildHeaders({
      required bool isShootout,
      required bool smallScreen,
    }) {
      headers = [];
      if (!smallScreen) {
        headers.addAll([
          const _ColumnHeader(val: "Equipo", width: 100),
          const _ColumnHeader(val: "J"),
          const _ColumnHeader(val: "G"),
          const _ColumnHeader(val: "E"),
          const _ColumnHeader(val: "P"),
        ]);
        if (isShootout) headers.add(const _ColumnHeader(val: "PGS"));
        if (isShootout) headers.add(const _ColumnHeader(val: "PPS"));
        headers.addAll([
          const _ColumnHeader(val: "GF"),
          const _ColumnHeader(val: "GC"),
          const _ColumnHeader(val: "DIF"),
          const _ColumnHeader(val: "PTS"),
          const _ColumnHeader(val: "", width: 40),
        ]);
      } else {
        headers.add(const _ColumnHeader(val: "Equipo", width: 90));
        headers.add(const _ColumnHeader(val: "J"));
        headers.add(const _ColumnHeader(val: "G"));
        if (!isShootout) headers.add(const _ColumnHeader(val: "E"));
        headers.add(const _ColumnHeader(val: "P"));
        if (isShootout) headers.add(const _ColumnHeader(val: "PGS"));
        if (isShootout) headers.add(const _ColumnHeader(val: "PPS"));
        if (!isShootout) headers.add(const _ColumnHeader(val: "GF"));
        if (!isShootout) headers.add(const _ColumnHeader(val: "GC"));
        headers.add(const _ColumnHeader(val: "DIF"));
        headers.add(const _ColumnHeader(val: "PTS"));
        headers.add(const _ColumnHeader(val: "", width: 40));
      }

      return headers;
    }

    List<Widget> buildColumns({
      required bool isShootout,
      required ScoringTournamentDTO data,
      required bool smallScreen,
    }) {
      columns = [];
      if (!smallScreen) {
        columns.addAll([
          _ColumnWhite(val: '${data.team}', width: 100, isB: true),
          _ColumnGrey(val: '${data.pj ?? 0}'),
          _ColumnWhite(val: '${data.pg ?? 0}'),
          _ColumnGrey(val: '${data.pe ?? 0}'),
          _ColumnWhite(val: '${data.pp ?? 0}'),
        ]);
        if (isShootout) columns.add(_ColumnGrey(val: '${data.pgs ?? 0}'));
        if (isShootout) columns.add(_ColumnWhite(val: '${data.pps ?? 0}'));
        columns.addAll([
          _ColumnGrey(val: '${data.gf ?? 0}'),
          _ColumnWhite(val: '${data.gc ?? 0}'),
          _ColumnGrey(val: '${data.dif ?? 0}'),
          _ColumnWhite(val: '${data.pts ?? 0}'),
          _ColumnButtonInfo(data: data),
        ]);
      } else {
        columns.add(_ColumnWhite(val: '${data.team}', width: 90, isB: true));
        columns.add(_ColumnGrey(val: '${data.pj ?? 0}'));
        columns.add(_ColumnWhite(val: '${data.pg ?? 0}'));
        if (!isShootout) columns.add(_ColumnGrey(val: '${data.pe ?? 0}'));
        columns.add(isShootout
            ? _ColumnGrey(val: '${data.pp ?? 0}')
            : _ColumnWhite(val: '${data.pp ?? 0}'));
        if (isShootout) columns.add(_ColumnWhite(val: '${data.pgs ?? 0}'));
        if (isShootout) columns.add(_ColumnGrey(val: '${data.pps ?? 0}'));
        if (!isShootout) columns.add(_ColumnGrey(val: '${data.gf ?? 0}'));
        if (!isShootout) columns.add(_ColumnWhite(val: '${data.gc ?? 0}'));
        columns.add(isShootout
            ? _ColumnWhite(val: '${data.dif ?? 0}')
            : _ColumnGrey(val: '${data.dif ?? 0}'));
        columns.add(isShootout
            ? _ColumnGrey(val: '${data.pts ?? 0}')
            : _ColumnWhite(val: '${data.pts ?? 0}'));
        columns.add(_ColumnButtonInfo(data: data));
      }

      return columns;
    }

    return BlocBuilder<ClassificationByTournamentCubit,
        ClassificationByTournamentState>(builder: (context, state) {
      bool smallScreen = ResponsiveWidget.isSmallScreen(context);

      if (state.scoringTournament.isNotEmpty) {
        return Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 8, left: 8),
              height: 40,
              color: const Color(0xff358aac),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: buildHeaders(
                  isShootout: state.isShootout,
                  smallScreen: smallScreen,
                ),
              ),
            ),
            ListView.builder(
              itemCount: state.scoringTournament.length,
              padding:
                  const EdgeInsets.only(top: 40, bottom: 65, left: 2, right: 2),
              itemBuilder: (context, index) {
                return _Row(
                  columns: buildColumns(
                    isShootout: state.isShootout,
                    smallScreen: smallScreen,
                    data: state.scoringTournament[index],
                  ),
                );
              },
            ),
            _ClassificationInfo(flag: state.isShootout),
          ],
        );
      } else {
        return const Center(child: Text('No hay datos de clasificación'));
      }
    });
  }
}

class _Row extends StatelessWidget {
  final List<Widget> columns;

  const _Row({
    required this.columns,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        color: Colors.grey,
        height: 1,
      ),
      Container(
          height: 40,
          padding: const EdgeInsets.only(right: 8, left: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: columns,
          ))
    ]);
  }
}

class _ColumnHeader extends StatelessWidget {
  final String val;
  final int? width;

  const _ColumnHeader({
    required this.val,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width != null ? width!.toDouble() : 30,
      child: Text(
        val,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[200],
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _ColumnWhite extends StatelessWidget {
  final String val;
  final int? width;
  final bool? isB;

  const _ColumnWhite({
    required this.val,
    this.width,
    this.isB,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width != null ? width!.toDouble() : 30,
      height: 40,
      child: Center(
        child: Text(
          val,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isB ?? false ? 14 : 12,
            color: Colors.black,
            fontWeight: isB ?? false ? FontWeight.w900 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _ColumnGrey extends StatelessWidget {
  final String val;

  const _ColumnGrey({
    required this.val,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 40,
      color: Colors.black12,
      child: Center(
        child: Text(
          val,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _ColumnButtonInfo extends StatelessWidget {
  final ScoringTournamentDTO data;

  const _ColumnButtonInfo({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 40,
      child: Center(
        child: IconButton(
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              context: context,
              builder: (contextS) {
                return Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        top: 35,
                      ),
                      height: 400,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                             Flexible( child:  Column(
                               children: [
                                 const Image(
                                   image: AssetImage(
                                       'assets/images/playera4.png'),
                                   fit: BoxFit.fitWidth,
                                   height: 150,
                                   width: 150,
                                 ),
                                 SizedBox(
                                   height: 15,
                                 ),
                                 Text(
                                   "${data.team}",
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                       color: Colors.black,
                                       fontSize: 20,
                                       fontWeight: FontWeight.w900),
                                 ),
                                 SizedBox(
                                   height: 25,
                                 ),
                               ],
                             ),flex: 1),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 40,
                                        height: 30,
                                        child: Text(
                                          "J",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        width: 180,
                                        child: Text(
                                          "Partidos jugados",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        width: 40,
                                        child: Text(
                                          "${data.pj ?? 0}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 30,
                                        child: Text(
                                          "G",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        width: 180,
                                        child: Text(
                                          "Partidos ganados",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        width: 40,
                                        child: Text(
                                          "${data.pg ?? 0}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 30,
                                        child: Text(
                                          "E",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        width: 180,
                                        child: Text(
                                          "Partidos empatados",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        width: 40,
                                        child: Text(
                                          "${data.pe ?? 0}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 30,
                                        child: Text(
                                          "P",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        width: 180,
                                        child: Text(
                                          "Partidos perdidos",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        width: 40,
                                        child: Text(
                                          "${data.pp ?? 0}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 30,
                                        child: Text(
                                          "PGS",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        width: 180,
                                        child: Text(
                                          "P. ganados por shootouts",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        width: 40,
                                        child: Text(
                                          "${data.pgs ?? 0}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 30,
                                        child: Text(
                                          "PPS",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        width: 180,
                                        child: Text(
                                          "P. perdidos por shootouts",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        width: 40,
                                        child: Text(
                                          "${data.pps ?? 0}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 30,
                                        child: Text(
                                          "GF",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        width: 180,
                                        child: Text(
                                          "Goles a favor",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        width: 40,
                                        child: Text(
                                          "${data.gf ?? 0}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 30,
                                        child: Text(
                                          "GC",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        width: 180,
                                        child: Text(
                                          "Goles en contra",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        width: 40,
                                        child: Text(
                                          "${data.gc ?? 0}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 30,
                                        child: Text(
                                          "DIF",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        width: 180,
                                        child: Text(
                                          "Diferencia de goles",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        width: 40,
                                        child: Text(
                                          "${data.dif ?? 0}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 30,
                                        child: Text(
                                          "PTS",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        width: 180,
                                        child: Text(
                                          "Puntos",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        width: 40,
                                        child: Text(
                                          "${data.pts ?? 0}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 80.0,
                      bottom: 10,
                      right: 0.0,
                      child: TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                          decoration: const BoxDecoration(
                            color: Color(0xff740408),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: Text(
                            'Regresar a la pantalla anterior',
                            style: TextStyle(
                              fontFamily: 'SF Pro',
                              color: Colors.grey[200],
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          icon: const Icon(
            Icons.add_circle,
            color: Color(0xff358aac),
            size: 20,
          ),
        ),
      ),
    );
  }
}

class _ClassificationInfo extends StatelessWidget {
  final bool flag;
  const _ClassificationInfo({required this.flag});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        height: 65.0,
        color: Colors.black87,
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Center(
          child: Text(
            'J: Partidos jugados.       G: Partidos ganados.       E: Partidos empatados.       P: Partidos perdidos.       GF: Goles a favor.       GC: Goles en contra \n'
            'DIF: Diferencia de goles.       PTS: Puntos totales.${flag ? '       PGS: Partidos ganados por shootout.       PPS: Partidos perdidos por shootout. ' : ''} ',
            style: TextStyle(color: Colors.grey[200], fontSize: 10),
          ),
        ),
      ),
    );
  }
}
