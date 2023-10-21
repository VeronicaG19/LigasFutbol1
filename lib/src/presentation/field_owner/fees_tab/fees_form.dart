import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/domain/field/entity/field.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/cubit/fees/fee_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/fees_tab/widgets/periot_time_input.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/fees_tab/widgets/price_input.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class FeesForm extends StatelessWidget {
  final Field field;

  const FeesForm({
    super.key,
    required this.field,
  });

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;

    return BlocConsumer<FeeCubit, FeeState>(
      listenWhen: (previous, current) =>
          previous.screenState != current.screenState,
      listener: (context, state) {
        if (state.screenState == BasicCubitScreenState.error) {
          showTopSnackBar(
            context,
            CustomSnackBar.info(
              backgroundColor: Colors.green[800]!,
              textScaleFactor: 1.0,
              message: state.errorMessage ?? 'Error',
            ),
          );
        } else if (state.screenState == BasicCubitScreenState.success) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              backgroundColor: Colors.green[800]!,
              textScaleFactor: 1.0,
              message: 'Se ha creado la tarifa correctamente',
            ),
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return AlertDialog(
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text('Nueva tarifa'),
              ),
              PriceInput(),
              // DurationTimeInput(),
              SizedBox(height: 20),
              Text("Seleccionar periodo: ",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14, color: Colors.black54)),
              SizedBox(height: 5),
              PeriotTimeInput(),
            ],
          ),
          actions: [
            (state.screenState == BasicCubitScreenState.sending)
                ? Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                      color: Colors.blue[800]!,
                      size: 50,
                    ),
                  )
                : TextButton.icon(
                    icon: const Icon(Icons.save_alt, color: Color(0xff358aac)),
                    onPressed: () async {
                      context
                          .read<FeeCubit>()
                          .onPressSaveFee(activeId: field.activeId);
                    },
                    label: const Text('Guardar',
                        style: TextStyle(color: Color(0xff358aac))),
                  ),
          ],
        );
      },
    );
  }
}
