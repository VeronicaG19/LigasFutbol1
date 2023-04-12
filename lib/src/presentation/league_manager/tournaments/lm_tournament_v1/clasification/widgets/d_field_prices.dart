import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../../core/enums.dart';
import '../field_schedule/cubit/lm_field_schedule_cubit.dart';

class DialogPricesActive extends StatefulWidget {
  @override
  _DialogPricesActiveState createState() => _DialogPricesActiveState();
}

class _DialogPricesActiveState extends State<DialogPricesActive> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //contentPadding: const EdgeInsets.all(15),
      title: const Text('Tarifas'),
      content: BlocBuilder<LmFieldScheduleCubit, LmFieldScheduleState>(
        builder: (context, state) {
          if (state.screenState == BasicCubitScreenState.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.blue[800]!,
                size: 50,
              ),
            );
          } else {
            return state.pricesbyActive.isEmpty
                ? const Center(
                    child: Text('No hay Tarifas disponibles'),
                  )
                : Row(children: [
                    Expanded(
                        child: SizedBox(
                            height: 500,
                            width: 400,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.pricesbyActive.length,
                              itemBuilder: (context, index) {
                                final item = state.pricesbyActive[index];
                                return Column(
                                  children: [
                                    ListTile(
                                      title: Text(item
                                          .getStringOfTime(item.periotTime!)),
                                      subtitle: Text(
                                          '${item.price} ${item.getTypeCurrency(item.currency!)}'),
                                    ),
                                    const Divider()
                                  ],
                                );
                              },
                            )))
                  ]);
          }
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('ACEPTAR'),
        ),
      ],
    );
  }
}
