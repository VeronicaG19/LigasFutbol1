import 'package:flutter/material.dart';

import '../../../../domain/matches/dto/referee_match.dart';

class ReportDetailPage extends StatelessWidget {
  const ReportDetailPage({Key? key, required this.match}) : super(key: key);

  static Route route(RefereeMatchDTO match) => MaterialPageRoute(
      builder: (_) => ReportDetailPage(
            match: match,
          ));

  final RefereeMatchDTO match;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalle del arbitraje',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        flexibleSpace: const Image(
          image: AssetImage('assets/images/imageAppBar25.png'),
          fit: BoxFit.fill,
        ),
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 25.0),
            child: ListTile(
              title: Text('${match.getFieldName ?? 'Sin campo'} ${match.getDate?? 'Fecha no disponible'}',
                  style: TextStyle(fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center),
              //subtitle: Text('Árbitro Anthony Taylor'),
            ),
          ),
          Text(
            'Jornada ${match.jornada}',
            style: TextStyle(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 4,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(35.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/images/categoria.png',
                            height: 60.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(match.getFirstTeam),
                          ),
                          Text(
                            '${match.local}',
                            style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Text(
                    'VS',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(35.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/images/categoria.png',
                            height: 60.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(match.getSecondTeam),
                          ),
                          Text(
                            '${match.visit}',
                            style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              children: const [
                ListTile(
                  title: Text(
                    'Detalles del juego',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                ListTile(
                  title: Text('Alineaciones', style: TextStyle(fontSize: 15)),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color(0xff358aac),
                    size: 18,
                  ),
                ),
                ListTile(
                  title: Text('Cambios', style: TextStyle(fontSize: 15)),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color(0xff358aac),
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              children: const [
                ListTile(
                  title: Text(
                    'Reporte arbitral',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Comentarios del local',
                    style: TextStyle(fontSize: 15),
                  ),
                  subtitle:
                      Text('Firma del local', style: TextStyle(fontSize: 13)),
                ),
                ListTile(
                  title: Text('Comentarios del visitante',
                      style: TextStyle(fontSize: 15)),
                  subtitle: Text('Firma del visitante',
                      style: TextStyle(fontSize: 13)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
