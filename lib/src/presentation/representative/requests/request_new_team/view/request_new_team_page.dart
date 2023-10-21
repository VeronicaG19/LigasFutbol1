import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../service_locator/injection.dart';
import '../cubit/request_new_team_cubit.dart';
import 'dropdown_button_leagues_page.dart';

class RequestNewTeamPage extends StatelessWidget {
  const RequestNewTeamPage({Key? key}) : super(key: key);
  static Route route() =>
      MaterialPageRoute<void>(builder: (_) => const RequestNewTeamPage());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Solicitud a una liga"),
          backgroundColor: Colors.grey[200],
          flexibleSpace: const Image(
            image: AssetImage('assets/images/imageAppBar25.png'),
            fit: BoxFit.fill,
          ),
          elevation: 0.0,
        ),
        body: BlocProvider(
          create: (_) => locator<RequestNewTeamCubit>()..availableLeagues(),
          child: const DropDownButtonLeaguesPage(),
        ));
  }
}
