import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/foundation.dart';

class ButtonShareWidget extends StatelessWidget {
  const ButtonShareWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white24,
          child: Icon(
            Icons.share,
            size: 18,
            color: Colors.white,
          )),
      onPressed: () async {
        final box = context.findRenderObject() as RenderBox?;
        var linkAndroid =
            'https://play.google.com/store/apps/details?id=com.ccs.swat.iaas.spr.ligas_futbol.ligas_futbol_flutter';
        var linkIos = 'https://apps.apple.com/mx/app/ligas-fútbol/id1589826885';
        await Share.share(
            'Regístrate en Ligas Fútbol.\n'
            'Ligas Fútbol es una aplicación para consultar tu calendario de juego,\n'
            'los resultados de tus partidos, organizar tus ligas y gestionar a tu equipo.\n'
            'Vive la experiencia jugando en los mejores torneos y ligas.\n\n'
            'Descárgala gratis en \n'
            'Android \n $linkAndroid \n\n'
            'iOS \n $linkIos',
            subject: '¡Regístrate 𝐆𝐑𝐀𝐓𝐈𝐒 ahora!',
            sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
      },
    );
  }
}
