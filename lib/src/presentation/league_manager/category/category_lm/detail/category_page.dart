import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/app/app.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/category/category_lm/detail/category_list_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/category/category_lm/detail/cubit/category_lm_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/category/category_tab.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';

class CategoryLeagueManagerPage extends StatefulWidget {
  const CategoryLeagueManagerPage({Key? key}) : super(key: key);

  @override
  State<CategoryLeagueManagerPage> createState() =>
      _CategoryLeagueManagerPageState();
}

class _CategoryLeagueManagerPageState extends State<CategoryLeagueManagerPage> {
  @override
  Widget build(BuildContext context) {
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
    return BlocProvider(
      create: (_) => locator<CategoryLmCubit>()
        ..getCategoryByTournamentByAndLeagueId(legueId: leagueManager.leagueId),
      child: ListView(
        shrinkWrap: true,
        children: const [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: CategoryListPage()),
              Expanded(flex: 2, child: CategoryTab())
            ],
          ),
        ],
      ),
    );
  }
}
