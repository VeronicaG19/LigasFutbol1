import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/cubit/fees/fee_cubit.dart';

class FeesList extends StatelessWidget {
  final int activeId;
  const FeesList({
    super.key,
    required this.activeId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeeCubit, FeeState>(
      builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: state.feeList.length,
          itemBuilder: (context, index) {
            final item = state.feeList[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                  borderRadius: BorderRadius.circular(8.0)),
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.monetization_on,
                        color: Colors.blueGrey,
                        size: 50,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item.getStringOfTime(item.periotTime!),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${item.price} ${item.getTypeCurrency(item.currency!)}',
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (contextD) {
                              return BlocProvider.value(
                                value: BlocProvider.of<FeeCubit>(context),
                                child: AlertDialog(
                                  title: const Text('Eliminar tarifa'),
                                  content:
                                      const Text('¿Deseas eliminar la tarifa?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(contextD);
                                      }, //Navigator.pop(),
                                      child: const Text('REGRESAR'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context
                                            .read<FeeCubit>()
                                            .onPressDeleteFee(
                                                activeId: activeId,
                                                priceId: item.priceId!);
                                        Navigator.pop(contextD);
                                      },
                                      child: const Text('ELIMINAR'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red[400],
                        ),
                        label: Text(
                          "Eliminar",
                          style: TextStyle(color: Colors.red[400]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
