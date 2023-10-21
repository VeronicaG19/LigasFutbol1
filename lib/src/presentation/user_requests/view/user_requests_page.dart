import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../service_locator/injection.dart';
import '../../app/app.dart';
import '../cubit/user_requests_cubit.dart';
import 'user_requests_content.dart';

class UserRequestsPage extends StatelessWidget {
  const UserRequestsPage({
    Key? key,
  }) : super(key: key);

  static Route route() => MaterialPageRoute(
        builder: (_) => const UserRequestsPage(),
      );

  @override
  Widget build(BuildContext context) {
    final personId =
        context.read<AuthenticationBloc>().state.user.person.personId;
    return DefaultTabController(
      length: 2,
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
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Solicitudes enviadas',
              ),
              Tab(
                text: 'Solicitudes recibidas',
              )
            ],
          ),
        ),
        body: BlocProvider(
          create: (_) => locator<UserRequestsCubit>()
            ..loadUserRequests(personId: personId!),
          child: const UserRequestsContent(),
        ),
      ),
    );
  }
}
