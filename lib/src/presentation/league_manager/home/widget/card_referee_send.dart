import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../app/app.dart';
import '../referee/availability_referee/view/availibility_referee_page.dart';
import '../referee/detail_referee_league_manager.dart';
import '../referee/search_referee/cubit/referee_search_cubit.dart';

class CardRefereeSend extends StatelessWidget {
  const CardRefereeSend(
      {Key? key,
      required this.name,
      required this.photo,
      required this.refereeId})
      : super(key: key);

  final String name;
  final String photo;
  final int? refereeId;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final league =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
    return BlocConsumer<RefereeSearchCubit, RefereeSearchState>(
      listener: (context, state) {
        if (state.screenStatus == ScreenStatus.error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(state.errorMessage ?? 'Error'),
            ));
        } else if (state.screenStatus == ScreenStatus.success) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  content: Text('Solicitud enviada correctamente'),
                  duration: Duration(seconds: 5)),
            );
          /* context.read<RepresentativeTeamsCubit>().getRepresentativeTeams(personId: personId!);
          Navigator.pop(context);*/
        }
      },
      builder: (context, state) {
        if (state.screenStatus == ScreenStatus.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.blueAccent, size: 50),
          );
        }
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (dialogContext) {
                return BlocProvider.value(
                  value: BlocProvider.of<RefereeSearchCubit>(context),
                  child: BlocBuilder<RefereeSearchCubit, RefereeSearchState>(
                    builder: (context, state) {
                      return AlertDialog(
                        backgroundColor: Colors.grey[200],
                        title: const Text('Información del árbitro'),
                        content:
                            DetailRefereeLeagueManager(refereeId: refereeId!),
                        actions: state.screenStatus == ScreenStatus.sending
                            ? [
                                const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ]
                            : [
                                TextButton(
                                  onPressed: () => Navigator.pop(dialogContext),
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        16.0, 10.0, 16.0, 10.0),
                                    decoration: const BoxDecoration(
                                      color: Color(0xff740426),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    child: Text(
                                      'Cerrar',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'SF Pro',
                                        color: Colors.grey[200],
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.0,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(dialogContext);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            AvailabilityRefereePage(
                                                refereeId: refereeId),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.calendar_month,
                                      size: 25),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context
                                        .read<RefereeSearchCubit>()
                                        .onSendRequest(
                                            refereeId!, league.leagueId);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        16.0, 10.0, 16.0, 10.0),
                                    decoration: const BoxDecoration(
                                      color: Color(0xff358aac),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    child: Text(
                                      'Enviar Solicitud',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'SF Pro',
                                        color: Colors.grey[200],
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                      );
                    },
                  ),
                );
              },
            );
          },
          child: Card(
              color: Colors.grey[100],
              elevation: 3.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: 15,
                        bottom: 8,
                      ),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[100],
                        child: Image.asset(
                          'assets/images/referee.png',
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12, bottom: 8),
                      child: Text(
                        name,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 12,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
