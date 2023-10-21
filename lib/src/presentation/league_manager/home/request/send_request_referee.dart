import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ligas_futbol_flutter/src/domain/leagues/leagues.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/enums.dart';
import '../../../../service_locator/injection.dart';
import '../../../app/app.dart';
import 'cubit/request_lm_cubit.dart';

class SendRequestReferee extends StatelessWidget {
  const SendRequestReferee({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final partyId = context
        .select((AuthenticationBloc bloc) => bloc.state.user.person.personId);

    final usr = context.select((AuthenticationBloc bloc) => bloc.state.user);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          title: Text(
            'Unirme a liga',
            style:
                TextStyle(color: Colors.grey[200], fontWeight: FontWeight.w900),
          ),
          flexibleSpace: const Image(
            image: AssetImage('assets/images/imageAppBar25.png'),
            fit: BoxFit.cover,
          ),
          elevation: 0.0,
        ),
        body: BlocProvider(
            create: (_) => locator<RequestLmCubit>()..onGetLeagues(),
            child: BlocConsumer<RequestLmCubit, RequestLmState>(
                listener: (context, state) {
              if (state.formzStatus.isSubmissionSuccess) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text("Se envio una solicitud correctamente"),
                    ),
                  );
              } else if (state.formzStatus.isSubmissionFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage??"Error al enviar la solicitud"),
                    ),
                  );
              }
            }, builder: (context, state) {
              if (state.screenStatus == BasicCubitScreenState.loaded) {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          CircleAvatar(
                            radius: 70,
                            backgroundColor: const Color(0xff045a74),
                            child: Image(
                              image:
                                  const AssetImage('assets/images/request.png'),
                              height: 90,
                              width: 90,
                              color: Colors.grey[300],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    const SizedBox(height: 15),
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
                                        items: state.leagues
                                            .map((item) =>
                                                DropdownMenuItem<League>(
                                                  value: item,
                                                  child: Text(
                                                    item.leagueName,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey[200],
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          context
                                              .read<RequestLmCubit>()
                                              .onChangeLeague(value!);
                                        },
                                        value: (state.leageSlct.leagueName
                                                .isNotEmpty)
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
                                        buttonPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        buttonDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          border: Border.all(
                                            color: Colors.blueGrey,
                                          ),
                                          color: Colors.blueGrey,
                                        ),
                                        buttonElevation: 2,
                                        itemHeight: 40,
                                        itemPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        dropdownPadding: null,
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          border: Border.all(
                                            color: const Color(0xff358aac),
                                          ),
                                          color: Colors.black54,
                                        ),
                                        dropdownElevation: 8,
                                        scrollbarRadius:
                                            const Radius.circular(40),
                                        scrollbarThickness: 6,
                                        selectedItemHighlightColor:
                                            const Color(0xff358aac),
                                        scrollbarAlwaysShow: true,
                                        offset: const Offset(-20, 0),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    ElevatedButton.icon(
                                      style: ButtonStyle(
                                          backgroundColor: (state.leageSlct
                                                  .leagueName.isNotEmpty)
                                              ? MaterialStateProperty.all(
                                                  Colors.green[300])
                                              : MaterialStateProperty.all(
                                                  Colors.grey)),
                                      onPressed: () {
                                        (state.leageSlct.leagueName.isNotEmpty)
                                            ? context
                                                .read<RequestLmCubit>()
                                                .sendRequestReferee(
                                                    partyId: partyId, urs: usr)
                                            : null;
                                      },
                                      icon: const Icon(
                                        Icons.send, // <-- Icon
                                        size: 24.0,
                                      ),
                                      label: const Text(
                                          'Enviar solicitud'), // <-- Text
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ]),
                  ],
                );
              } else if (state.screenStatus == BasicCubitScreenState.loading) {
                return Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                    color: const Color(0xff358aac),
                    size: 50,
                  ),
                );
              } else {
                return const Center(
                  child: Text('Error al cargar la información'),
                );
              }
            })));
  }
}
