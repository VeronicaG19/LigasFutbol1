import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/domain/team_player/entity/team_player.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'cubit/transfer_history_cubit.dart';

class TransferHistoryPage extends StatefulWidget {
  const TransferHistoryPage({Key? key, required this.teamPlayer})
      : super(key: key);
  final TeamPlayer teamPlayer;
  @override
  _TransferHistoryPageState createState() => _TransferHistoryPageState();
}

class _TransferHistoryPageState extends State<TransferHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<TransferHistoryCubit>()
        ..getTransferHistoryPlayer(partyId: widget.teamPlayer.partyId!),
      child: BlocBuilder<TransferHistoryCubit, TransferHistoryState>(
        builder: (context, state) {
          if (state.screenStatus == ScreenStatus.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: const Color(0xff358aac),
                size: 50,
              ),
            );
          } else {
            return state.teamList.isEmpty
                ? Container()
                : ListView.builder(
                    itemCount: state.teamList.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            child: Container(
                              color: Colors.grey[100],
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, top: 8, bottom: 8),
                              height: 120,
                              child: Row(children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.teamList[index].teamName!,
                                      style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                        width: 250,
                                        child: Text(
                                          'Liga ${state.teamList[index].categoryId?.leagueId?.leagueName ?? '-'}',
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        )),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Categoría ${state.teamList[index].categoryId?.categoryName ?? '-'}',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: const [
                                        Text(
                                          'Status: ',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'Activo',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.grey[100],
                                  child: Image.asset(
                                    'assets/images/equipo2.png',
                                    width: 80,
                                    height: 80,
                                  ),
                                )
                              ]),
                            ),
                            onTap: () {
                              /* showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                context: context,
                                builder: (contextS) {
                                  return Stack(
                                    children: [
                                      Padding(
                                        padding:
                                            MediaQuery.of(context).viewInsets,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 35, right: 15, left: 15),
                                          height: 350,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(20.0),
                                              topRight: Radius.circular(20.0),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Column(
                                                children: [
                                                  Column(
                                                    children: <Widget>[
                                                      Icon(
                                                          Icons
                                                              .workspace_premium_sharp,
                                                          size: 90,
                                                          color: Color(
                                                              0xffac9835)),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Text(
                                                        "Torneos en los que participo el jugador",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                      SizedBox(
                                                        height: 25,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Container(
                                                        height: 100,
                                                        width: 100,
                                                        child: InkWell(
                                                          child: Card(
                                                            color: Colors
                                                                .grey[100],
                                                            elevation: 3.0,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Image.network(
                                                                    'https://c0.klipartz.com/pngpicture/844/322/gratis-png-copa-del-mundo-de-futbol-americano-torneo-de-eliminacion-unica-la-asociacion-de-futbol-%E2%80%8B%E2%80%8Bcopa-thumbnail.png',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height: 60,
                                                                    width: 60),
                                                                Text(
                                                                  'Torneo 1',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                              .grey[
                                                                          800],
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          onTap: () {},
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 100,
                                                        height: 100,
                                                        child: Card(
                                                          elevation: 3.0,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Image.network(
                                                                  'https://c0.klipartz.com/pngpicture/844/322/gratis-png-copa-del-mundo-de-futbol-americano-torneo-de-eliminacion-unica-la-asociacion-de-futbol-%E2%80%8B%E2%80%8Bcopa-thumbnail.png',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  height: 60,
                                                                  width: 60),
                                                              Text(
                                                                'Torneo 2',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        800],
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 100,
                                                        width: 100,
                                                        child: Card(
                                                          color:
                                                              Colors.grey[100],
                                                          elevation: 3.0,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Image.network(
                                                                  'https://c0.klipartz.com/pngpicture/844/322/gratis-png-copa-del-mundo-de-futbol-americano-torneo-de-eliminacion-unica-la-asociacion-de-futbol-%E2%80%8B%E2%80%8Bcopa-thumbnail.png',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  height: 55,
                                                                  width: 55),
                                                              Text(
                                                                'Torneo 3',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        800],
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 280.0,
                                        top: 10,
                                        right: 0.0,
                                        child: TextButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                18.0, 10.0, 18.0, 10.0),
                                            decoration: const BoxDecoration(
                                              color: Color(0xff740408),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0)),
                                            ),
                                            child: Text(
                                              'Salir',
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
                              );*/
                            },
                          )
                        ],
                      );
                    });
          }
        },
      ),
    );
  }
}
