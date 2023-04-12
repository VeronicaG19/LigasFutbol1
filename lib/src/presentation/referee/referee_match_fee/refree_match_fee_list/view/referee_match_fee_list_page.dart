import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/referee_match_fee/refree_match_fee_list/view/referee_match_fee_list_content.dart';

import '../../../../../service_locator/injection.dart';
import '../../../../app/app.dart';
import '../cubit/referee_match_fee_list_cubit.dart';

class RefereeMatchFeeListPage extends StatelessWidget{
  const RefereeMatchFeeListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final referee = context.select((AuthenticationBloc bloc) => bloc.state.refereeData);
    return BlocProvider(
      create: (_) => locator<RefereeMatchFeeListCubit>()
        ..loadFeeList(activeId: referee.activeId!),
      child: const RefereeMatchFeeListContent(),
    );
  }
}

class _ButtonNewFee extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        /*Navigator.push(
            context,
            CreateGameFeePage.route(
                BlocProvider.of<RefereeMatchFeeListCubit>(context)
            )
        );*/
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
        decoration: const BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Text(
          'Agregar',
          style: TextStyle(
            fontFamily: 'SF Pro',
            color: Colors.grey[200],
            fontWeight: FontWeight.w500,
            fontSize: 10.0,
          ),
        ),
      ),
    );
  }
}