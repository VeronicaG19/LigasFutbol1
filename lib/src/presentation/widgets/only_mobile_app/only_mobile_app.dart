import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ligas_futbol_flutter/src/presentation/splash/responsive_widget.dart';

class OnlyMobileApp extends StatelessWidget {
  const OnlyMobileApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Información importante"),
      content: const _InformativeAlertBetterExperience(),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          }, //Navigator.pop(),
          child: const Text('ENTENDIDO'),
        ),
      ],
    );
  }
}

class _InformativeAlertBetterExperience extends StatelessWidget {
  const _InformativeAlertBetterExperience({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;

    bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);

    return Row(
      children: [
        // const Expanded(child: SizedBox(width: 0)),
        Expanded(
          // flex: 2,
          child: Container(
            height: isSmallScreen ? (heightScreen / 4) : (heightScreen / 2),
            width: isSmallScreen ? (widthScreen / 1.2) : (widthScreen / 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.cyan.shade600,
                  Colors.cyan.shade700,
                  Colors.cyan.shade800,
                  Colors.cyan.shade900,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  Text(
                    "Para una mejor experiencia",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: isSmallScreen ? 20 : 30,
                    ),
                  ),
                  Text(
                    "asegurate de tener el dispositvo adecuado para lo que necesites hacer.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: isSmallScreen ? 15 : 20,
                    ),
                  ),
                  const SizedBox(height: 30),
                  isSmallScreen ? const _MobileMessage() : const _WebMessage(),
                ],
              ),
            ),
          ),
        ),
        // const Expanded(child: SizedBox(width: 0)),
      ],
    );
  }
}

class _WebMessage extends StatelessWidget {
  const _WebMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(flex: 1, child: SizedBox(width: 0)),
        _PlaystoreQr(),
        Expanded(flex: 1, child: SizedBox(width: 0)),
        _ApplestoreQr(),
        Expanded(flex: 1, child: SizedBox(width: 0)),
      ],
    );
  }
}

class _MobileMessage extends StatelessWidget {
  const _MobileMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double paddingElevationButton = 15;
    const String webLink = "https://ligasfutbol.i-condor.com/";

    return Row(
      children: [
        const Expanded(flex: 1, child: SizedBox(width: 0)),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.cyan.shade600),
              elevation: MaterialStateProperty.all(5),
            ),
            child: const Padding(
              padding: EdgeInsets.only(
                top: paddingElevationButton,
                bottom: paddingElevationButton,
              ),
              child: Text(
                'Ligas Futbol Web',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            onPressed: () {
              Clipboard.setData(const ClipboardData(text: webLink))
                  .then((value) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Enlace copiado al portapapeles'),
                ));
              });
              // copied successfully
            },
          ),
        ),
        const Expanded(flex: 1, child: SizedBox(width: 0)),
      ],
    );
  }
}

class _PlaystoreQr extends StatelessWidget {
  const _PlaystoreQr({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const qrPlaystore = kIsWeb
        ? NetworkImage('assets/images/wiplif_qr_playstore.png') as ImageProvider
        : AssetImage('assets/images/wiplif_qr_playstore.png');

    return const _QrCode(qrImage: qrPlaystore);
  }
}

class _ApplestoreQr extends StatelessWidget {
  const _ApplestoreQr({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const qrApplestore = kIsWeb
        ? NetworkImage('assets/images/wiplif_qr_applestore.png')
            as ImageProvider
        : AssetImage('assets/images/wiplif_qr_applestore.png');

    return const _QrCode(qrImage: qrApplestore);
  }
}

class _QrCode extends StatelessWidget {
  final ImageProvider<Object> qrImage;

  const _QrCode({
    Key? key,
    required this.qrImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height /
        ((ResponsiveWidget.isSmallScreen(context)) ? 5 : 4);

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.rectangle,
        image: DecorationImage(
          fit: BoxFit.contain,
          image: qrImage,
        ),
      ),
    );
  }
}
