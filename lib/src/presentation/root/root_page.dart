import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

import '../app/bloc/authentication_bloc.dart';
import 'page_roles/page_roles.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  static Page page() => const MaterialPage<void>(child: RootPage());

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<ApplicationRol>(
        state: context.select(
            (AuthenticationBloc bloc) => bloc.state.user.applicationRol),
        onGeneratePages: onGenerateRolViewPages);
  }
}
