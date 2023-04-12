import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/widgets/app_bar_page.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../../core/enums.dart';
import '../../main_page/cubit/tournament_main_cubit.dart';
import '../cubit/edit_game_rol_cubit.dart';
import '../widget/filter_bar.dart';
import '../widget/w_grid_list.dart';
import '../widget/w_result_content.dart';

class EditGameRolPage extends StatelessWidget {
  const EditGameRolPage({Key? key}) : super(key: key);

  static Route route(TournamentMainCubit cubit) => MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: const EditGameRolPage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final match =
        context.select((TournamentMainCubit bloc) => bloc.state.selectedMatch);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBarPage(
          title: 'Editar rol de juego ${match.localTeam} VS ${match.teamVisit}',
          size: 100,
        ),
      ),
      body: BlocProvider(
        create: (contextC) =>
            locator<EditGameRolCubit>()..onLoadInitialResults(match.matchId),
        child: BlocConsumer<EditGameRolCubit, EditGameRolState>(
          listenWhen: (previous, current) =>
              previous.screenState != current.screenState,
          listener: (contextC, state) {
            if (state.screenState == BasicCubitScreenState.success) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                      content: Text('Se ha enviado la solicitud correctamente'),
                      duration: Duration(seconds: 5)),
                );
              context.read<TournamentMainCubit>().onLoadGameRolTable();
              Navigator.pop(context);
            }
            if (state.screenState == BasicCubitScreenState.emptyData ||
                state.screenState == BasicCubitScreenState.invalidData ||
                state.screenState == BasicCubitScreenState.error) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage ?? 'Error'),
                    duration: const Duration(seconds: 5),
                  ),
                );
            }
          },
          builder: (contextC, state) {
            if (state.screenState == BasicCubitScreenState.loading) {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.blue[800]!,
                  size: 50,
                ),
              );
            }
            return ListView(
              shrinkWrap: true,
              children: [
                const Center(
                  child: FilterBar(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(bottom: 15, top: 8),
                      child: Text(
                        "Campos disponibles",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 8),
                      child: Text(
                        "Arbitros disponibles",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    )
                  ],
                ),
                if (state.screenState == BasicCubitScreenState.sending)
                  SizedBox(
                    height: 300,
                    child: Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: Colors.blue[800]!,
                        size: 50,
                      ),
                    ),
                  ),
                if (state.screenState != BasicCubitScreenState.sending)
                  Row(
                    children: const [
                      Expanded(
                        child: GridList(
                          isReferee: false,
                        ),
                      ),
                      Expanded(
                        child: GridList(
                          isReferee: true,
                        ),
                      ),
                    ],
                  ),
                const ResultContent(),
              ],
            );
          },
        ),
      ),
    );
  }
}
