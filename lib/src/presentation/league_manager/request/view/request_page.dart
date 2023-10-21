import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/enums.dart';
import '../../../app/app.dart';
import '../cubit/lm_request_cubit.dart';
import 'lm_request_content.dart';

class LMRequests extends StatelessWidget {
  const LMRequests({super.key});

  static Route route() => MaterialPageRoute(
        builder: (_) => const LMRequests(),
      );

  @override
  Widget build(BuildContext context) {
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
    return BlocProvider<LmRequestCubit>(
      create: (_) =>
          locator<LmRequestCubit>()..onLoadInitialData(leagueManager.leagueId),
      child: _RequestContent(
        leagueManagerId: leagueManager.leagueId,
      ),
    );
  }
}

class _RequestContent extends StatelessWidget {
  const _RequestContent({Key? key, this.leagueManagerId}) : super(key: key);

  final int? leagueManagerId;

  @override
  Widget build(BuildContext context) {
    final rol = context
        .select((AuthenticationBloc bloc) => bloc.state.user.applicationRol);

    return BlocConsumer<LmRequestCubit, LmRequestState>(
      listenWhen: (previous, current) =>
          previous.screenState != current.screenState,
      listener: (context, state) {
        if (state.screenState == BasicCubitScreenState.error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? ''),
              ),
            );
        } else if (state.screenState == BasicCubitScreenState.success) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Solicitud procesada con éxito.'),
              ),
            );
        }
        context
            .read<NotificationBloc>()
            .add(LoadNotificationCount(leagueManagerId, rol));
      },
      builder: (context, state) {
        if (state.screenState == BasicCubitScreenState.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
                color: Color(0xff358aac), size: 50),
          );
        }
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "Notificaciones",
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
              backgroundColor: Colors.grey[200],
              flexibleSpace: const Image(
                image: AssetImage('assets/images/imageAppBar25.png'),
                fit: BoxFit.fitWidth,
              ),
              elevation: 0.0,
              bottom: TabBar(
                onTap: context.read<LmRequestCubit>().onChangeTap,
                tabs: [
                  Tab(
                    text:
                        'Solicitudes a la liga (${state.notificationCounterRL})',
                  ),
                  Tab(
                    text:
                        'Solicitudes a los torneos (${(state.notificationCounterRTS + state.notificationCounterRTR)})',
                  ),
                  Tab(
                    text:
                        'Solicitudes de árbitros (${(state.notificationCounterRRS + state.notificationCounterRRR)})',
                  ),
                  const Tab(
                    text: 'Solicitudes de cambio de fecha',
                  ),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                //LeagueRequest(),
                LMRequestContent(
                  title: 'Solicitudes de Liga',
                  requestType: LMRequestType.league,
                ),
                //TournamentRequest(),
                LMRequestContent(
                  title: 'Solicitudes a los torneos',
                  requestType: LMRequestType.tournament,
                ),
                //RefereeRequest(),
                LMRequestContent(
                  title: 'Solicitudes de árbitros',
                  requestType: LMRequestType.referee,
                ),
                //DateChangingRequest(),
                LMRequestContent(
                  title: 'Solicitudes de cambio de fecha',
                  requestType: LMRequestType.dateChange,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
