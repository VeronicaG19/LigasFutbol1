import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/home/fields/cubit/field_lm_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../domain/lookupvalue/entity/lookupvalue.dart';
import '../../../../service_locator/injection.dart';

class DetailFieldLeagueManager extends StatelessWidget {
  const DetailFieldLeagueManager({Key? key, required this.fieldId})
      : super(key: key);

  final int fieldId;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 600,
        height: 400,
        child: BlocProvider(
          create: (_) => locator<FieldLmCubit>()..detailField(fieldId: fieldId),
          child: BlocBuilder<FieldLmCubit, FieldLmState>(
              builder: (context, state) {
            if (state.screenStatus == ScreenStatus.loading) {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: const Color(0xff358aac),
                  size: 50,
                ),
              );
            } else {
              return ListView(shrinkWrap: true, children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 15,
                          bottom: 8,
                        ),
                        child: Icon(
                          //    Icons.sports_basketball_sharp,
                          Icons.streetview,
                          size: 90,
                          color: Color(0xff0791a3),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            isDense: true,
                            labelText: 'Nombre :',
                            enabled: false),
                        style: TextStyle(fontSize: 13),
                        initialValue: state.detailField.fieldName,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            isDense: true,
                            labelText: 'Direccion :',
                            enabled: false),
                        style: TextStyle(fontSize: 13),
                        initialValue: state.detailField.fieldsAddress,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<LookUpValue>(
                          
                          value: state.lookUpValues[state.lookUpValues.indexWhere(
                              (element) =>
                                  element.lookupValue.toString() ==
                                  state.detailField.fieldType)],
                          decoration: const InputDecoration(
                            label: Text('Tipo de campo'),
                            border: OutlineInputBorder(),
                          ),
                          //icon: const Icon(Icons.sports_soccer),
                          isExpanded: true,
                          hint: const Text('Tipo de campo'),
                          items: List.generate(
                            state.lookUpValues.length,
                            (index) {
                              final content =
                                  state.lookUpValues[index].lookupName!;
                              return DropdownMenuItem(
                                enabled: false,
                                child: Text(content.trim().isEmpty
                                    ? 'Tipo de campo'
                                    : content),
                                value: state.lookUpValues[index],
                              );
                            },
                          ),
                          onChanged: (value) {},
                        ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          /*  Expanded(child: TextFormField(
                        decoration: const InputDecoration(
                            isDense: true, labelText: 'Calificacion :', enabled: false),
                        initialValue: "5",
                      ),)*/
                        ],
                      ),
                    ]),
              ]);
            }
          }),
        ));
  }
}
