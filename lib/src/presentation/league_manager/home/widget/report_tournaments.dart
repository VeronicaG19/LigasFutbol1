import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportTournament extends StatelessWidget {
  const ReportTournament(
      {Key? key,
      required this.torneo,
      required this.categoria,
      //required this.modalidad,
      required this.nEquipos,
      required this.fecha,
      required this.estado,
      required this.visibilidad})
      : super(key: key);

  final String torneo;
  final String categoria;
  //final String modalidad;
  final int nEquipos;
  final String fecha;
  final String estado;
  final String visibilidad;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 20, left: 20, bottom: 6, top: 6),
          color: Colors.grey[200],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  torneo,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Text(
                  categoria,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Text(
                  nEquipos.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Text(
                  fecha == '-' ? '-' : DateFormat('MM/dd/yyyy').format(DateTime.parse(fecha)),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Text(
                  estado == 'Y' ? 'Abierto' : 'Cerrado',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Text(
                  visibilidad == 'Y' ? 'Privado' : 'Publico',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
        Divider(indent: 1),
      ],
    );
  }
}
