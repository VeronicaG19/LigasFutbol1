import 'package:flutter/material.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/view/matches_page.dart';

class MatchesTab extends StatefulWidget {
  const MatchesTab({Key? key}) : super(key: key);

  @override
  State<MatchesTab> createState() => _MatchesTabState();
}

class _MatchesTabState extends State<MatchesTab> with TickerProviderStateMixin {
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
      padding: EdgeInsets.only(
        top: 2,
      ),
      shrinkWrap: true,
      children: [
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
              labelStyle: TextStyle(color: Colors.black54, fontSize: 12.5),
              tabs: const [
                Tab(
                  text: 'Mis partidos',
                ),
                Tab(
                  text: 'Todos mis partidos',
                ),
              ],
            ),
            Container(
              height: screenHeight * 0.85,
              child: TabBarView(
                controller: _nestedTabController,
                children: [
                  const MatchesPage(),
                  const MatchesPage(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
