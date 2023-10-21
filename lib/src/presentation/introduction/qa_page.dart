//import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

import '../splash/responsive_widget.dart';
import '../splash/top_bar.dart';

class QAPage extends StatefulWidget {
  const QAPage({Key? key}) : super(key: key);

  @override
  _QAPageState createState() => _QAPageState();
}

class _QAPageState extends State<QAPage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    if (ResponsiveWidget.isSmallScreen(context)) {
      return _QAPageMobile();
    } else {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 1000),
          child: TopBarContents(),
        ),
        body: _QAPageMobile(),
      );
    }
  }
}

class _QAPageMobile extends StatelessWidget {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardD = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardE = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardF = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardG = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardH = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );
    return ListView(
      padding: EdgeInsets.only(bottom: 100),
      shrinkWrap: true,
      children: <Widget>[
        const SizedBox(height: 30, width: 30),
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Preguntas frecuentes",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w900),
          ),
        ),
        const SizedBox(height: 10, width: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ExpansionTileCard(
            baseColor: Colors.grey[200],
            elevation: 0.0,
            key: cardA,
            leading: CircleAvatar(
                backgroundColor: Color(0xff358aac),
                radius: 15,
                child: Text('1',
                    style: TextStyle(
                      color: Colors.grey[200],
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ))),
            title: const Text(
                "¿Qué actividades puedo hacer con el rol de jugador?",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
            children: <Widget>[
              Divider(
                thickness: 1.0,
                height: 1.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                      "* Agregar foto de perfil \n"
                      "* Complementar información personal\n"
                      "* Buscar equipos\n"
                      "* Aceptar / rechazar invitaciones para unirte a un equipo.\n"
                      "* Agregar información de ficha de jugador\n"
                      "* Agregar experiencia\n"
                      "* Ver rol de juegos ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 13)),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                buttonHeight: 52.0,
                buttonMinWidth: 90.0,
                children: <Widget>[
                  TextButton(
                    style: flatButtonStyle,
                    onPressed: () {
                      cardA.currentState?.collapse();
                    },
                    child: const Column(
                      children: <Widget>[
                        Icon(Icons.arrow_upward),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Text("Cerrar"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ExpansionTileCard(
            baseColor: Colors.grey[200],
            elevation: 0.0,
            key: cardB,
            leading: CircleAvatar(
                backgroundColor: const Color(0xff358aac),
                radius: 15,
                child: Text('2',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[200],
                      fontWeight: FontWeight.w900,
                    ))),
            title: const Text(
                "¿Qué actividades puedo hacer con el rol de dueño de campo?",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
            children: <Widget>[
              const Divider(
                height: 1.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                      "* Crear disponibilidad de campo \n"
                      "* Agregar tarifa de los campos\n"
                      "* Enviar invitación para unirse a una liga\n"
                      "* Aceptar / rechazar solicitud de campo\n"
                      "* Complementar información personal\n"
                      "* Ver agenda de disponibilidad",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 13)),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                buttonHeight: 52.0,
                buttonMinWidth: 90.0,
                children: <Widget>[
                  TextButton(
                    style: flatButtonStyle,
                    onPressed: () {
                      cardB.currentState?.collapse();
                    },
                    child: const Column(
                      children: <Widget>[
                        Icon(Icons.arrow_upward),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Text("Cerrar"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ExpansionTileCard(
            baseColor: Colors.grey[200],
            elevation: 0.0,
            key: cardC,
            leading: CircleAvatar(
                backgroundColor: const Color(0xff358aac),
                radius: 15,
                child: Text('2',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[200],
                      fontWeight: FontWeight.w900,
                    ))),
            title: const Text(
                "¿Qué actividades puedo hacer con el rol de árbitro?",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
            children: <Widget>[
              const Divider(
                height: 1.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                      "* Crear disponibilidad de juegos \n"
                      "* Agregar tarifa de partido\n"
                      "* Enviar invitación para unirse a la liga\n"
                      "* Aceptar/rechazar solicitud de partidos\n"
                      "* Agregar datos personales\n"
                      "* Ingresar marcador de partidos asignados",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 13)),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                buttonHeight: 52.0,
                buttonMinWidth: 90.0,
                children: <Widget>[
                  TextButton(
                    style: flatButtonStyle,
                    onPressed: () {
                      cardC.currentState?.collapse();
                    },
                    child: const Column(
                      children: <Widget>[
                        Icon(Icons.arrow_upward),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Text("Cerrar"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ExpansionTileCard(
            baseColor: Colors.grey[200],
            elevation: 0.0,
            key: cardD,
            leading: CircleAvatar(
                backgroundColor: const Color(0xff358aac),
                radius: 15,
                child: Text('2',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[200],
                      fontWeight: FontWeight.w900,
                    ))),
            title: const Text(
                "¿Qué actividades puedo hacer con el rol de presidente de liga?",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
            children: <Widget>[
              const Divider(
                height: 1.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                      "* Crear una liga \n"
                      "* Crear categoría\n"
                      "* Enviar invitaciones a los equipos\n"
                      "* Aceptar / rechazar solicitudes de los equipos\n"
                      "* Crear un torneo\n"
                      "* Crear rol de juegos\n"
                      "* Asignar marcador a un equipo\n"
                      "* Ver equipo ganador",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 13)),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                buttonHeight: 52.0,
                buttonMinWidth: 90.0,
                children: <Widget>[
                  TextButton(
                    style: flatButtonStyle,
                    onPressed: () {
                      cardD.currentState?.collapse();
                    },
                    child: const Column(
                      children: <Widget>[
                        Icon(Icons.arrow_upward),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Text("Cerrar"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ExpansionTileCard(
            baseColor: Colors.grey[200],
            elevation: 0.0,
            key: cardE,
            leading: CircleAvatar(
                backgroundColor: const Color(0xff358aac),
                radius: 15,
                child: Text('2',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[200],
                      fontWeight: FontWeight.w900,
                    ))),
            title: const Text(
                "¿Qué actividades puedo hacer con el rol de representante de equipo?",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
            children: <Widget>[
              const Divider(
                height: 1.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                      "* Unirse a una liga \n"
                      "* Crear equipos\n"
                      "* Crear jugadores\n"
                      "* Invitar / buscar a un jugador\n"
                      "* Agregar uniformes local / visitante\n"
                      "* Complementar información personal\n"
                      "* Aceptar / Rechazar solicitudes del jugador\n"
                      "* Ver calendario de juegos",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 13)),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                buttonHeight: 52.0,
                buttonMinWidth: 90.0,
                children: <Widget>[
                  TextButton(
                    style: flatButtonStyle,
                    onPressed: () {
                      cardE.currentState?.collapse();
                    },
                    child: const Column(
                      children: <Widget>[
                        Icon(Icons.arrow_upward),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Text("Cerrar"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ExpansionTileCard(
            baseColor: Colors.grey[200],
            elevation: 0.0,
            key: cardF,
            leading: CircleAvatar(
                backgroundColor: const Color(0xff358aac),
                radius: 15,
                child: Text('2',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[200],
                      fontWeight: FontWeight.w900,
                    ))),
            title: const Text(
                "¿Qué actividades puedo hacer con el rol de representante de equipo?",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
            children: <Widget>[
              const Divider(
                height: 1.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                      "* Crear una liga \n"
                      "* Crear categoría\n"
                      "* Enviar invitaciones a los equipos\n"
                      "* Aceptar / rechazar solicitudes de los equipos\n"
                      "* Crear un torneo\n"
                      "* Crear rol de juegos\n"
                      "* Asignar marcador a un equipo\n"
                      "* Ver equipo ganador",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 13)),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                buttonHeight: 52.0,
                buttonMinWidth: 90.0,
                children: <Widget>[
                  TextButton(
                    style: flatButtonStyle,
                    onPressed: () {
                      cardE.currentState?.collapse();
                    },
                    child: const Column(
                      children: <Widget>[
                        Icon(Icons.arrow_upward),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Text("Cerrar"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
