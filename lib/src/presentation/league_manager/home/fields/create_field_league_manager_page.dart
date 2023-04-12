import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/widgets/app_bar_page.dart';

import 'create_field_league_manager.dart';
import 'cubit/field_lm_cubit.dart';

class CraeteFieldLeagueManagerPage extends StatelessWidget {
  const CraeteFieldLeagueManagerPage({Key? key}) : super(key: key);

    static Route route(FieldLmCubit cubit) =>
      MaterialPageRoute(builder: (_) => BlocProvider.value(value: cubit,
        child: const CraeteFieldLeagueManagerPage(),));

       // FieldLmCubit, FieldLmState

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: AppBarPage(
            title: "Crear campo",
            size: 100,
          ),
        ),
        body: const CreateFieldLeagueManager());
  }
}
