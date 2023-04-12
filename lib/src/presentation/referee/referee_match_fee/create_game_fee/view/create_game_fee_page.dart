import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../service_locator/injection.dart';
import '../../../../widgets/app_bar_page.dart';
import '../cubit/create_game_fee_cubit.dart';
import 'create_game_fee_content.dart';

class CreateGameFeePage extends StatelessWidget{
  const CreateGameFeePage({Key? key}) : super(key: key);
  /*static Route route(RefereeMatchFeeListCubit cubit) =>
      MaterialPageRoute(builder: (_) => BlocProvider.value(value: cubit,
          child: const CreateGameFeePage()));*/
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      locator<CreateGameFeeCubit>()..loadFootballType(),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBarPage(
            title: "Crear nueva tarifa",
            size: 70,
          ),
        ),
        body: const CreateGameFeeContent(),
      ),
    );
  }
}