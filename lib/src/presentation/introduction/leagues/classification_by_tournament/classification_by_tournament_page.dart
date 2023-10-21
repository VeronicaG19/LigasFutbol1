import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/domain/category/category.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/entity/tournament.dart';
import 'package:ligas_futbol_flutter/src/presentation/introduction/leagues/classification_by_tournament/cubit/classification_by_tournament_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/introduction/leagues/classification_by_tournament/tournament_ranking_statistics.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ClassificationByTournamentPage extends StatefulWidget {
  const ClassificationByTournamentPage(
      {Key? key, required this.tournament, required this.category})
      : super(key: key);
  final Tournament tournament;
  final Category category;
  @override
  _ClassificationByTournamentPageState createState() =>
      _ClassificationByTournamentPageState();
}

class _ClassificationByTournamentPageState
    extends State<ClassificationByTournamentPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<ClassificationByTournamentCubit>()
        ..getFindByNameAndCategory(
            tournament: widget.tournament, category: widget.category),
      child: BlocBuilder<ClassificationByTournamentCubit,
          ClassificationByTournamentState>(
        builder: (context, state) {
          if (state.screenStatus == ScreenStatus.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: const Color(0xff358aac),
                size: 50,
              ),
            );
          } else {
            return const TournamentRankingStatistics();
            // return Stack(children: [
            //   Container(
            //     padding: EdgeInsets.only(right: 8, left: 8),
            //     height: 40,
            //     color: const Color(0xff358aac),
            //     child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           SizedBox(
            //             width: 95,
            //             child: Text(
            //               "Equipo",
            //               textAlign: TextAlign.center,
            //               style: TextStyle(
            //                   fontSize: 12,
            //                   color: Colors.grey[200],
            //                   fontWeight: FontWeight.w900),
            //             ),
            //           ),
            //           SizedBox(
            //             width: 35,
            //             child: Text(
            //               "J",
            //               textAlign: TextAlign.center,
            //               style: TextStyle(
            //                   fontSize: 12,
            //                   color: Colors.grey[200],
            //                   fontWeight: FontWeight.w900),
            //             ),
            //           ),
            //           SizedBox(
            //             width: 35,
            //             child: Text(
            //               "G",
            //               textAlign: TextAlign.center,
            //               style: TextStyle(
            //                   fontSize: 12,
            //                   color: Colors.grey[200],
            //                   fontWeight: FontWeight.w900),
            //             ),
            //           ),
            //           SizedBox(
            //             width: 35,
            //             child: Text(
            //               "E",
            //               textAlign: TextAlign.center,
            //               style: TextStyle(
            //                   fontSize: 12,
            //                   color: Colors.grey[200],
            //                   fontWeight: FontWeight.w900),
            //             ),
            //           ),
            //           SizedBox(
            //             width: 35,
            //             child: Text(
            //               "P",
            //               textAlign: TextAlign.center,
            //               style: TextStyle(
            //                   fontSize: 12,
            //                   color: Colors.grey[200],
            //                   fontWeight: FontWeight.w900),
            //             ),
            //           ),
            //           if (state.isShootout)
            //             SizedBox(
            //               width: 35,
            //               child: Text(
            //                 "PGS",
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(
            //                     fontSize: 12,
            //                     color: Colors.grey[200],
            //                     fontWeight: FontWeight.w900),
            //               ),
            //             ),
            //           if (state.isShootout)
            //             SizedBox(
            //               width: 35,
            //               child: Text(
            //                 "PPS",
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(
            //                     fontSize: 12,
            //                     color: Colors.grey[200],
            //                     fontWeight: FontWeight.w900),
            //               ),
            //             ),
            //           SizedBox(
            //             width: 35,
            //             child: Text(
            //               "GF",
            //               textAlign: TextAlign.center,
            //               style: TextStyle(
            //                   fontSize: 12,
            //                   color: Colors.grey[200],
            //                   fontWeight: FontWeight.w900),
            //             ),
            //           ),
            //           SizedBox(
            //             width: 35,
            //             child: Text(
            //               "GC",
            //               textAlign: TextAlign.center,
            //               style: TextStyle(
            //                   fontSize: 12,
            //                   color: Colors.grey[200],
            //                   fontWeight: FontWeight.w900),
            //             ),
            //           ),
            //           SizedBox(
            //             width: 35,
            //             child: Text(
            //               "DIF",
            //               textAlign: TextAlign.center,
            //               style: TextStyle(
            //                   fontSize: 12,
            //                   color: Colors.grey[200],
            //                   fontWeight: FontWeight.w900),
            //             ),
            //           ),
            //           SizedBox(
            //             width: 35,
            //             child: Text(
            //               "PTS",
            //               textAlign: TextAlign.center,
            //               style: TextStyle(
            //                   fontSize: 12,
            //                   color: Colors.grey[200],
            //                   fontWeight: FontWeight.w900),
            //             ),
            //           ),
            //           SizedBox(
            //             width: 35,
            //             child: Text(
            //               "",
            //               textAlign: TextAlign.center,
            //               style: TextStyle(
            //                   fontSize: 12,
            //                   color: Colors.grey[200],
            //                   fontWeight: FontWeight.w900),
            //             ),
            //           ),
            //         ]),
            //   ),
            //   ListView.builder(
            //       itemCount: state.scoringTournament.length,
            //       padding: const EdgeInsets.only(top: 40, bottom: 65),
            //       itemBuilder: (context, index) {
            //         return Column(
            //           children: [
            //             Container(
            //               color: Colors.grey,
            //               height: 1,
            //             ),
            //             Container(
            //               height: 40,
            //               padding: const EdgeInsets.only(right: 8, left: 8),
            //               child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     SizedBox(
            //                       height: 40,
            //                       width: 95,
            //                       child: Center(
            //                         child: Text(
            //                           state.scoringTournament[index].team ??
            //                               '-',
            //                           textAlign: TextAlign.start,
            //                           style: const TextStyle(
            //                               fontSize: 14,
            //                               color: Colors.black,
            //                               fontWeight: FontWeight.w900),
            //                         ),
            //                       ),
            //                     ),
            //                     Container(
            //                       width: 35,
            //                       height: 40,
            //                       color: Colors.black12,
            //                       child: Center(
            //                         child: Text(
            //                           "${state.scoringTournament[index].pj ?? 0}",
            //                           textAlign: TextAlign.center,
            //                           style: const TextStyle(
            //                               fontSize: 11,
            //                               color: Colors.black,
            //                               fontWeight: FontWeight.w500),
            //                         ),
            //                       ),
            //                     ),
            //                     SizedBox(
            //                       width: 35,
            //                       height: 40,
            //                       child: Center(
            //                         child: Text(
            //                           "${state.scoringTournament[index].pg ?? 0}",
            //                           textAlign: TextAlign.center,
            //                           style: const TextStyle(
            //                               fontSize: 11,
            //                               color: Colors.black,
            //                               fontWeight: FontWeight.w500),
            //                         ),
            //                       ),
            //                     ),
            //                     Container(
            //                       width: 35,
            //                       height: 40,
            //                       color: Colors.black12,
            //                       child: Center(
            //                         child: Text(
            //                           "${state.scoringTournament[index].pe ?? 0}",
            //                           textAlign: TextAlign.center,
            //                           style: const TextStyle(
            //                               fontSize: 11,
            //                               color: Colors.black,
            //                               fontWeight: FontWeight.w500),
            //                         ),
            //                       ),
            //                     ),
            //                     SizedBox(
            //                       width: 35,
            //                       height: 40,
            //                       child: Center(
            //                         child: Text(
            //                           "${state.scoringTournament[index].pp ?? 0}",
            //                           textAlign: TextAlign.center,
            //                           style: const TextStyle(
            //                               fontSize: 11,
            //                               color: Colors.black,
            //                               fontWeight: FontWeight.w500),
            //                         ),
            //                       ),
            //                     ),
            //                     if (state.isShootout)
            //                       SizedBox(
            //                         width: 35,
            //                         height: 40,
            //                         child: Center(
            //                           child: Text(
            //                             "${state.scoringTournament[index].pgs ?? 0}",
            //                             textAlign: TextAlign.center,
            //                             style: const TextStyle(
            //                                 fontSize: 11,
            //                                 color: Colors.black,
            //                                 fontWeight: FontWeight.w500),
            //                           ),
            //                         ),
            //                       ),
            //                     if (state.isShootout)
            //                       SizedBox(
            //                         width: 35,
            //                         height: 40,
            //                         child: Center(
            //                           child: Text(
            //                             "${state.scoringTournament[index].pps ?? 0}",
            //                             textAlign: TextAlign.center,
            //                             style: const TextStyle(
            //                                 fontSize: 11,
            //                                 color: Colors.black,
            //                                 fontWeight: FontWeight.w500),
            //                           ),
            //                         ),
            //                       ),
            //                     SizedBox(
            //                       width: 35,
            //                       height: 40,
            //                       child: Center(
            //                         child: Text(
            //                           "${state.scoringTournament[index].gf ?? 0}",
            //                           textAlign: TextAlign.center,
            //                           style: const TextStyle(
            //                               fontSize: 11,
            //                               color: Colors.black,
            //                               fontWeight: FontWeight.w500),
            //                         ),
            //                       ),
            //                     ),
            //                     SizedBox(
            //                       width: 35,
            //                       height: 40,
            //                       child: Center(
            //                         child: Text(
            //                           "${state.scoringTournament[index].gc ?? 0}",
            //                           textAlign: TextAlign.center,
            //                           style: const TextStyle(
            //                               fontSize: 11,
            //                               color: Colors.black,
            //                               fontWeight: FontWeight.w500),
            //                         ),
            //                       ),
            //                     ),
            //                     Container(
            //                       width: 35,
            //                       height: 40,
            //                       color: Colors.black12,
            //                       child: Center(
            //                         child: Text(
            //                           "${state.scoringTournament[index].dif ?? 0}",
            //                           textAlign: TextAlign.center,
            //                           style: const TextStyle(
            //                               fontSize: 11,
            //                               color: Colors.black,
            //                               fontWeight: FontWeight.w500),
            //                         ),
            //                       ),
            //                     ),
            //                     SizedBox(
            //                       width: 35,
            //                       height: 40,
            //                       child: Center(
            //                         child: Text(
            //                           "${state.scoringTournament[index].pts ?? 0}",
            //                           textAlign: TextAlign.center,
            //                           style: const TextStyle(
            //                               fontSize: 11,
            //                               color: Colors.black,
            //                               fontWeight: FontWeight.w900),
            //                         ),
            //                       ),
            //                     ),
            //                     Container(
            //                         width: 35,
            //                         height: 40,
            //                         color: Colors.black12,
            //                         child: Center(
            //                           child: IconButton(
            //                               onPressed: () {
            //                                 showModalBottomSheet(
            //                                   backgroundColor:
            //                                       Colors.transparent,
            //                                   isScrollControlled: true,
            //                                   context: context,
            //                                   builder: (contextS) {
            //                                     return Stack(
            //                                       children: [
            //                                         Padding(
            //                                           padding:
            //                                               MediaQuery.of(context)
            //                                                   .viewInsets,
            //                                           child: Container(
            //                                             padding:
            //                                                 const EdgeInsets
            //                                                     .only(top: 35),
            //                                             height: 500,
            //                                             decoration:
            //                                                 BoxDecoration(
            //                                               color:
            //                                                   Colors.grey[200],
            //                                               borderRadius:
            //                                                   const BorderRadius
            //                                                       .only(
            //                                                 topLeft:
            //                                                     Radius.circular(
            //                                                         20.0),
            //                                                 topRight:
            //                                                     Radius.circular(
            //                                                         20.0),
            //                                               ),
            //                                             ),
            //                                             child: Column(
            //                                               children: [
            //                                                 Column(
            //                                                   children: [
            //                                                     Column(
            //                                                       children: <Widget>[
            //                                                         const Image(
            //                                                           image: AssetImage(
            //                                                               'assets/images/playera4.png'),
            //                                                           fit: BoxFit
            //                                                               .fitWidth,
            //                                                           height:
            //                                                               80,
            //                                                           width: 80,
            //                                                         ),
            //                                                         const SizedBox(
            //                                                           height:
            //                                                               15,
            //                                                         ),
            //                                                         Text(
            //                                                           state.scoringTournament[index]
            //                                                                   .team ??
            //                                                               '-',
            //                                                           textAlign:
            //                                                               TextAlign
            //                                                                   .center,
            //                                                           style: const TextStyle(
            //                                                               color: Colors
            //                                                                   .black,
            //                                                               fontSize:
            //                                                                   20,
            //                                                               fontWeight:
            //                                                                   FontWeight.w900),
            //                                                         ),
            //                                                         const SizedBox(
            //                                                           height:
            //                                                               25,
            //                                                         ),
            //                                                       ],
            //                                                     ),
            //                                                     Row(
            //                                                       children: [
            //                                                         const SizedBox(
            //                                                           width: 40,
            //                                                           height:
            //                                                               30,
            //                                                           child:
            //                                                               Text(
            //                                                             "PJ",
            //                                                             textAlign:
            //                                                                 TextAlign.center,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w900),
            //                                                           ),
            //                                                         ),
            //                                                         SizedBox(
            //                                                           height:
            //                                                               30,
            //                                                           width:
            //                                                               250,
            //                                                           child:
            //                                                               Text(
            //                                                             "Partidos jugados:",
            //                                                             textAlign:
            //                                                                 TextAlign.start,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w300),
            //                                                           ),
            //                                                         ),
            //                                                         SizedBox(
            //                                                           height:
            //                                                               30,
            //                                                           width: 40,
            //                                                           child:
            //                                                               Text(
            //                                                             "${state.scoringTournament[index].pj ?? 0}",
            //                                                             textAlign:
            //                                                                 TextAlign.center,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w900),
            //                                                           ),
            //                                                         )
            //                                                       ],
            //                                                     ),
            //                                                     Row(
            //                                                       children: [
            //                                                         SizedBox(
            //                                                           width: 40,
            //                                                           height:
            //                                                               30,
            //                                                           child:
            //                                                               Text(
            //                                                             "PG",
            //                                                             textAlign:
            //                                                                 TextAlign.center,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w900),
            //                                                           ),
            //                                                         ),
            //                                                         SizedBox(
            //                                                           height:
            //                                                               30,
            //                                                           width:
            //                                                               250,
            //                                                           child:
            //                                                               Text(
            //                                                             "Partidos ganados:",
            //                                                             textAlign:
            //                                                                 TextAlign.start,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w300),
            //                                                           ),
            //                                                         ),
            //                                                         SizedBox(
            //                                                           height:
            //                                                               30,
            //                                                           width: 40,
            //                                                           child:
            //                                                               Text(
            //                                                             "${state.scoringTournament[index].pg ?? 0}",
            //                                                             textAlign:
            //                                                                 TextAlign.center,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w900),
            //                                                           ),
            //                                                         )
            //                                                       ],
            //                                                     ),
            //                                                     Row(
            //                                                       children: [
            //                                                         SizedBox(
            //                                                           width: 40,
            //                                                           height:
            //                                                               30,
            //                                                           child:
            //                                                               Text(
            //                                                             "PE",
            //                                                             textAlign:
            //                                                                 TextAlign.center,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w900),
            //                                                           ),
            //                                                         ),
            //                                                         SizedBox(
            //                                                           height:
            //                                                               30,
            //                                                           width:
            //                                                               250,
            //                                                           child:
            //                                                               Text(
            //                                                             "Partidos empatados:",
            //                                                             textAlign:
            //                                                                 TextAlign.start,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w300),
            //                                                           ),
            //                                                         ),
            //                                                         SizedBox(
            //                                                           height:
            //                                                               30,
            //                                                           width: 40,
            //                                                           child:
            //                                                               Text(
            //                                                             "${state.scoringTournament[index].pe ?? 0}",
            //                                                             textAlign:
            //                                                                 TextAlign.center,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w900),
            //                                                           ),
            //                                                         )
            //                                                       ],
            //                                                     ),
            //                                                     Row(
            //                                                       children: [
            //                                                         SizedBox(
            //                                                           width: 40,
            //                                                           height:
            //                                                               30,
            //                                                           child:
            //                                                               Text(
            //                                                             "PP",
            //                                                             textAlign:
            //                                                                 TextAlign.center,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w900),
            //                                                           ),
            //                                                         ),
            //                                                         SizedBox(
            //                                                           height:
            //                                                               30,
            //                                                           width:
            //                                                               250,
            //                                                           child:
            //                                                               Text(
            //                                                             "Partidos perdidos:",
            //                                                             textAlign:
            //                                                                 TextAlign.start,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w300),
            //                                                           ),
            //                                                         ),
            //                                                         SizedBox(
            //                                                           height:
            //                                                               30,
            //                                                           width: 40,
            //                                                           child:
            //                                                               Text(
            //                                                             "${state.scoringTournament[index].pp ?? 0}",
            //                                                             textAlign:
            //                                                                 TextAlign.center,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w900),
            //                                                           ),
            //                                                         )
            //                                                       ],
            //                                                     ),
            //                                                     Row(
            //                                                       children: [
            //                                                         SizedBox(
            //                                                           width: 40,
            //                                                           height:
            //                                                               30,
            //                                                           child:
            //                                                               Text(
            //                                                             "GC",
            //                                                             textAlign:
            //                                                                 TextAlign.center,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w900),
            //                                                           ),
            //                                                         ),
            //                                                         SizedBox(
            //                                                           height:
            //                                                               30,
            //                                                           width:
            //                                                               250,
            //                                                           child:
            //                                                               Text(
            //                                                             "Goles en contra:",
            //                                                             textAlign:
            //                                                                 TextAlign.start,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w300),
            //                                                           ),
            //                                                         ),
            //                                                         SizedBox(
            //                                                           height:
            //                                                               30,
            //                                                           width: 40,
            //                                                           child:
            //                                                               Text(
            //                                                             "${state.scoringTournament[index].gc ?? 0}",
            //                                                             textAlign:
            //                                                                 TextAlign.center,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w900),
            //                                                           ),
            //                                                         )
            //                                                       ],
            //                                                     ),
            //                                                     Row(
            //                                                       children: [
            //                                                         SizedBox(
            //                                                           width: 40,
            //                                                           height:
            //                                                               30,
            //                                                           child:
            //                                                               Text(
            //                                                             "GF",
            //                                                             textAlign:
            //                                                                 TextAlign.center,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w900),
            //                                                           ),
            //                                                         ),
            //                                                         SizedBox(
            //                                                           height:
            //                                                               30,
            //                                                           width:
            //                                                               250,
            //                                                           child:
            //                                                               Text(
            //                                                             "Goles a favor:",
            //                                                             textAlign:
            //                                                                 TextAlign.start,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w300),
            //                                                           ),
            //                                                         ),
            //                                                         SizedBox(
            //                                                           height:
            //                                                               30,
            //                                                           width: 40,
            //                                                           child:
            //                                                               Text(
            //                                                             "${state.scoringTournament[index].gf ?? 0}",
            //                                                             textAlign:
            //                                                                 TextAlign.center,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w900),
            //                                                           ),
            //                                                         )
            //                                                       ],
            //                                                     ),
            //                                                     Row(
            //                                                       children: [
            //                                                         SizedBox(
            //                                                           width: 40,
            //                                                           height:
            //                                                               30,
            //                                                           child:
            //                                                               Text(
            //                                                             "DIF",
            //                                                             textAlign:
            //                                                                 TextAlign.center,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w900),
            //                                                           ),
            //                                                         ),
            //                                                         SizedBox(
            //                                                           height:
            //                                                               30,
            //                                                           width:
            //                                                               250,
            //                                                           child:
            //                                                               Text(
            //                                                             "Diferencia de goles:",
            //                                                             textAlign:
            //                                                                 TextAlign.start,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w300),
            //                                                           ),
            //                                                         ),
            //                                                         SizedBox(
            //                                                           height:
            //                                                               30,
            //                                                           width: 40,
            //                                                           child:
            //                                                               Text(
            //                                                             "${state.scoringTournament[index].dif ?? 0}",
            //                                                             textAlign:
            //                                                                 TextAlign.center,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w900),
            //                                                           ),
            //                                                         )
            //                                                       ],
            //                                                     ),
            //                                                     Row(
            //                                                       children: [
            //                                                         SizedBox(
            //                                                           width: 40,
            //                                                           height:
            //                                                               30,
            //                                                           child:
            //                                                               Text(
            //                                                             "PTS",
            //                                                             textAlign:
            //                                                                 TextAlign.center,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w900),
            //                                                           ),
            //                                                         ),
            //                                                         SizedBox(
            //                                                           height:
            //                                                               30,
            //                                                           width:
            //                                                               250,
            //                                                           child:
            //                                                               Text(
            //                                                             "Puntos:",
            //                                                             textAlign:
            //                                                                 TextAlign.start,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w300),
            //                                                           ),
            //                                                         ),
            //                                                         SizedBox(
            //                                                           height:
            //                                                               30,
            //                                                           width: 40,
            //                                                           child:
            //                                                               Text(
            //                                                             "${state.scoringTournament[index].pts ?? 0}",
            //                                                             textAlign:
            //                                                                 TextAlign.center,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w900),
            //                                                           ),
            //                                                         )
            //                                                       ],
            //                                                     ),
            //                                                     Row(
            //                                                       children: [
            //                                                         SizedBox(
            //                                                           width: 40,
            //                                                           height:
            //                                                               30,
            //                                                           child:
            //                                                               Text(
            //                                                             "PPS",
            //                                                             textAlign:
            //                                                                 TextAlign.center,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w900),
            //                                                           ),
            //                                                         ),
            //                                                         SizedBox(
            //                                                           height:
            //                                                               30,
            //                                                           width:
            //                                                               250,
            //                                                           child:
            //                                                               Text(
            //                                                             "Partidos perdidos por shootouts:",
            //                                                             textAlign:
            //                                                                 TextAlign.start,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w300),
            //                                                           ),
            //                                                         ),
            //                                                         SizedBox(
            //                                                           height:
            //                                                               30,
            //                                                           width: 40,
            //                                                           child:
            //                                                               Text(
            //                                                             "${state.scoringTournament[index].pps ?? 0}",
            //                                                             textAlign:
            //                                                                 TextAlign.center,
            //                                                             style: TextStyle(
            //                                                                 color: Colors
            //                                                                     .black,
            //                                                                 fontSize:
            //                                                                     15,
            //                                                                 fontWeight:
            //                                                                     FontWeight.w900),
            //                                                           ),
            //                                                         )
            //                                                       ],
            //                                                     ),
            //                                                   ],
            //                                                 ),
            //                                               ],
            //                                             ),
            //                                           ),
            //                                         ),
            //                                         Positioned(
            //                                           left: 280.0,
            //                                           top: 10,
            //                                           right: 0.0,
            //                                           child: TextButton(
            //                                             onPressed: () async {
            //                                               Navigator.pop(
            //                                                   context);
            //                                             },
            //                                             child: Container(
            //                                               padding:
            //                                                   const EdgeInsets
            //                                                           .fromLTRB(
            //                                                       18.0,
            //                                                       10.0,
            //                                                       18.0,
            //                                                       10.0),
            //                                               decoration:
            //                                                   const BoxDecoration(
            //                                                 color: Color(
            //                                                     0xff740408),
            //                                                 borderRadius:
            //                                                     BorderRadius.all(
            //                                                         Radius.circular(
            //                                                             15.0)),
            //                                               ),
            //                                               child: Text(
            //                                                 'Salir',
            //                                                 style: TextStyle(
            //                                                   fontFamily:
            //                                                       'SF Pro',
            //                                                   color: Colors
            //                                                       .grey[200],
            //                                                   fontWeight:
            //                                                       FontWeight
            //                                                           .w500,
            //                                                   fontSize: 12.0,
            //                                                 ),
            //                                               ),
            //                                             ),
            //                                           ),
            //                                         ),
            //                                       ],
            //                                     );
            //                                   },
            //                                 );
            //                               },
            //                               icon: Icon(
            //                                 Icons.add_circle,
            //                                 color: Color(0xff358aac),
            //                                 size: 20,
            //                               )),
            //                         )),
            //                   ]),
            //             ),
            //           ],
            //         );
            //         //     TablePage()
            //       }),
            //   Positioned(
            //     bottom: 0.0,
            //     left: 0.0,
            //     right: 0.0,
            //     child: Container(
            //       height: 65.0,
            //       color: Colors.black87,
            //       padding: const EdgeInsets.only(right: 10, left: 10),
            //       child: Center(
            //         child: Text(
            //           'J: Partidos jugados.       G: Partidos ganados.        E: Partidos empatados.\n'
            //           'P: Partidos perdidos.      DIF: Diferencia de goles.     PTS: Puntos totales.',
            //           style: TextStyle(color: Colors.grey[200], fontSize: 10),
            //         ),
            //       ),
            //     ),
            //   ),
            // ]);
          }
        },
      ),
    );
  }
}
