import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/home/fields/cubit/field_lm_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/home/widget/card_field.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../widgets/app_bar_page.dart';

class OtherFieldPage extends StatelessWidget {
  const OtherFieldPage({Key? key}) : super(key: key);
  static Route route(FieldLmCubit cubit) => MaterialPageRoute(
      builder: (_) => BlocProvider.value(
            value: cubit,
            child: const OtherFieldPage(),
          ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBarPage(
          title: "Otros campos",
          size: 100,
        ),
      ),
      body:
          BlocConsumer<FieldLmCubit, FieldLmState>(listener: (context, state) {
        if (state.formzStatus.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text("Se envio solicitud al campo correctamente"),
              ),
            );
        } else if (state.formzStatus.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text("No se pudo enviar solicitud al campo"),
              ),
            );
        }
      }, builder: (context, state) {
        if (state.screenStatus == ScreenStatus.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: const Color(0xff358aac),
              size: 50,
            ),
          );
        } else {
          return ListView(
            children: [
              Column(
                children: [
                  GridView.builder(
                    itemCount: state.otherFieldList.length,
                    itemBuilder: (context, index) {
                      return CardField(
                        type: 1,
                        activeId: state.otherFieldList[index].activeId ?? 0,
                        fieldId: state.otherFieldList[index].fieldId ?? 0,
                        name: "${state.otherFieldList[index].fieldName}",
                        photo:
                            "${state.otherFieldList[index].fieldPhotoId?.document ?? ''}",
                        direction:
                            "${state.otherFieldList[index].fieldsAddress}",
                        quealify: 1,
                        field: state.otherFieldList[index],
                      );
                    },
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.only(top: 15, left: 15, right: 15),
                    physics: const NeverScrollableScrollPhysics(),
                    //physics: const ScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            childAspectRatio: 1,
                            crossAxisSpacing: 12.0,
                            mainAxisSpacing: 12.0),
                  ),
                ],
              ),
            ],
          );
        }
      }),
    );
  }
}
