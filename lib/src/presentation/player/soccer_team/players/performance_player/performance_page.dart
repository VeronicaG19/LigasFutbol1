import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/domain/team_player/entity/team_player.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/soccer_team/graph_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/player/soccer_team/players/performance_player/cubit/performance_player_cubit.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PerformancePage extends StatefulWidget {
  const PerformancePage({Key? key, required this.teamPlayer}) : super(key: key);
  final TeamPlayer teamPlayer;
  @override
  _PerformancePageState createState() => _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user.person.personId;
    return BlocProvider(
        //getTournamentByPlayer(user!),
        create: (_) =>
            locator<PerformancePlayerCubit>()..getTournamentByPlayer(user!),
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 30,
            ),
            PerformanceContent(teamPlayer: widget.teamPlayer),
            PerformanceContent2()
          ],
        ));
  }
}

class PerformanceContent extends StatefulWidget {
  const PerformanceContent({Key? key, required this.teamPlayer})
      : super(key: key);
  final TeamPlayer teamPlayer;
  @override
  State<PerformanceContent> createState() => _PerformanceContentState();
}

class _PerformanceContentState extends State<PerformanceContent> {
  String? selectedValue1;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PerformancePlayerCubit, PerformancePlayerState>(
      listener: (context, state) {
        if (state.screenStatus == ScreenStatus.error) {}
      },
      builder: (context, state) {
        return (state.tournamentList.isEmpty)
            ? Center(
                child: Text("No hay torneos para mostrar rendimiento."),
              )
            : Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                    ),
                    child: Container(
                      width: 10.0,
                      height: 50.0,
                      color: Color(0xff358aac),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Row(
                              children: const [
                                Icon(
                                  Icons.app_registration,
                                  size: 16,
                                  color: Colors.white70,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    'Torneos',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            items: state.tournamentList
                                .map((item) => DropdownMenuItem<String>(
                                      value: item.tournamentId.toString(),
                                      child: Text(
                                        item.tournamentName!,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[200],
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              print("Valor--->$value");
                              setState(() {
                                selectedValue1 = value as String;
                              });

                              context
                                  .read<PerformancePlayerCubit>()
                                  .getStaticsByTournament(
                                      widget.teamPlayer.partyId!,
                                      int.parse(value.toString()));
                            },
                            value: selectedValue1,
                            icon: const Icon(
                              Icons.arrow_forward_ios_outlined,
                            ),
                            iconSize: 14,
                            iconEnabledColor: Colors.white70,
                            itemHighlightColor: Colors.white70,
                            iconDisabledColor: Colors.white70,
                            buttonHeight: 40,
                            buttonWidth: double.infinity,
                            buttonPadding:
                                const EdgeInsets.only(left: 14, right: 14),
                            buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: const Color(0xff4ab9e8),
                              ),
                              color: const Color(0xff358aac),
                            ),
                            buttonElevation: 2,
                            itemHeight: 40,
                            itemPadding:
                                const EdgeInsets.only(left: 14, right: 14),
                            dropdownPadding: null,
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: const Color(0xff358aac),
                              ),
                              color: Colors.black54,
                            ),
                            dropdownElevation: 8,
                            scrollbarRadius: const Radius.circular(40),
                            scrollbarThickness: 6,
                            selectedItemHighlightColor: const Color(0xff358aac),
                            scrollbarAlwaysShow: true,
                            offset: const Offset(-20, 0),
                          ),
                        )),
                  )
                ],
              );
      },
    );
  }
}

class PerformanceContent2 extends StatelessWidget {
  const PerformanceContent2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PerformancePlayerCubit, PerformancePlayerState>(
      builder: (context, state) {
        if (state.screenStatus == ScreenStatus.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: const Color(0xff358aac),
              size: 50,
            ),
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.staticsList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          child: Container(
                              color: Colors.grey[100],
                              height: 110,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${state.staticsList[index].local ?? '-'} '
                                    '${state.staticsList[index].encuentro ?? '-'} '
                                    '${state.staticsList[index].visitante ?? '-'}',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Image(
                                              image: AssetImage(
                                                'assets/images/staticsImg.png',
                                              ),
                                              height: 50,
                                              width: 50),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                      ),
                                      SizedBox(width: 20),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              child: Text(
                                                'Goles ${state.staticsList[index].goles ?? '-'}',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              width: 250),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Rojas: ${state.staticsList[index].redCards ?? '-'}',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Amarillas: ${state.staticsList[index].yellowCard ?? '-'}',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              )),
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
                    //     TablePage()
                  })
            ],
          );
        }
      },
    );
  }
}

class Example2 extends StatelessWidget {
  const Example2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          height: 25,
          width: double.infinity,
          color: Colors.black,
          child: Center(
            child: Text(
              "Porcentaje de goles por partido",
              style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: PieChartSample1(),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: 30,
          width: double.infinity,
          color: Colors.black,
          child: Center(
            child: Text(
              "Tarjetas amarillas por partido",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: PieChartSample1(),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: 30,
          width: double.infinity,
          color: Colors.black,
          child: Center(
            child: Text(
              "Tarjetas rojas por partido",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: PieChartSample1(),
        ),
        SizedBox(
          height: 15,
        ),

/*  Flexible(
          child: Padding(
              padding: EdgeInsets.only(right: 15),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Row(
                    children: const [
                      Icon(
                        Icons.app_registration,
                        size: 16,
                        color: Colors.white70,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'Torneo',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  items: liga
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[200],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  value: selectedValue1,
                  onChanged: (value) {
                    setState(() {
                      selectedValue1 = value as String;
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                  iconSize: 14,
                  iconEnabledColor: Colors.white70,
                  itemHighlightColor: Colors.white70,
                  iconDisabledColor: Colors.white70,
                  buttonHeight: 40,
                  buttonWidth: double.infinity,
                  buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xff4ab9e8),
                    ),
                    color: const Color(0xff358aac),
                  ),
                  buttonElevation: 2,
                  itemHeight: 40,
                  itemPadding: const EdgeInsets.only(left: 14, right: 14),
                  dropdownPadding: null,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xff358aac),
                    ),
                    color: Colors.black54,
                  ),
                  dropdownElevation: 8,
                  scrollbarRadius: const Radius.circular(40),
                  scrollbarThickness: 6,
                  selectedItemHighlightColor: const Color(0xff358aac),
                  scrollbarAlwaysShow: true,
                  offset: const Offset(-20, 0),
                ),
              )),
        )*/
      ],
    );
  }
}
