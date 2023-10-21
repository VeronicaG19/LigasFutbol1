import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/models/map_filter_list.dart';
import '../cubit/edit_game_rol_cubit.dart';

class AutocompleteAddress extends StatelessWidget {
  const AutocompleteAddress({Key? key}) : super(key: key);

  static String _displayStringForOption(MapFilterList option) => option.address;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditGameRolCubit, EditGameRolState>(
      buildWhen: (previous, current) =>
          previous.addressList.length != current.addressList.length,
      builder: (context, state) {
        return Autocomplete<MapFilterList>(
          displayStringForOption: _displayStringForOption,
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text == '') {
              return const Iterable<MapFilterList>.empty();
            }
            return state.addressList.where((MapFilterList option) {
              return option
                  .toString()
                  .contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: (MapFilterList selection) {
            context.read<EditGameRolCubit>().onSelectAddressFilter(selection);
            debugPrint(
                'You just selected ${_displayStringForOption(selection)}');
          },
        );
      },
    );
  }
}
