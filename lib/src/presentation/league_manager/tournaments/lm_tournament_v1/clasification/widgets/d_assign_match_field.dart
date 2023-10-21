import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/domain/field/entity/field.dart';
import 'package:ligas_futbol_flutter/src/domain/referee/dto/referee_by_address.dart';

import '../../../../../../service_locator/injection.dart';
import '../field_schedule/cubit/lm_field_schedule_cubit.dart';
import '../field_schedule/view/d_field_schedule.dart';
import 'd_field_map.dart';
import 'd_field_prices.dart';

class AssignMatchFieldDialog extends StatelessWidget {
  const AssignMatchFieldDialog(
      {Key? key,
      required this.type,
      required this.selectedField,
      required this.selectedReferee,
      this.elements})
      : super(key: key);

  final LMRequestType type;
  final Field selectedField;
  final RefereeByAddress selectedReferee;
  final List<Widget>? elements;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<LmFieldScheduleCubit>(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Wrap(
          spacing: 3,
          crossAxisAlignment: WrapCrossAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                if (type == LMRequestType.referee && selectedReferee.isEmpty) {
                  return;
                }
                if (type == LMRequestType.fieldOwner && selectedField.isEmpty) {
                  return;
                }
                showDialog(
                  context: context,
                  builder: (context) {
                    return type == LMRequestType.fieldOwner
                        ? BlocProvider(
                            create: (_) => locator<LmFieldScheduleCubit>()
                              ..onLoadActiveAvailability(
                                  selectedField.activeId ?? 0,
                                  LMRequestType.fieldOwner),
                            child: const FieldScheduleDialog(
                                type: LMRequestType.fieldOwner),
                          )
                        : BlocProvider(
                            create: (_) => locator<LmFieldScheduleCubit>()
                              ..onLoadActiveAvailability(
                                  selectedReferee.refereeId,
                                  LMRequestType.referee),
                            child: const FieldScheduleDialog(
                                type: LMRequestType.referee),
                          );
                  },
                );
              },
              tooltip: 'Ver disponibilidad',
              icon: const Icon(
                Icons.calendar_month,
                size: 23,
              ),
            ),
            IconButton(
              onPressed: () {
                if (type == LMRequestType.referee && selectedReferee.isEmpty) {
                  return;
                }
                if (type == LMRequestType.fieldOwner && selectedField.isEmpty) {
                  return;
                }
                showDialog(
                  context: context,
                  builder: (context) {
                    return type == LMRequestType.fieldOwner
                        ? BlocProvider(
                            create: (_) => locator<LmFieldScheduleCubit>()
                              ..onLoadPrices(selectedField.activeId ?? 0),
                            child: DialogPricesActive(),
                          )
                        : BlocProvider(
                            create: (_) => locator<LmFieldScheduleCubit>()
                              ..onLoadPrices(selectedReferee.activeId),
                            child: DialogPricesActive(),
                          );
                  },
                );
              },
              tooltip: 'Ver tarifas',
              icon: const Icon(
                Icons.monetization_on,
                size: 23,
              ),
            ),
            type == LMRequestType.fieldOwner
                ? IconButton(
                    onPressed: () {
                      if (selectedField.isEmpty) {
                        return;
                      }
                      showDialog(
                        context: context,
                        builder: (context) {
                          return FieldMapDialog(
                            field: selectedField,
                          );
                        },
                      );
                    },
                    tooltip: 'Ver ubicación',
                    icon: const Icon(
                      Icons.pin_drop_sharp,
                      size: 23,
                    ),
                  )
                : const SizedBox(),
            ...?elements,
          ],
        ),
      ),
    );
  }
}
