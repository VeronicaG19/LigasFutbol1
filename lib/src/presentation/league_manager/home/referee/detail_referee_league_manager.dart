import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../service_locator/injection.dart';
import '../widget/referee_rating.dart';
import 'cubit/referee_lm_cubit.dart';

class DetailRefereeLeagueManager extends StatelessWidget {
  const DetailRefereeLeagueManager({Key? key, required this.refereeId})
      : super(key: key);

  final int refereeId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      height: 600,
      child: BlocProvider(
        create: (_) =>
            locator<RefereeLmCubit>()..detailReferee(refereeId: refereeId),
        child: BlocBuilder<RefereeLmCubit, RefereeLmState>(
            builder: (context, state) {
          if (state.screenStatus == ScreenStatus.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: const Color(0xff358aac),
                size: 50,
              ),
            );
          } else {
            return ListView(shrinkWrap: true, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: const Color(0xff0791a3),
                    child: Icon(
                      //    Icons.sports_basketball_sharp,
                      Icons.pix,
                      size: 100,
                      color: Colors.grey[200],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              isDense: true,
                              labelText: 'Nombre :',
                              enabled: false),
                          style: TextStyle(fontSize: 13),
                          initialValue: state.refereeDetailDTO.refereeName,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(
                          bottom: 10, top: 10, right: 10, left: 10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            isDense: true,
                            labelText: 'Dirección :',
                            enabled: false),
                        style: TextStyle(fontSize: 13),
                        initialValue: state.refereeDetailDTO.refereeAddress,
                      ),
                    ))
                  ],
                ),
                RefereeRating(refereeId: refereeId),
                SizedBox(
                  height: 10,
                ),
                /*Container(
                    child: Text("texto 1"),
                  )*/
              ]),
            ]);
          }
        }),
      ),
    );
  }
}

/**
 *
    child: ListView(shrinkWrap: true, children: [
    Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
    SizedBox(
    height: 10,
    ),
    CircleAvatar(
    radius: 70,
    backgroundColor: Color(0xff045a74),
    child: Image(
    image: AssetImage('assets/images/referee.png'),
    height: 90,
    width: 90,
    color: Colors.grey[300],
    ),
    ),
    SizedBox(
    height: 30,
    ),
    TextFormField(
    decoration: const InputDecoration(
    isDense: true, labelText: 'Nombre :', enabled: false),
    initialValue: "Adonai escobedo",
    ),
    SizedBox(
    height: 10,
    ),
    TextFormField(
    decoration: const InputDecoration(
    isDense: true, labelText: 'Direccion :', enabled: false),
    initialValue: "Edomex",
    ),
    RefereeRating(),
    Container(
    child: Text("texto 1"),
    )
    ]),
    ]),
 */
