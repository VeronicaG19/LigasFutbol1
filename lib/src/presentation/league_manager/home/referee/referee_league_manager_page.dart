import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/home/referee/search_referee_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/home/widget/card_referee.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../service_locator/injection.dart';
import '../../../app/bloc/authentication_bloc.dart';
import 'cubit/referee_lm_cubit.dart';

class RefereeLeagueManagerPage extends StatelessWidget {
  const RefereeLeagueManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);

    return BlocProvider(
        create: (_) => locator<RefereeLmCubit>()
          ..loadReferee(leagueId: leagueManager.leagueId),
        child: BlocConsumer<RefereeLmCubit, RefereeLmState>(
            listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text("Se agrego el arbitro correctamente"),
                ),
              );
          } else if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text("Error al crear el arbitro"),
                ),
              );
          }
        }, builder: (context, state) {
          if (state.screenStatus == ScreenStatus.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: const Color(0xff358aac),
                size: 50,
              ),
            );
          } else {
            return ListView(
              shrinkWrap: true,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        /*TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (contextD) {
                                  return BlocProvider.value(
                                      value: BlocProvider.of<RefereeLmCubit>(
                                          context),
                                      child: const ShowCreateReferee());
                                });
                          },
                          child: Container(
                            padding:
                                const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                            decoration: const BoxDecoration(
                              color: Color(0xff0791a3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            height: 35,
                            width: 150,
                            child: Text(
                              'Crear árbitro',
                              style: TextStyle(
                                fontFamily: 'SF Pro',
                                color: Colors.grey[200],
                                fontWeight: FontWeight.w500,
                                fontSize: 13.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                        ,*/
                        TextButton(
                          onPressed: () async {
                            Navigator.push(
                              context,
                              SearchRefereePage.route(),
                            );
                          },
                          child: Container(
                            padding:
                                const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                            decoration: const BoxDecoration(
                              color: Color(0xff0791a3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            height: 35,
                            width: 150,
                            child: Text(
                              'Buscar árbitros',
                              style: TextStyle(
                                fontFamily: 'SF Pro',
                                color: Colors.grey[200],
                                fontWeight: FontWeight.w500,
                                fontSize: 13.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ) // ShowCreateReferee()
                      ],
                    ),
                  ],
                ),
                GridView.builder(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  itemCount: state.refereetList.length,
                  itemBuilder: (context, index) {
                    print(state.refereetList[index].refereePhoto);
                    return CardReferee(
                      name: state.refereetList[index].refereeName,
                      photo: state.refereetList[index].refereePhoto ?? '',
                      refereeId: state.refereetList[index].refereeId,
                      activeId: state.refereetList[index].activeId,
                    );
                  },
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      childAspectRatio: 1,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0),
                ),
              ],
            );
          }
        }));
  }
}
