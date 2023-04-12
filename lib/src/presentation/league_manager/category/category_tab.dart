import 'package:flutter/material.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/category/category_lm/detail/add_category_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/category/category_lm/detail/detail_category_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/category/category_lm/historic_tournaments_by_category/historic_tournament_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/category/category_lm/historic_tournaments_by_category/historic_tournaments_tab.dart';

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
    _nestedTabController = TabController(length: 3, vsync: this);
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
            children: [AddCategoryPage()]),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              padding: EdgeInsets.only(
                right: 10,
                left: 10,
              ),
              controller: _nestedTabController,
              indicatorColor: Color(0xff045a74),
              labelColor: Colors.black,
              unselectedLabelColor: Color(0xff045a74),
              isScrollable: true,
              labelStyle: TextStyle(color: Colors.black54),
              tabs: const [
                Tab(
                  text: 'Categoria',
                ),
                Tab(
                  text: 'Torneo actual',
                ),
                Tab(
                  text: 'Torneos pasados',
                ),
              ],
            ),
            Container(
              height: screenHeight * 0.85,
              margin: const EdgeInsets.only(top: 20, left: 16.0, right: 16.0),
              child: TabBarView(
                controller: _nestedTabController,
                children: [
                  DetailCategoryPage(type: "update"),
                  HistoricTournamentsTab(),
                  HistoricTournamentPage()
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
