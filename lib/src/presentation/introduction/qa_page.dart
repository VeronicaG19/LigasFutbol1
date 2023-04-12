//import 'package:expansion_tile_card/expansion_tile_card.dart';
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
  /*final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardD = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardE = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardF = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardG = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardH = new GlobalKey();*/
  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );
    return ListView(
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
        /*Padding(
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
            title: const Text("¿Cómo me registro?",
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
                      "¡Nuestro proceso de registro se ha movido en línea!"
                          " El entrenador/gerente del equipo comienza el proceso agregando jugadores a "
                          "una lista en línea, que envía a los jugadores una solicitud para que se agreguen "
                          "a ese equipo. Una vez que el jugador acepta, se accede a los formularios y"
                          " exenciones requeridos, y es necesario completarlos para que el jugador se convierta en"
                          "Activo en la lista del entrenador/gerente.",
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
                    child: Column(
                      children: const <Widget>[
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
                "Mi contraseña no funciona, ¿cómo la restablezco?",
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
                      "Si no puede restablecer su contraseña u olvida su contraseña,"
                          " envíenos un correo electrónico a ligas_futbol@com.mx e incluya su nombre y número de "
                          "identificación de jugador . Le enviaremos un enlace de restablecimiento de "
                          "contraseña para que pueda acceder a su cuenta nuevamente.",
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
                    child: Column(
                      children: const <Widget>[
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
        ),*/
        const Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Divider(),
        )
      ],
    );
  }
}
