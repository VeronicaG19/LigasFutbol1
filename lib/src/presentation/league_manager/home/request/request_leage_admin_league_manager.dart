import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/home/request/cubit/request_lm_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../service_locator/injection.dart';
import '../../../app/bloc/authentication_bloc.dart';

class RequestLeagueToAdmin extends StatelessWidget {
  const RequestLeagueToAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final partyId = context
        .select((AuthenticationBloc bloc) => bloc.state.user.person.personId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text(
          'Solicitar liga',
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
        create: (_) => locator<RequestLmCubit>()
          ..getCountRequestFiltered(partyId!, RequestType.LEAGUE_TO_ADMIN),
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
                  const SnackBar(
                    content: Text("Error al enviar la solicitud"),
                  ),
                );
            }
          },
          builder: (context, state) {
            if (state.screenStatus ==
                BasicCubitScreenState.submissionInProgress) {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: const Color(0xff358aac),
                  size: 50,
                ),
              );
            }
            return (state.requestCount > 0)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/informacion.png',
                        width: MediaQuery.of(context).size.width * .25,
                        height: MediaQuery.of(context).size.height * .25,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        'Ya tiene una solicitud pendiente por aprobar o aprobada',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25),
                      )
                    ],
                  )
                : ListView(
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
                                    TextFormField(
                                      //key: const Key('name_tournament'),
                                      maxLength: 50,
                                      onChanged: (value) => context
                                          .read<RequestLmCubit>()
                                          .onLeagueNameChange(value),
                                      //onFieldSubmitted: (value) => state.formzStatus.isSubmissionInProgress,
                                      decoration: InputDecoration(
                                        labelText: "Nombre de la liga :",
                                        labelStyle:
                                            const TextStyle(fontSize: 15),
                                        errorText: state.leagueName.invalid
                                            ? "Escriba el nombre de la liga"
                                            : null,
                                      ),
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                    const SizedBox(height: 15),
                                    TextFormField(
                                      maxLength: 50,
                                      onChanged: (value) => context
                                          .read<RequestLmCubit>()
                                          .onLeagueDescriptionChange(value),
                                      decoration: InputDecoration(
                                        labelText: "Descripción de la liga :",
                                        labelStyle:
                                            const TextStyle(fontSize: 15),
                                        errorText: state
                                                .leagueDescription.invalid
                                            ? "Escriba la descripción de la liga"
                                            : null,
                                      ),
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                    const SizedBox(height: 15),
                                    ElevatedButton.icon(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.green[300])),
                                      onPressed: () {
                                        context
                                            .read<RequestLmCubit>()
                                            .sendRequest(partyId: partyId);
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
                        ],
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
