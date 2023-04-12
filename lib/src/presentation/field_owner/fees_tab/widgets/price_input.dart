import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/cubit/fees/fee_cubit.dart';

class PriceInput extends StatelessWidget {
  const PriceInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeeCubit, FeeState>(
      buildWhen: (previous, current) =>
          previous.priceValidator != current.priceValidator,
      builder: (context, state) {
        return TextFormField(
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          maxLength: 30,
          onChanged: (value) =>
              context.read<FeeCubit>().onPriceChange(price: value),
          decoration: InputDecoration(
            labelText: "Precio : ",
            labelStyle: const TextStyle(fontSize: 13),
            errorText: state.priceValidator.invalid ? "Marca el precio" : null,
          ),
          style: const TextStyle(fontSize: 13),
        );
      },
    );
  }
}
