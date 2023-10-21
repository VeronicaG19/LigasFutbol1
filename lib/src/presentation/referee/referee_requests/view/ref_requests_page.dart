import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../service_locator/injection.dart';
import '../../../app/bloc/authentication_bloc.dart';
import '../cubit/referee_request_cubit.dart';
import 'ref_requests_content.dart';

class RefRequestsPage extends StatelessWidget {
  const RefRequestsPage({Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute(
        builder: (_) => const RefRequestsPage(),
      );

  @override
  Widget build(BuildContext context) {
    final person = context.read<AuthenticationBloc>().state.user.person;
    final referee =
        context.select((AuthenticationBloc bloc) => bloc.state.refereeData);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Solicitudes",
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[200],
          flexibleSpace: const Image(
            image: AssetImage('assets/images/imageAppBar25.png'),
            fit: BoxFit.fill,
          ),
          elevation: 0.0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: Colors.white70,
                    indicatorWeight: 1.0,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white38),
                    tabs: [
                      Tab(
                        height: 25,
                        iconMargin: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: Colors.white70, width: 1.5)),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text("Enviadas",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10)),
                          ),
                        ),
                      ),
                      Tab(
                        height: 25,
                        iconMargin: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: Colors.white70, width: 1.5)),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text("Recibidas",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10)),
                          ),
                        ),
                      ),
                      Tab(
                        height: 25,
                        iconMargin: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: Colors.white70, width: 1.5)),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text("Partidos",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10)),
                          ),
                        ),
                      ),
                      // Tab(
                      //   height: 25,
                      //   iconMargin: const EdgeInsets.all(10),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(50),
                      //         border: Border.all(
                      //             color: Colors.white70, width: 1.5)),
                      //     child: const Align(
                      //       alignment: Alignment.center,
                      //       child: Text("Recomendaciones",
                      //           textAlign: TextAlign.center,
                      //           style: TextStyle(fontSize: 10)),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: BlocProvider(
          create: (_) => locator<RefereeRequestCubit>()
            ..loadUserRequests(
                personId: person.personId!, refereeId: referee.refereeId ?? 0),
          child: const RefRequestsContent(),
        ),
      ),
    );
  }
}
