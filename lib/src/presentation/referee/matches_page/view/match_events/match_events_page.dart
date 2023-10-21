import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/domain/matches/dto/referee_match.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/cubit/events/events_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/view/match_events/widgets/finish_match_button.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/view/match_events/widgets/minut_input.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/view/match_events/widgets/player_input.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/view/match_events/widgets/save_event_button.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/view/match_events/widgets/see_events_button.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/view/match_events/widgets/type_event_input.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/view/match_events/widgets/type_match_team_input.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../app/app.dart';
import '../../cubit/ref_matches_cubit.dart';

class MatchEventsPage extends StatelessWidget {
  const MatchEventsPage({
    super.key,
    required this.match,
  });

  final RefereeMatchDTO match;

  @override
  Widget build(BuildContext context) {
    final referee =
        context.select((AuthenticationBloc bloc) => bloc.state.refereeData);
    return BlocProvider(
      create: (context) =>
          locator<EventsCubit>()..onLoadingMatchEvents(match: match),
      child: BlocConsumer<EventsCubit, EventsState>(
        listener: (context, state) {
          if (state.screenState == BasicCubitScreenState.success) {
            if (state.statusMessage == "2") {
              showTopSnackBar(
                context,
                CustomSnackBar.success(
                  backgroundColor: Colors.green[800]!,
                  textScaleFactor: 1.0,
                  message: 'Se ha guardado el evento correctamente',
                ),
              );
              context
                  .read<RefMatchesCubit>()
                  .onLoadInitialData(referee.refereeId ?? 0);
              Navigator.pop(context);
            }
            if (state.statusMessage == "3") {
              showTopSnackBar(
                context,
                CustomSnackBar.success(
                  backgroundColor: Colors.green[800]!,
                  textScaleFactor: 1.0,
                  message: 'Se ha terminado el partido correctamente',
                ),
              );
              Navigator.pop(context);
              context
                  .read<RefMatchesCubit>()
                  .onLoadInitialData(referee.refereeId ?? 0);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[200],
              flexibleSpace: const Image(
                image: AssetImage('assets/images/imageAppBar25.png'),
                fit: BoxFit.cover,
              ),
              elevation: 0.0,
              title: Text(
                'Eventos',
                style: TextStyle(
                  color: Colors.grey[200],
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            body: (state.screenState == BasicCubitScreenState.loading)
                ? Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                      color: Colors.blue[800]!,
                      size: 50,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            TypeMatchTeamRadioIput(match: match),
                            const SizedBox(height: 30),
// * ---------------------------------------------------------------------------
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: const [
                                    SizedBox(height: 10),
                                    PlayerInput(),
                                    SizedBox(height: 10),
                                    TypeEventInput(),
                                    SizedBox(height: 10),
                                    MinutInput(),
                                    SizedBox(height: 10),
                                    SaveEventButton(),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
// * ---------------------------------------------------------------------------
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SeeEventsButton(
                                    teamMatchId2:
                                        state.matchDetail.teamMatchVisit!,
                                    matchId: state.matchDetail.matchId!,
                                    teamMatchId:
                                        state.matchDetail.teamMatchLocal!,
                                    teamName: state.matchDetail.localTeam!,
                                    teamName2: state.matchDetail.visitTeam!),
                                FinishMatchButton(match: match),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
