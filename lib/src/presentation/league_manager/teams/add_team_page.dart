import 'package:flutter/foundation.dart';
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
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.only(left: 10, right: 10),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Expanded(child: DataTeamContent()),
                  Expanded(child: DataRefereeTeamContent()),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 15),
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
                        child: state.showImage1?.path != null
                            ? ClipRRect(
                                child: Image.network(
                                state.showImage1!.path,
                                width: 200,
                                height: 200,
                              ))
                            : Container(
                                width: 100,
                                height: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
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
                        child: state.showImage2?.path != null
                            ? ClipRRect(
                                child: Image.network(
                                state.showImage2!.path,
                                width: 200,
                                height: 200,
                              ))
                            : Container(
                                width: 100,
                                height: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
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
                        child: state.showImage3?.path != null
                            ? ClipRRect(
                                child: Image.network(
                                state.showImage3!.path,
                                width: 200,
                                height: 200,
                              ))
                            : Container(
                                width: 100,
                                height: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
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
                  ],
                ),
              ),
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
                        Navigator.of(context, rootNavigator: true).pop();
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
                      onPressed: state.status.isValidated
                          ? () {
                              context
                                  .read<TeamLeagueManagerCubit>()
                                  .createRefereeTeam();
                              Navigator.of(context).pop();
                            }
                          : null,
                      child: Container(
                        width: double.infinity,
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                        decoration: const BoxDecoration(
                          color: Color(0xff045a74),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
