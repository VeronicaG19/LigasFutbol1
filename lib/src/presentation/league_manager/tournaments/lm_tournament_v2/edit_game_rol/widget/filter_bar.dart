import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/tournaments/lm_tournament_v2/edit_game_rol/cubit/edit_game_rol_cubit.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> listaDeOpciones = <String>[
      "Cualquier lugar",
      "Aguascalientes",
      "Baja California",
      "Baja California Sur",
      "Campeche",
      "Coahuila",
      "Colima",
      "Chiapas",
      "Chihuahua",
      "Durango",
      "Distrito Federal",
      "Guanajuato",
      "Guerrero",
      "Hidalgo",
      "Jalisco",
      "México",
      "Michoacán",
      "Morelos",
      "Nayarit",
      "Nuevo León",
      "Oaxaca",
      "Puebla",
      "Querétaro",
      "Quintana Roo",
      "San Luis Potosí",
      "Sinaloa",
      "Sonora",
      "Tabasco",
      "Tamaulipas",
      "Tlaxcala",
      "Veracruz",
      "Yucatán",
      "Zacatecas"
    ];

    return Padding(
      padding: EdgeInsets.only(
        top: 15,
        bottom: 15,
      ),
      child: Container(
          width: 700,
          height: 45,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.grey[100], //blue
            border: Border.all(
              color: Colors.black12,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(45),
          ),
          child: Row(
            children: [
              Container(
                width: 200,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.transparent, //light blue
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    bottomLeft: Radius.circular(45),
                  ),
                ),
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () async {
                    final selected = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2025),
                    );
                    const mounted = true;
                    if (!mounted) return;
                    context.read<EditGameRolCubit>().onChangeDate(selected!);
                  },
                  child: const _DateLabel(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5, top: 5),
                child: Container(
                  width: 1,
                  height: 80,
                  color: Colors.black12,
                ),
              ),
              Container(
                width: 200,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.transparent, //light blue
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    bottomLeft: Radius.circular(45),
                  ),
                ),
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () async {
                    DateTime now = DateTime.now();
                    final TimeOfDay? time = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    if (time != null) {
                      context.read<EditGameRolCubit>().onChangeHour(
                          DateTime(2000, 1, 1, time.hour, time.minute));
                    }
                  },
                  child: const _HourLabel(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5, top: 5),
                child: Container(
                  width: 1,
                  height: 80,
                  color: Colors.black12,
                ),
              ),
              Container(
                width: 200,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.transparent, //light blue
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    bottomLeft: Radius.circular(45),
                  ),
                ),
                alignment: Alignment.center,
                child: DropdownButtonFormField(
                  value: listaDeOpciones.first,
                  elevation: 0,
                  focusColor: Colors.blueGrey,
                  items: listaDeOpciones.map((e) {
                    return DropdownMenuItem(
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          e,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      value: e,
                    );
                  }).toList(),
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500),
                  onChanged: (value) {
                    print("valor $value");
                    context.read<EditGameRolCubit>().onChangeState(value!);
                  },
                  isDense: true,
                  isExpanded: true,
                ), /* TextButton(
                  onPressed: () => _showAlertDialog(),
                  child: const _StateLabel(),
                ),*/
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 5,
                  top: 5,
                ),
                child: Container(
                  width: 90,
                  height: 45,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: const Color(0xff740404), //blue
                    border: Border.all(
                      color: Colors.black12,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: InkWell(
                    onTap: () {
                      context.read<EditGameRolCubit>().onFilterLists();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.grey[200],
                        ),
                        Text(
                          'Buscar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[200],
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class _DateLabel extends StatelessWidget {
  const _DateLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditGameRolCubit, EditGameRolState>(
      builder: (context, state) {
        return Text(
          state.selectedDate != null
              ? 'Fecha: ${DateFormat('dd-MM-yyyy').format(state.selectedDate!)}'
              : 'Cualquier fecha',
          style: const TextStyle(
              fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500),
        );
      },
    );
  }
}

class _HourLabel extends StatelessWidget {
  const _HourLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditGameRolCubit, EditGameRolState>(
      builder: (context, state) {
        return Text(
          state.selectedHour != null
              ? 'Hora: ${DateFormat('HH:mm').format(state.selectedHour!)}'
              : 'Cualquier hora',
          style: const TextStyle(
              fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500),
        );
      },
    );
  }
}

class _StateLabel extends StatelessWidget {
  const _StateLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditGameRolCubit, EditGameRolState>(
      builder: (context, state) {
        return Text(
          state.selectedState != null
              ? 'Estado: ${state.selectedState}'
              : 'Cualquier lugar',
          style: const TextStyle(
              fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500),
        );
      },
    );
  }
}
