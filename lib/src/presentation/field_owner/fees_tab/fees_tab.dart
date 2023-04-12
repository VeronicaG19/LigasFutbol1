import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/domain/field/entity/field.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/cubit/fees/fee_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/fees_tab/fees_form.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/fees_tab/fees_list.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FeesTab extends StatelessWidget {
  final Field field;

  const FeesTab({
    super.key,
    required this.field,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<FeeCubit>()..loadFeeList(activeId: field.activeId),
      child: BlocBuilder<FeeCubit, FeeState>(
        builder: (context, state) {
          if (state.screenState == BasicCubitScreenState.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.blue[800]!,
                size: 50,
              ),
            );
          }

          return Stack(
            children: [
              Positioned(
                bottom: 15.0,
                right: 15.0,
                child: FloatingActionButton(
                  backgroundColor: const Color(0xff358aac),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) {
                      return BlocProvider.value(
                        value: BlocProvider.of<FeeCubit>(context)
                          ..loadTimeTypes(),
                        child: FeesForm(
                          field: field,
                        ),
                      );
                    },
                  ),
                  child: const Icon(Icons.add),
                ),
              ),
              state.feeList.isEmpty
                  ? const Center(
                      child: Text('Sin contenido'),
                    )
                  : FeesList(activeId: field.activeId!),
            ],
          );
        },
      ),
    );
  }
}
