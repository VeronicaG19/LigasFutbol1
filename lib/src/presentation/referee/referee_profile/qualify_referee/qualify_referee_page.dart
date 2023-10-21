import 'package:flutter/material.dart';
import 'package:ligas_futbol_flutter/src/presentation/referee/matches_page/view/match_events/other_matches_page.dart';

class QualifyRefereePage extends StatelessWidget {
  const QualifyRefereePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.grey[200],
          title: const Text(
            'Mis partidos',
          ),
          flexibleSpace: const Image(
            image: AssetImage('assets/images/imageAppBar25.png'),
            fit: BoxFit.cover,
          ),
          elevation: 0.0,
        ),
      ),
      body: const OtherMatchesPage(),
    );
  }
}
