import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/requests/cubit/representantive_requests_cubit.dart';

import '../../../../service_locator/injection.dart';
import '../../../app/app.dart';
import 'rep_requests_content.dart';

class RepRequestsPage extends StatelessWidget {
  const RepRequestsPage({Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute(
        builder: (_) => const RepRequestsPage(),
      );
  @override
  Widget build(BuildContext context) {
    final teamId = context.read<AuthenticationBloc>().state.selectedTeam.teamId;
    print('TEAM_ID -->$teamId');
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Solicitudes"),
          backgroundColor: Colors.grey[200],
          flexibleSpace: const Image(
            image: AssetImage('assets/images/imageAppBar25.png'),
            fit: BoxFit.fill,
          ),
          elevation: 0.0,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Recibidas',
              ),
              Tab(
                text: 'Enviadas',
              ),
              Tab(
                text: 'Ligas',
              ),
            ],
          ),
        ),
        body: BlocProvider(
          create: (_) => locator<RepresentantiveRequestsCubit>()
            ..loadRepresentativeRequests(teamId: teamId!),
          child: const RepRequestsContent(),
        ),
      ),
    );
  }
}
