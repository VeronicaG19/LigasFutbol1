import 'package:flutter/material.dart';

class HeaderStep3 extends StatelessWidget {
  const HeaderStep3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          //onPressed: () => Navigator.pop(dialogContext),
          onPressed: () {},
          child: Container(
            padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
            decoration: const BoxDecoration(
              color: Color(0xff0791a3),
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),
            height: 50,
            width: 50,
            child: Text(
              '3',
              style: TextStyle(
                fontFamily: 'SF Pro',
                color: Colors.grey[200],
                fontWeight: FontWeight.w500,
                fontSize: 30.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          "Paso 3",
          style: TextStyle(
            fontFamily: 'SF Pro',
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        const Divider(indent: 1),
        const Text(
          "Datos de los partidos ",
          style: TextStyle(
            fontFamily: 'SF Pro',
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          height: 8,
        ), /*
        const SizedBox(
          height: 5,
        ),
        const Text(
          "Ayuda",
          style: TextStyle(
            fontFamily: 'SF Pro',
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),*/
      ],
    );
  }
}
