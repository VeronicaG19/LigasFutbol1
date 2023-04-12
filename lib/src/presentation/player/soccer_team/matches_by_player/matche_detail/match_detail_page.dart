import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'cubit/match_detail_cubit.dart';

class MatchesDetailPage extends StatelessWidget {
  const MatchesDetailPage({Key? key, required this.matchId}) : super(key: key);
  final int? matchId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            backgroundColor: Colors.grey[200],
            title: Text(
              'Detalle del partido',
            ),
            flexibleSpace: Image(
              image: AssetImage('assets/images/imageAppBar25.png'),
              fit: BoxFit.cover,
            ),
            elevation: 0.0,
          ),
        ),
        body: BlocProvider(
          create: (_) => locator<MatchDetailCubit>()
            ..getDetailMatchByPlayer(matchId: matchId!),
          child: BlocBuilder<MatchDetailCubit, MatcheDetailState>(
            builder: (context, state) {
              if (state.screenStatus == ScreenStatus.loading) {
                return Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                    color: const Color(0xff358aac),
                    size: 50,
                  ),
                );
              } else {
                return ListView.builder(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    itemCount: state.detailMatchDTO.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 35,
                          ),
                          Text(
                            "${state.detailMatchDTO[index].campo ?? "No hay campos definido aún"}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${state.detailMatchDTO[index].direccion ?? "Sin dirección"}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${state.detailMatchDTO[index].fecha ?? "No hay fecha definida aún"}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: <Widget>[
                                      Image(
                                        image: AssetImage(
                                            'assets/images/playera4.png'),
                                        fit: BoxFit.fitWidth,
                                        height: 80,
                                        width: 80,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          "${state.detailMatchDTO[index].visitante}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "${state.detailMatchDTO[index].marcadorLocal ?? ''}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 40,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        """${state.detailMatchDTO[index].shootoutLocal == null ? ''
                                            :"(${state.detailMatchDTO[index].shootoutLocal})"}""",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "-",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "${state.detailMatchDTO[index].marcadorVisitante ?? ''}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 40,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        """${state.detailMatchDTO[index].shootoutVisit == null ? ''
                                            :"(${state.detailMatchDTO[index].shootoutVisit})"}""",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Image(
                                        image: AssetImage(
                                            'assets/images/playera4.png'),
                                        fit: BoxFit.fitWidth,
                                        height: 80,
                                        width: 80,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      SizedBox(
                                        child: Text(
                                          "${state.detailMatchDTO[index].local}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        width: 100,
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                    ],
                                  ),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "${state.detailMatchDTO[index].estado ?? "Sin resultado"}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Text(
                                "Arbitro : ${state.detailMatchDTO[index].arbitro ?? "Sin Arbitro"}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              /*  Text(
                                "Cambios : ${state.detailMatchDTO[index].cambiosIlimitados ?? "Sin cambios"}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),*/
                            ],
                          ),
                        ],
                      );
                      //     TablePage()
                    });
              }
            },
          ),
        ));
  }
}