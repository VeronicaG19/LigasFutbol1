import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ligas_futbol_flutter/src/domain/category/entity/category.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/teams/cubit/team_league_manager_cubit.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:user_repository/user_repository.dart';

import '../../../domain/team/entity/team.dart';

class DetailTeamContent extends StatefulWidget {
  const DetailTeamContent({Key? key, required this.team}) : super(key: key);
  final Team team;
  @override
  _DetailTeamContentState createState() => _DetailTeamContentState();
}

class _DetailTeamContentState extends State<DetailTeamContent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color? color2 = Colors.green[800];
    return BlocConsumer<TeamLeagueManagerCubit, TeamLeagueManagerState>(
      listener: (context, state) {
        if (state.screenStatus == ScreenStatus.updateSucces) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              backgroundColor: color2!,
              textScaleFactor: 1.0,
              message: "Se actualizarón correctamente los datos del equipo",
            ),
          );
        }
        if (state.screenStatus == ScreenStatus.deleteSucces) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              backgroundColor: color2!,
              textScaleFactor: 1.0,
              message: "Se elimino el equipo correctamente",
            ),
          );
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state.screenStatus == ScreenStatus.loading) {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: const Color(0xff358aac),
              size: 50,
            ),
          );
        }
        return ListView(
          padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
          children: [
            Row(
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Datos del equipo",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25)),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: 15, right: 15, top: 15, left: 15),
                            child: _TeamNameInput(team: widget.team),
                          ),
                        ),
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(
                              bottom: 15, right: 15, top: 15, left: 15),
                          child: _CategoryInput(),
                        ))
                      ],
                    ),
                  ],
                )),
                SizedBox(
                  width: 20,
                ),
                Expanded(child: DataRefereeTeamContent(team: widget.team)),
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
                                value: BlocProvider.of<TeamLeagueManagerCubit>(
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
                                value: BlocProvider.of<TeamLeagueManagerCubit>(
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
                                value: BlocProvider.of<TeamLeagueManagerCubit>(
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
            Padding(
              padding: EdgeInsets.only(top: 40, left: 30, right: 30),
              child: ButtonPressed(
                team: widget.team,
              ),
            )
          ],
        );
      },
    );
  }
}

class _TeamNameInput extends StatelessWidget {
  const _TeamNameInput({Key? key, required this.team}) : super(key: key);
  final Team team;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamLeagueManagerCubit, TeamLeagueManagerState>(
      buildWhen: (previous, current) => previous.teamName != current.teamName,
      builder: (context, state) {
        return TextFormField(
          initialValue: team.teamName,
          key: const Key('team_name_textField'),
          onChanged: (value) =>
              context.read<TeamLeagueManagerCubit>().onChangeTeamName(value),
          decoration: InputDecoration(
            labelText: "Nombre del equipo",
            labelStyle: TextStyle(fontSize: 13),
            errorText: state.teamName.invalid ? "Datos no válidos" : null,
          ),
          style: TextStyle(fontSize: 13),
        );
      },
    );
  }
}

class _CategoryInput extends StatefulWidget {
  const _CategoryInput({Key? key}) : super(key: key);

  @override
  State<_CategoryInput> createState() => _CategoryInputState();
}

class _CategoryInputState extends State<_CategoryInput> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamLeagueManagerCubit, TeamLeagueManagerState>(
      builder: (context, state) {
        return DropdownButtonHideUnderline(
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
                    'Tipo de categoria',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: state.categoryList
                .map((item) => DropdownMenuItem<Category>(
                      value: item,
                      child: Text(
                        item.categoryName ?? '-',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[200],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                context
                    .read<TeamLeagueManagerCubit>()
                    .onCategoryChange(value as Category);
              });
            },
            value: state.categorySelected,
            icon: const Icon(
              Icons.arrow_forward_ios_outlined,
            ),
            iconSize: 14,
            iconEnabledColor: Colors.white70,
            itemHighlightColor: Colors.white70,
            iconDisabledColor: Colors.white70,
            buttonHeight: 35,
            buttonWidth: double.infinity,
            buttonPadding: const EdgeInsets.only(left: 14, right: 14),
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.blueGrey,
              ),
              color: Colors.blueGrey,
            ),
            buttonElevation: 2,
            itemHeight: 40,
            itemPadding: const EdgeInsets.only(left: 14, right: 14),
            dropdownPadding: null,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xff358aac),
              ),
              color: Colors.black54,
            ),
            dropdownElevation: 8,
            scrollbarRadius: const Radius.circular(40),
            scrollbarThickness: 6,
            selectedItemHighlightColor: const Color(0xff358aac),
            scrollbarAlwaysShow: true,
            offset: const Offset(-20, 0),
          ),
        );
      },
    );
  }
}

class SelectedImage extends StatefulWidget {
  const SelectedImage({Key? key, required this.file, required this.typeOption})
      : super(key: key);

  final XFile file;
  final int typeOption;
  @override
  State<SelectedImage> createState() => _SelectedImageState();
}

class _SelectedImageState extends State<SelectedImage> {
  XFile? _pickedFile;
  CroppedFile? _croppedFile;

  @override
  void initState() {
    setState(() {
      _pickedFile = widget.file;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> cropImage() async {
      if (_pickedFile != null) {
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: _pickedFile!.path,
          compressFormat: ImageCompressFormat.jpg,
          compressQuality: 100,
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Cropper',
            ),
            WebUiSettings(
              context: context,
              presentStyle: CropperPresentStyle.dialog,
              boundary: const CroppieBoundary(
                width: 320,
                height: 320,
              ),
              viewPort: const CroppieViewPort(
                  width: 280, height: 280, type: 'circle'),
              enableExif: true,
              enableZoom: true,
              showZoomer: true,
            ),
          ],
        );
        if (croppedFile != null) {
          setState(() {
            _croppedFile = croppedFile;
          });
        }
      }
    }

    Widget image() {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      if (_croppedFile != null) {
        final path = _croppedFile!.path;
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 0.8 * screenWidth,
            maxHeight: 0.7 * screenHeight,
          ),
          child: Image.network(path),
        );
      } else if (_pickedFile != null) {
        final path = _pickedFile!.path;
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 0.8 * screenWidth,
            maxHeight: 0.7 * screenHeight,
          ),
          child: Image.network(path),
        );
      } else {
        return const SizedBox.shrink();
      }
    }

    return SimpleDialog(
      title: const Text("Selecciona una foto"),
      children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: image(),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      if (widget.typeOption == 1) {
                        context
                            .read<TeamLeagueManagerCubit>()
                            .onPhotoTeamChange(
                                xFile: _pickedFile, file: _croppedFile);
                      }
                      if (widget.typeOption == 2) {
                        context
                            .read<TeamLeagueManagerCubit>()
                            .onUniformLocalImageChange(
                                xFile: _pickedFile, file: _croppedFile);
                      }
                      if (widget.typeOption == 3) {
                        context
                            .read<TeamLeagueManagerCubit>()
                            .onUniformVisitImageChange(
                                xFile: _pickedFile, file: _croppedFile);
                      }

                      Navigator.pop(context);
                    },
                    backgroundColor: Colors.greenAccent,
                    tooltip: 'Aceptar',
                    child: const Icon(Icons.check_circle),
                  ),
                  if (_croppedFile == null)
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0),
                      child: FloatingActionButton(
                        onPressed: () {
                          cropImage();
                        },
                        backgroundColor: const Color(0xFFBC764A),
                        tooltip: 'Crop',
                        child: const Icon(Icons.crop),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ButtonPressed extends StatelessWidget {
  const ButtonPressed({Key? key, required this.team}) : super(key: key);
  final Team team;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamLeagueManagerCubit, TeamLeagueManagerState>(
      builder: (context, state) {
        return state.screenStatus == ScreenStatus.loading
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
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: double.infinity,
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                        decoration: const BoxDecoration(
                          color: Color(0xff045a74),
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
                        context
                            .read<TeamLeagueManagerCubit>()
                            .deleteTeam(team.teamId!);
                        //Navigator.of(context).pop();
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
                          'Eliminar equipo',
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
                        context.read<TeamLeagueManagerCubit>().updateTeam(team);
                        // Navigator.of(context).pop();
                      },
                      child: Container(
                        width: double.infinity,
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                        decoration: const BoxDecoration(
                          color: Color(0xff045a74),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Text(
                          'Actualizar datos',
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

class DataRefereeTeamContent extends StatefulWidget {
  const DataRefereeTeamContent({
    Key? key,
    required this.team,
  }) : super(key: key);
  final Team team;

  @override
  _DataRefereeTeamContentState createState() => _DataRefereeTeamContentState();
}

class _DataRefereeTeamContentState extends State<DataRefereeTeamContent> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<TeamLeagueManagerCubit>()
        ..getInfoManagers(personId: widget.team.firstManager!),
      child: BlocBuilder<TeamLeagueManagerCubit, TeamLeagueManagerState>(
        builder: (context, state) {
          if (state.infoManager != Person.empty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text("Datos de representante",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, right: 15, top: 15, left: 15),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              const TextSpan(
                                  text: 'Nombre del representante: ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: state.infoManager.getFullName,
                                  style: const TextStyle(fontSize: 15))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(
                          bottom: 15, right: 15, top: 15, left: 15),
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                                text: 'Correo electrónico: ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: state.infoManager.getMainEmail,
                                style: const TextStyle(fontSize: 15))
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(
                          bottom: 15, right: 15, top: 15, left: 15),
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                                text: 'Teléfono: ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: state.infoManager.getFormattedMainPhone,
                                style: const TextStyle(fontSize: 15))
                          ],
                        ),
                      ),
                    )),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(
                          bottom: 15, right: 15, top: 15, left: 15),
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                                text: 'Dirección: ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: state.infoManager.areaCode,
                                style: const TextStyle(fontSize: 15))
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ],
            );
          } else {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: const Color(0xff358aac),
                size: 50,
              ),
            );
          }
        },
      ),
    );
  }
}
