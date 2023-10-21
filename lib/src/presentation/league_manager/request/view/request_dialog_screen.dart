import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/lm_request_cubit.dart';

class RequestDialogScreen extends StatelessWidget {
  const RequestDialogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const inputDecoration = InputDecoration(
      prefixIcon: Icon(Icons.search),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
      ),
    );
    return SizedBox(
      height: 400.0,
      width: 700.0,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: BlocBuilder<LmRequestCubit, LmRequestState>(
                      buildWhen: (previous, current) =>
                          previous.selectedTeam != current.selectedTeam,
                      builder: (context, state) {
                        if (state.selectedTeam.isEmpty) {
                          return const Text('Nombre del equipo');
                        }
                        return ListTile(
                          title: const Text('Nombre del equpo'),
                          subtitle: Text(context
                                  .watch<LmRequestCubit>()
                                  .state
                                  .selectedTeam
                                  .teamName! ??
                              "sin nombre"),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: BlocBuilder<LmRequestCubit, LmRequestState>(
                      buildWhen: (previous, current) =>
                          previous.selectedTeam != current.selectedTeam,
                      builder: (context, state) {
                        if (state.selectedTeam.isEmpty) {
                          return const Text('Nombre de la categoria');
                        }
                        return ListTile(
                          title: const Text('Nombre de la categoria'),
                          subtitle: Text(context
                                  .watch<LmRequestCubit>()
                                  .state
                                  .selectedTeam
                                  .categoryId!
                                  .categoryName ??
                              "sin nombre"),
                        );
                      },
                    ),
                  ),
                ),
                /*  Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: BlocBuilder<LmRequestCubit, LmRequestState>(
                      buildWhen: (previous, current) =>
                          previous.selectedTeam.categoryId !=
                          current.selectedTeam.categoryId,
                      builder: (context, state) {
                        if (state.selectedTeam.isEmpty) {
                          return const Text('Categoria');
                        }
                        return DropdownButton<Category>(
                          isExpanded: true,
                          items: state.categoryList
                              .map(
                                (e) => DropdownMenuItem<Category>(
                                  value: e,
                                  child: Text(e.categoryName ?? ''),
                                ),
                              )
                              .toList(),
                          value: state.categoryList.firstWhere((element) =>
                              element == state.selectedTeam.categoryId),
                          onChanged: context
                              .read<LmRequestCubit>()
                              .onChangeTeamCategory,
                        );
                      },
                    ),
                  ),
                ),*/
                const Expanded(
                  child: ListTile(
                    title: Text('Fecha de solicitud'),
                    subtitle: Text(''),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Datos del representante',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Nombre'),
                    subtitle: Text(context
                        .watch<LmRequestCubit>()
                        .state
                        .representative
                        .getFullName),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Correo electrónico'),
                    subtitle: Text(context
                        .watch<LmRequestCubit>()
                        .state
                        .representative
                        .getMainEmail),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Teléfono'),
                    subtitle: Text(context
                        .watch<LmRequestCubit>()
                        .state
                        .representative
                        .getFormattedMainPhone),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                child: SizedBox(
                  height: 200.0,
                  child: TextField(
                    decoration: const InputDecoration(hintText: "Comentarios"),
                    keyboardType: TextInputType.multiline,
                    maxLines: 2,
                    onChanged: context.read<LmRequestCubit>().onCommentChanged,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
