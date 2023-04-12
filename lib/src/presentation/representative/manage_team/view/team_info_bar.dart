import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ligas_futbol_flutter/src/domain/team/entity/team.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/manage_team/cubit/manage_team_cubit.dart';
import 'package:ligas_futbol_flutter/src/service_locator/injection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TeamInfoBar extends StatelessWidget {
  const TeamInfoBar({super.key, required this.teamId});

  final int teamId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<ManageTeamCubit>()..getTeamInfo(teamId: teamId),
      child: BlocBuilder<ManageTeamCubit, ManageTeamState>(
        builder: (context, state) {
          if (state.screenStatus == ScreenStatus.loading) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: const Color(0xff358aac),
                size: 50,
              ),
            );
          } else {
            const defaultImage = kIsWeb
                ? NetworkImage('assets/images/soccer_logo_SaaS.png')
                    as ImageProvider
                : AssetImage('assets/images/soccer_logo_SaaS.png');
            return Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Color(0xff0043ba), Color(0xff006df1)]),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: kIsWeb
                              ? NetworkImage('assets/images/imageAppBar6.png')
                                  as ImageProvider
                              : AssetImage('assets/images/imageAppBar6.png'))),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () async {
                      final photo = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (photo != null) {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return BlocProvider.value(
                              value: BlocProvider.of<ManageTeamCubit>(context),
                              child: SelectedImage(
                                team: state.teamInfo,
                                file: photo,
                              ),
                            );
                          },
                        );
                      }
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.black38,
                            radius: 29,
                            backgroundImage: (state.teamInfo.logoId?.document !=
                                    null)
                                ? Image.memory(base64Decode(
                                        state.teamInfo.logoId?.document ?? ''))
                                    .image
                                : defaultImage),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.cyan.shade900,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    state.teamInfo.teamName ?? '',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}

class SelectedImage extends StatefulWidget {
  const SelectedImage({
    Key? key,
    required this.team,
    required this.file,
  }) : super(key: key);

  final Team team;
  final XFile file;

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
          child: kIsWeb ? Image.network(path) : Image.file(File(path)),
        );
      } else if (_pickedFile != null) {
        final path = _pickedFile!.path;
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 0.8 * screenWidth,
            maxHeight: 0.7 * screenHeight,
          ),
          child: kIsWeb ? Image.network(path) : Image.file(File(path)),
        );
      } else {
        return const SizedBox.shrink();
      }
    }

    return SimpleDialog(
      title: const Text('Logo del equipo'),
      children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
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
                      context.read<ManageTeamCubit>().uploadTeamLogo(
                            team: widget.team,
                            xFile: _pickedFile,
                            file: _croppedFile,
                          );
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
