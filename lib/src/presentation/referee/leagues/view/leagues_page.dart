import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/enums.dart';
import '../../../../domain/leagues/entity/league.dart';
import '../../../../service_locator/injection.dart';
import '../../../app/app.dart';
import '../cubit/ref_league_cubit.dart';

class LeaguesPage extends StatelessWidget {
  const LeaguesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<RefLeagueCubit>()..onLoadInitialData(),
      child: const _PageContent(),
    );
  }
}

class _PageContent extends StatelessWidget {
  const _PageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final refereeId = context
        .select((AuthenticationBloc bloc) => bloc.state.refereeData.refereeId);
    final rol = context
        .select((AuthenticationBloc bloc) => bloc.state.user.applicationRol);
    return BlocConsumer<RefLeagueCubit, RefLeagueState>(
      listenWhen: (previous, state) =>
          previous.screenState != state.screenState &&
          state.screenState == BasicCubitScreenState.success,
      listener: (context, state) {
        context
            .read<NotificationBloc>()
            .add(LoadNotificationCount(refereeId, rol));
      },
      builder: (context, state) {
        if (state.screenState == BasicCubitScreenState.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: const Color(0xff358aac),
              size: 50,
            ),
          );
        }
        return ListView(
          children: [
            SizedBox(
              height: 55,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Buscar por nombre de liga',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(35.0),
                      ),
                    ),
                  ),
                  onChanged: context.read<RefLeagueCubit>().onFilterList,
                ),
              ),
            ),
            // SeekPlayerDialog(),
            SingleChildScrollView(
              child: GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                    top: 15, left: 15, right: 15, bottom: 65),
                itemCount: state.leagueList.length,
                physics: const NeverScrollableScrollPhysics(),
                //physics: const ScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2 / 2.5,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0),
                itemBuilder: (BuildContext ctx, index) {
                  return InkWell(
                    child: Card(
                      color: Colors.grey[100],
                      elevation: 3.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[100],
                            child: Image.asset(
                              'assets/images/league2.png',
                              color: const Color(0xff358aac),
                              width: 60,
                              height: 60,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            state.leagueList[index].leagueName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 12,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return BlocProvider.value(
                            value: BlocProvider.of<RefLeagueCubit>(context),
                            child: _AlertDialogWidget(
                              league: state.leagueList[index],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ), /* ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: state.leagueList.length,
                itemBuilder: (BuildContext ctx, index) => ListTile(
                  leading: const Icon(Icons.sports_volleyball),
                  title: Text(state.leagueList[index].leagueName),
                  subtitle:
                      Text(state.leagueList[index].leagueDescription ?? ''),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (contextD) {
                        return BlocProvider.value(
                          value: BlocProvider.of<RefLeagueCubit>(context),
                          child: _AlertDialogWidget(
                            league: state.leagueList[index],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),*/
            ),
          ],
        );
      },
    );
  }
}

class _AlertDialogWidget extends StatelessWidget {
  const _AlertDialogWidget({Key? key, required this.league}) : super(key: key);
  final League league;

  @override
  Widget build(BuildContext context) {
    final referee =
        context.select((AuthenticationBloc bloc) => bloc.state.refereeData);
    return BlocBuilder<RefLeagueCubit, RefLeagueState>(
      builder: (context, state) {
        return AlertDialog(
          title: const Text('Detalle de liga'),
          content: _LeagueDetailContent(
            league: league,
          ),
          actions: state.screenState == BasicCubitScreenState.sending
              ? [
                  Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                      color: Color(0xff358aac),
                      size: 50,
                    ),
                  ),
                ]
              : [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('CANCELAR'),
                  ),
                  TextButton(
                      onPressed: () {
                        context.read<RefLeagueCubit>().onSendRequest(
                            referee.refereeId ?? 0, league.leagueId);
                      },
                      child: const Text('ENVIAR SOLICITUD')),
                ],
        );
      },
    );
  }
}

class _LeagueDetailContent extends StatelessWidget {
  const _LeagueDetailContent({Key? key, required this.league})
      : super(key: key);

  final League league;

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
    );
    const subTitleStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );
    return BlocListener<RefLeagueCubit, RefLeagueState>(
      listenWhen: (_, state) =>
          state.screenState == BasicCubitScreenState.success ||
          state.screenState == BasicCubitScreenState.error,
      listener: (context, state) {
        if (state.screenState == BasicCubitScreenState.success) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
                content: Text('Se ha enviado la solicitud a la liga')));
          Navigator.pop(context);
        } else if (state.screenState == BasicCubitScreenState.error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                SnackBar(content: Text(state.errorMessage ?? 'Error')));
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(league.leagueName, style: titleStyle),
            subtitle: Text(league.leagueDescription ?? 'Sin descripción',
                style: subTitleStyle),
          ),
          SizedBox(
            height: 15,
          ),
          const Text(
            'Categorías de la liga',
            textAlign: TextAlign.center,
            style: titleStyle,
          ),
          SizedBox(
            height: 15,
          ),
          Card(
            child: SizedBox(
              height: 150,
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    //TODO: Obtener las categorias de una liga
                    Text(
                      "Sin categorías",
                      style: subTitleStyle,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
