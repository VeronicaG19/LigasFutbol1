import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/teams/cubit/team_league_manager_cubit.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/teams/data_referee_team_content.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/teams/data_team_content.dart';
import 'package:ligas_futbol_flutter/src/presentation/widgets/app_bar_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddTeamPage extends StatefulWidget {
  const AddTeamPage({Key? key}) : super(key: key);
  static Route route(TeamLeagueManagerCubit value, int leagueId) =>
      MaterialPageRoute(
          builder: (_) => BlocProvider.value(
                value: value
                  ..getCategoryByTournamentByAndLeagueId(legueId: leagueId),
                child: const AddTeamPage(),
              ));

  @override
  State<AddTeamPage> createState() => _AddTeamPageState();
}

class _AddTeamPageState extends State<AddTeamPage> {
  @override
  Widget build(BuildContext context) {
    final Color? color = Colors.blue[800];
    final Color? color2 = Colors.green[800];
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBarPage(
            title: "Crear equipo",
            size: 100,
          )),
      body: BlocConsumer<TeamLeagueManagerCubit, TeamLeagueManagerState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == FormzStatus.submissionSuccess &&
              state.screenStatus == ScreenStatus.createdSucces) {
            showTopSnackBar(
              context,
              CustomSnackBar.success(
                backgroundColor: color2!,
                textScaleFactor: 1.0,
                message: "Se creo correctamente el equipo",
              ),
            );
            Navigator.pop(context);
          } else if (state.status == FormzStatus.submissionFailure) {
            String message = 'Ha ocurrido un error';
            if (state.errorMessage == 'USER_EXIST') {
              message = 'Este usuario ya está registrado en la aplicación';
            } else if (state.errorMessage == 'Team al ready registered') {
              message = 'Un equipo con este nombre ya está registrado';
            }
            showTopSnackBar(
              context,
              CustomSnackBar.success(
                backgroundColor: color2!,
                textScaleFactor: 1.0,
                message: message,
              ),
            );
          }
        },
        // buildWhen: (previous, current) =>
        //     ((previous.status != current.status) ||
        //         (previous.photoTeamSelected != current.photoTeamSelected) ||
        //         (previous.uniformLocalImageSelected !=
        //             current.uniformLocalImageSelected) ||
        //         (previous.uniformVisitImageSelected !=
        //             current.uniformVisitImageSelected)),
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
            children: [
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Expanded(child: DataTeamContent()),
                  // Expanded(child: DataRefereeTeamContent()),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: 0,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Card(
                      elevation: 5,
                      child: DataTeamContent(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: 0,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Card(
                      elevation: 5,
                      child: DataRefereeTeamContent(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: 0,
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 15, bottom: 15)),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () async {
                        final photo = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (photo != null) {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return BlocProvider.value(
                                  value:
                                      BlocProvider.of<TeamLeagueManagerCubit>(
                                          context),
                                  child: SelectedImage(
                                    file: photo,
                                    typeOption: 1,
                                  ),
                                );
                              });
                        }
                      },
                      child: CircleAvatar(
                        radius: 120,
                        //Color(0xff358aac)
                        backgroundColor: Colors.white54,
                        child: state.photoTeamSelected != ''
                            ? ClipRRect(
                                child: Image.memory(
                                base64Decode(state.photoTeamSelected),
                                //Image.network(
                                //state.showImage1!.path,
                                width: 200,
                                height: 200,
                              ))
                            : Container(
                                width: 100,
                                height: 100,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cloud,
                                      color: Color(0xff358aac),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Selecciona el logo",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    )
                                  ],
                                )),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final photo = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (photo != null) {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return BlocProvider.value(
                                  value:
                                      BlocProvider.of<TeamLeagueManagerCubit>(
                                          context),
                                  child: SelectedImage(
                                    file: photo,
                                    typeOption: 2,
                                  ),
                                );
                              });
                        }
                      },
                      child: CircleAvatar(
                        radius: 120,
                        //Color(0xff358aac)
                        backgroundColor: Colors.white54,
                        child: state.uniformLocalImageSelected != ''
                            ? ClipRRect(
                                child: Image.memory(
                                base64Decode(
                                    '${state.uniformLocalImageSelected}'),
                                // Image.network(
                                // state.showImage2!.path,
                                width: 200,
                                height: 200,
                              ))
                            : Container(
                                width: 100,
                                height: 100,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cloud,
                                      color: Color(0xff358aac),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Selecciona el uniforme local",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    )
                                  ],
                                )),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final photo = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (photo != null) {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return BlocProvider.value(
                                  value:
                                      BlocProvider.of<TeamLeagueManagerCubit>(
                                          context),
                                  child: SelectedImage(
                                    file: photo,
                                    typeOption: 3,
                                  ),
                                );
                              });
                        }
                      },
                      child: CircleAvatar(
                        radius: 120,
                        //Color(0xff358aac)
                        backgroundColor: Colors.white54,
                        child: state.uniformVisitImageSelected != ''
                            ? ClipRRect(
                                child: Image.memory(
                                base64Decode(
                                    '${state.uniformVisitImageSelected}'),
                                // Image.network(
                                // state.showImage2!.path,
                                width: 200,
                                height: 200,
                              ))
                            : Container(
                                width: 100,
                                height: 100,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cloud,
                                      color: Color(0xff358aac),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Selecciona el uniforme visitante",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    )
                                  ],
                                )),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 15, bottom: 15)),
              const ButtonPressed(),
            ],
          );
        },
      ),
    );
  }
}

class ButtonPressed extends StatelessWidget {
  const ButtonPressed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamLeagueManagerCubit, TeamLeagueManagerState>(
      builder: (context, state) {
        return state.status == FormzStatus.submissionInProgress
            ? Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: const Color(0xff358aac),
                  size: 50,
                ),
              )
            : Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        //? causa error en la navegación: Navigator.of(context, rootNavigator: true).pop();
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: double.infinity,
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                        decoration: const BoxDecoration(
                          color: Color(0xff740404),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Text(
                          'Salir',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'SF Pro',
                            color: Colors.grey[200],
                            fontWeight: FontWeight.w500,
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if (state.status.isValidated) {
                          context
                              .read<TeamLeagueManagerCubit>()
                              .createRefereeTeam();
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                        decoration: BoxDecoration(
                          color: (state.status.isValidated)
                              ? const Color(0xff045a74)
                              : Colors.grey,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Text(
                          'Guardar cambios',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'SF Pro',
                            color: Colors.grey[200],
                            fontWeight: FontWeight.w500,
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }
}
