import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/domain/category/category.dart';

import '../cubit/request_new_team_cubit.dart';

class DropDownTournamentsPage extends StatefulWidget {
  const DropDownTournamentsPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _DropDownTournamentsPageState();
}

class _DropDownTournamentsPageState extends State<DropDownTournamentsPage> {
  String? selectedValue1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestNewTeamCubit, RequestNewTeamState>(
      builder: (context, state) {
        if (state.screenStatus == ScreenStatus.loadingCategories) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Visibility(
            visible: state.categoryList.isNotEmpty,
            child: DropdownButtonHideUnderline(
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
                        'Categoría',
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
                items: state.categoryList
                    .map((item) => DropdownMenuItem<Category>(
                          value: item,
                          child: Text(
                            item.categoryName!,
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
                      .read<RequestNewTeamCubit>()
                      .onCategoryIdChange(value!);
                },
                value: state.categorySelect,
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
                    color: const Color(0xff4ab9e8),
                  ),
                  color: const Color(0xff358aac),
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
          ),
        );
      },
    );
  }
}
