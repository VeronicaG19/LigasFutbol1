import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../service_locator/injection.dart';
import '../../../app/app.dart';
import '../cubit/fo_request_cubit.dart';
import 'fo_request_content.dart';

class FoRequestPage extends StatelessWidget {
  const FoRequestPage({Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute(
        builder: (_) => const FoRequestPage(),
      );

  @override
  Widget build(BuildContext context) {
    final league = context.select(
        (AuthenticationBloc bloc) => bloc.state.selectedLeague.leagueId);
    return Scaffold(
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
      ),
      body: BlocProvider(
        create: (_) => locator<FoRequestCubit>()..onLoadInitialData(league),
        child: const FoRequestContent(),
      ),
    );
  }
}
