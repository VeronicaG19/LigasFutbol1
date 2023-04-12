import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/match_events_list/cubit/match_events_list_cubit.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'match_events_content.dart';

class MatchEventsListPage extends StatelessWidget{
  const MatchEventsListPage({Key? key,
    required this.teamMatchId,
    required this.teamName,})
      : super(key: key);

  final int teamMatchId;
  final String teamName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(teamName),
        backgroundColor: Colors.grey[200],
        flexibleSpace: const Image(
          image: AssetImage('assets/images/imageAppBar25.png'),
          fit: BoxFit.fill,
        ),
        elevation: 0.0,
      ),
      body: BlocProvider(
        create: (_) => locator<MatchEventsListCubit>()..loadEventsReferee(teamMatchId: teamMatchId ?? 0),
        child: const MatchEventsListContent(),
      ),
    );
  }
}