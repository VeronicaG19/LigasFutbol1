import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/category/category.dart';
import '../../../domain/leagues/entity/league.dart';
import 'cubit/search_team_cubit.dart';

class FiltersModal extends StatelessWidget {
  const FiltersModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Filtrar equipos'),
      children: [
        BlocBuilder<SearchTeamCubit, SearchTeamState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Row(
                        children: const [
                          Icon(
                            Icons.app_registration,
                            size: 16,
                            color: Colors.white70,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              'Selecciona una liga',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: state.leages
                          .map((item) => DropdownMenuItem<League>(
                                value: item,
                                child: Text(
                                  item.leagueName,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[200],
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        context.read<SearchTeamCubit>().onChangeLeague(value!);
                        context
                            .read<SearchTeamCubit>()
                            .getCategoriesByLeague(value);
                      },
                      value: (state.leageSlct.leagueName.isNotEmpty)
                          ? state.leageSlct
                          : null,
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                      iconSize: 14,
                      iconEnabledColor: Colors.white70,
                      itemHighlightColor: Colors.white70,
                      iconDisabledColor: Colors.white70,
                      buttonHeight: 40,
                      buttonWidth: double.infinity,
                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.blueGrey,
                        ),
                        color: Colors.blueGrey,
                      ),
                      buttonElevation: 2,
                      itemHeight: 40,
                      itemPadding: const EdgeInsets.only(left: 14, right: 14),
                      dropdownPadding: null,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xff358aac),
                        ),
                        color: Colors.black54,
                      ),
                      dropdownElevation: 8,
                      scrollbarRadius: const Radius.circular(40),
                      scrollbarThickness: 6,
                      selectedItemHighlightColor: const Color(0xff358aac),
                      scrollbarAlwaysShow: true,
                      offset: const Offset(-20, 0),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Row(
                        children: const [
                          Icon(
                            Icons.app_registration,
                            size: 16,
                            color: Colors.white70,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              'Selecciona una categoría',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: state.categoriesList
                          .map((item) => DropdownMenuItem<Category>(
                                value: item,
                                child: Text(
                                  item.categoryName,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[200],
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        context
                            .read<SearchTeamCubit>()
                            .onChangeCategory(value!);
                      },
                      value: (state.catSelect.categoryName.isNotEmpty)
                          ? state.catSelect
                          : null,
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                      iconSize: 14,
                      iconEnabledColor: Colors.white70,
                      itemHighlightColor: Colors.white70,
                      iconDisabledColor: Colors.white70,
                      buttonHeight: 40,
                      buttonWidth: double.infinity,
                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.blueGrey,
                        ),
                        color: Colors.blueGrey,
                      ),
                      buttonElevation: 2,
                      itemHeight: 40,
                      itemPadding: const EdgeInsets.only(left: 14, right: 14),
                      dropdownPadding: null,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xff358aac),
                        ),
                        color: Colors.black54,
                      ),
                      dropdownElevation: 8,
                      scrollbarRadius: const Radius.circular(40),
                      scrollbarThickness: 6,
                      selectedItemHighlightColor: const Color(0xff358aac),
                      scrollbarAlwaysShow: true,
                      offset: const Offset(-20, 0),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Text(
                        'Equipos buscando jugadores  ',
                        style: TextStyle(fontSize: 17),
                      ),
                      Checkbox(
                        checkColor: Colors.white,
                        //fillColor: MaterialStateProperty.resolveWith(Colors.green),
                        value: (state.requestPlayers == 'Y') ? true : false,
                        onChanged: (value) {
                          context
                              .read<SearchTeamCubit>()
                              .onChangeRequestPlayer(!value!);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                          onPressed: () {
                            context.read<SearchTeamCubit>().onCleanFilters();
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            // <-- Icon
                            Icons.delete,
                            size: 24.0,
                          ),
                          label: const Text('Borrar filtros'), // <-- Text
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  (state.catSelect.categoryId != null ||
                                          state.requestPlayers != null)
                                      ? MaterialStateProperty.all(Colors.green)
                                      : MaterialStateProperty.all(Colors.grey)),
                          onPressed: () {
                            (state.catSelect.categoryId != null ||
                                    state.requestPlayers != null)
                                ? context
                                    .read<SearchTeamCubit>()
                                    .onApplyFilters()
                                : null;
                            (state.catSelect.categoryId != null ||
                                    state.requestPlayers != null)
                                ? Navigator.of(context).pop()
                                : null;
                          },
                          icon: Icon(
                            // <-- Icon
                            Icons.check_box,
                            size: 24.0,
                          ),
                          label: const Text('Aplicar filtros'), // <-- Text
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            // <-- Icon
                            Icons.backspace,
                            size: 24.0,
                          ),
                          label: const Text('Regresar'), // <-- Text
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
