import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/domain/category/entity/category.dart';

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
      height: 600.0,
      width: 900.0,
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
                        return TextFormField(
                          decoration: inputDecoration.copyWith(
                              labelText: 'Nombre del equipo'),
                          onChanged:
                              context.read<LmRequestCubit>().onChangeTeamName,
                          initialValue: state.selectedTeam.teamName,
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
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Fecha de solicitud'),
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
                    maxLines: 5,
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
