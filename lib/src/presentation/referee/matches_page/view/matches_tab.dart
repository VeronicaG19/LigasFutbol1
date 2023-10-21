import 'package:flutter/material.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/view/match_events/other_matches_page.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/view/pending_matches_page.dart';

import '../../../../core/constans.dart';

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
      padding: const EdgeInsets.only(
        top: 2,
      ),
      shrinkWrap: true,
      children: [
        Column(
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
              labelStyle:
                  const TextStyle(color: Colors.black54, fontSize: 12.5),
              tabs: [
                Tab(
                  key: CoachKey.myMatchesReferee,
                  text: 'Partidos pendientes',
                ),
                Tab(
                  key: CoachKey.allMyMatchesReferee,
                  text: 'Todos mis partidos',
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.85,
              child: TabBarView(
                controller: _nestedTabController,
                children: const [
                  PendingMatchesPage(),
                  OtherMatchesPage(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
