import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/home/fields/detail_field_page.dart';

import '../../../../domain/field/entity/field.dart';
import '../../../../service_locator/injection.dart';
import '../../tournaments/lm_tournament_v1/clasification/field_schedule/cubit/lm_field_schedule_cubit.dart';
import '../../tournaments/lm_tournament_v1/clasification/widgets/d_field_map.dart';
import '../../tournaments/lm_tournament_v1/clasification/widgets/d_field_prices.dart';

class CardField extends StatelessWidget {
  const CardField(
      {Key? key,
      required this.name,
      required this.photo,
      required this.direction,
      required this.quealify,
      required this.fieldId,
      required this.activeId,
      required this.field})
      : super(key: key);

  final String name;
  final String photo;
  final String direction;
  final int quealify;
  final int fieldId;
  final int activeId;
  final Field field;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (dialogContext) {
              return AlertDialog(
                backgroundColor: Colors.grey[200],
                title: const Text('Información del campo'),
                content: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              isDense: true,
                              labelText: 'Nombre :',
                              enabled: false),
                          style: TextStyle(fontSize: 13),
                          initialValue: name,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(
                          bottom: 10, top: 10, right: 10, left: 10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            isDense: true,
                            labelText: 'Dirección :',
                            enabled: false),
                        style: TextStyle(fontSize: 13),
                        initialValue: direction,
                      ),
                    ))
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: Container(
                      padding:
                          const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                      decoration: const BoxDecoration(
                        color: Color(0xff740426),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Text(
                        'Cerrar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SF Pro',
                          color: Colors.grey[200],
                          fontWeight: FontWeight.w500,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => DetailFieldPage(
                              fieldId: fieldId, activeId: activeId),
                        ),
                      );
                    },
                    icon: const Icon(Icons.calendar_month, size: 25),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return BlocProvider(
                            create: (_) => locator<LmFieldScheduleCubit>()
                              ..onLoadPrices(activeId ?? 0),
                            child: DialogPricesActive(),
                          );
                        },
                      );
                    },
                    tooltip: 'Ver tarifas',
                    icon: const Icon(
                      Icons.monetization_on,
                      size: 32,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return FieldMapDialog(
                            field: field,
                          );
                        },
                      );
                    },
                    tooltip: 'Ver ubicación',
                    icon: const Icon(
                      Icons.pin_drop_sharp,
                      size: 32,
                    ),
                  )
                ],
              );
            },
          );
          /*showDialog(
            context: context,
            builder: (dialogContext) {
              return AlertDialog(
                backgroundColor: Colors.grey[200],
                title: const Text('Informacion del campo'),
                content: DetailFieldLeagueManager(fieldId: fieldId),
                actions: [
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(
                                16.0, 10.0, 16.0, 10.0),
                            decoration: const BoxDecoration(
                              color: Color(0xff740404),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: Text(
                              'Salir',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'SF Pro',
                                color: Colors.grey[200],
                                fontWeight: FontWeight.w500,
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(
                                16.0, 10.0, 16.0, 10.0),
                            decoration: const BoxDecoration(
                              color: Color(0xff045a74),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: Text(
                              'Guardar cambios',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'SF Pro',
                                color: Colors.grey[200],
                                fontWeight: FontWeight.w500,
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              );
            },
          );*/
        },
        child: Card(
          color: Colors.grey[100],
          elevation: 3.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: 15,
                  bottom: 10,
                ),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[100],
                  child: Image.asset(
                    'assets/images/footballfield.png',
                    fit: BoxFit.cover,
                    height: 50,
                    width: 50,
                    color: Colors.black54,
                  ),
                ),
              ),
              Text(name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: true,
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 12,
                      fontWeight: FontWeight.w900)),
              const SizedBox(
                height: 5,
              ),
              Text(direction,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: true,
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 10,
                      fontWeight: FontWeight.w900)),
            ],
          ),
        ));
  }
}
