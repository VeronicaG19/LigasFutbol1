import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/category/category_lm/detail/add_category_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/category/category_lm/detail/cubit/category_lm_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/category/category_lm/detail/detail_category_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/category/category_lm/historic_tournaments_by_category/historic_tournament_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/category/category_lm/historic_tournaments_by_category/historic_tournaments_tab.dart';

import '../../../core/constans.dart';
import '../../player/user_menu/widget/help_menu_button.dart';
import '../../player/user_menu/widget/tutorial_widget.dart';

class CategoryTab extends StatefulWidget {
  const CategoryTab({Key? key}) : super(key: key);

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab>
    with TickerProviderStateMixin {
  TabController? _nestedTabController;
  @override
  void initState() {
    _nestedTabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return ListView(
      padding: EdgeInsets.only(top: 15, right: 8, left: 8),
      shrinkWrap: true,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Expanded(flex: 1, child: SizedBox(width: 0)),
            const HelpMeButton(
                iconData: Icons.help, tuto: TutorialType.ligueAdminCat),
            AddCategoryPage(
              key: CoachKey.addCategoryCategory,
            ),
            const Expanded(flex: 1, child: SizedBox(width: 0)),
          ],
        ),
        BlocBuilder<CategoryLmCubit, CategoryLmState>(
          builder: (context, state) {
            return (state.categoryList.isEmpty)
                ? const _BoxAlert()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabBar(
                        padding: const EdgeInsets.only(
                          right: 10,
                          left: 10,
                        ),
                        controller: _nestedTabController,
                        indicatorColor: const Color(0xff045a74),
                        labelColor: Colors.black,
                        unselectedLabelColor: const Color(0xff045a74),
                        isScrollable: true,
                        labelStyle: const TextStyle(color: Colors.black54),
                        tabs: [
                          Tab(
                            key: CoachKey.onselectedCatAdminLeag,
                            text: 'Categoría',
                          ),
                          // Tab(
                          //   key: CoachKey.categoryThisTournament,
                          //   text: 'Torneo actual',
                          // ),
                          Tab(
                            key: CoachKey.pastTournaments,
                            text: 'Torneos pasados',
                          ),
                        ],
                      ),
                      Container(
                        height: screenHeight * 0.85,
                        margin: const EdgeInsets.only(
                            top: 20, left: 16.0, right: 16.0),
                        child: TabBarView(
                          controller: _nestedTabController,
                          children: const [
                            DetailCategoryPage(type: "update"),
                            //HistoricTournamentsTab(),
                            HistoricTournamentPage()
                          ],
                        ),
                      ),
                    ],
                  );
          },
        ),
      ],
    );
  }
}

class _BoxAlert extends StatelessWidget {
  const _BoxAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          SizedBox(
            width: 15,
          ),
          Icon(Icons.info, color: Colors.blueAccent, size: 200),
          SizedBox(
            width: 15,
          ),
          Text(
            'Crea una categoría',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
