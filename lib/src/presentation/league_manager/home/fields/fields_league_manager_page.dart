import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/home/fields/other_field_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../service_locator/injection.dart';
import '../../../app/bloc/authentication_bloc.dart';
import '../widget/card_field.dart';
import 'cubit/field_lm_cubit.dart';

class FieldsLeagueManagerPage extends StatelessWidget {
  const FieldsLeagueManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leagueManager =
        context.select((AuthenticationBloc bloc) => bloc.state.selectedLeague);
    return BlocProvider(
      create: (_) => locator<FieldLmCubit>()
        ..loadfields(leagueId: leagueManager.leagueId, status: 0),
      child:
          BlocConsumer<FieldLmCubit, FieldLmState>(listener: (context, state) {
        if (state.formzStatus.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text("Se agregó el campo correctamente"),
              ),
            );
        } else if (state.formzStatus.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text("No se pudo crear el campo"),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        //onPressed: () => Navigator.pop(dialogContext),
                        onPressed: () async {
                          /*Navigator.push(
                            context,
                            EditPlayerProfilePage.route(BlocProvider.of<PlayerProfileCubit>(context))
                        );*/
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (_) => BlocProvider.value(
                                  value: BlocProvider.of<FieldLmCubit>(context)
                                    ..loadOthersFields(
                                        leagueId: leagueManager.leagueId,
                                        status: 1),
                                  child: const OtherFieldPage()),
                            ),
                          );
                          /* Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CraeteFieldLeagueManagerPage(),
                            ),
                          ).whenComplete(() => context
                                .read<FieldLmCubit>()
                                .loadfields(leagueId: leagueManager.leagueId));*/
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                          decoration: const BoxDecoration(
                            color: Color(0xff0791a3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          height: 35,
                          width: 150,
                          child: Text(
                            'Buscar campos',
                            style: TextStyle(
                              fontFamily: 'SF Pro',
                              color: Colors.grey[200],
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  GridView.builder(
                    itemCount: state.fieldtList.length,
                    itemBuilder: (context, index) {
                      return CardField(
                        type: 0,
                        activeId: state.fieldtList[index].activeId ?? 0,
                        fieldId: state.fieldtList[index].fieldId ?? 0,
                        name: "${state.fieldtList[index].fieldName}",
                        photo:
                            "${state.fieldtList[index].fieldPhotoId?.document ?? ''}",
                        direction: "${state.fieldtList[index].fieldsAddress}",
                        quealify: 1,
                        field: state.fieldtList[index],
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
