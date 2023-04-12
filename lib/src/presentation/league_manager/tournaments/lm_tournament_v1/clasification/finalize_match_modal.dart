// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';

import 'cubit/clasification_cubit.dart';

class FinalizeMatchModal extends StatelessWidget {
  final String local, visit;
  const FinalizeMatchModal({Key? key, required this.visit, required this.local})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(35),
      child: SimpleDialog(
          contentPadding: const EdgeInsets.all(25),
          title: const Text('Marcador del partido'),
          children: [
            BlocBuilder<ClasificationCubit, ClasificationState>(
              builder: (context, state) {
                return Column(
                  children: [
                    const Center(child: Text('Marcador')),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Local',
                            ),
                            initialValue: local,
                          ),
                        ),
                        const SizedBox(
                          width: 35,
                        ),
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Visitante',
                            ),
                            initialValue: visit,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Center(
                                child: Text(
                                    '${state.finalizeMatchDTO.scoreLocal}',
                                    style: const TextStyle(fontSize: 25)))),
                        const SizedBox(
                          width: 35,
                        ),
                        Expanded(
                            child: Center(
                                child: Text(
                                    '${state.finalizeMatchDTO.scoreVist}',
                                    style: const TextStyle(fontSize: 25)))),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.do_disturb_on_sharp,
                                color: Colors.red,
                              ),
                              tooltip: 'Decrease score',
                              onPressed: () {
                                context
                                    .read<ClasificationCubit>()
                                    .decreaseScore(TypeMatchTem.local);
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.add,
                                color: Colors.green,
                              ),
                              tooltip: 'Increase score',
                              onPressed: () {
                                context
                                    .read<ClasificationCubit>()
                                    .increaseScore(TypeMatchTem.local);
                              },
                            ),
                          ],
                        )),
                        const SizedBox(
                          width: 35,
                        ),
                        Expanded(
                            child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.do_disturb_on_sharp,
                                color: Colors.red,
                              ),
                              tooltip: 'Decrease score',
                              onPressed: () {
                                context
                                    .read<ClasificationCubit>()
                                    .decreaseScore(TypeMatchTem.vist);
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.add,
                                color: Colors.green,
                              ),
                              tooltip: 'Increase score',
                              onPressed: () {
                                context
                                    .read<ClasificationCubit>()
                                    .increaseScore(TypeMatchTem.vist);
                              },
                            ),
                          ],
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.grey[300])),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.close, // <-- Icon
                              size: 24.0,
                            ),
                            label: const Text('Cerrar'), // <-- Text
                          ),
                        ),
                        const SizedBox(
                          width: 35,
                        ),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.green[300])),
                            onPressed: () {
                              context
                                  .read<ClasificationCubit>()
                                  .finalizeMatch();
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.save, // <-- Icon
                              size: 24.0,
                            ),
                            label: const Text('Guardar'), // <-- Text
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          ]),
    );
  }
}
