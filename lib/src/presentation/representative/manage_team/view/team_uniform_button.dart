import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ligas_futbol_flutter/src/domain/uniform/dto/uniform_dto.dart';
import 'package:ligas_futbol_flutter/src/presentation/representative/manage_team/cubit/manage_team_cubit.dart';

class TeamUniformButton extends StatelessWidget {
  const TeamUniformButton({
    super.key,
    required this.uniformDto,
    required this.rutaImage,
  });

  final UniformDto uniformDto;
  final String rutaImage;

  @override
  Widget build(BuildContext context) {
    final defaultImage = kIsWeb
        ? NetworkImage(rutaImage) as ImageProvider
        : AssetImage(rutaImage);
    return GestureDetector(
      onTap: () async {
        final photo =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (photo != null) {
          showDialog(
            context: context,
            builder: (_) {
              return BlocProvider.value(
                value: BlocProvider.of<ManageTeamCubit>(context),
                child: SelectedImage(
                  uniformDto: uniformDto,
                  file: photo,
                  typeOption: (uniformDto.uniformType == "LOCAL") ? 1 : 2,
                ),
              );
            },
          );
        }
      },
      child: Column(
        children: [
          CircleAvatar(
              backgroundColor: Colors.black38,
              radius: 50,
              backgroundImage: (uniformDto.uniformTshirtImage != null)
                  ? Image.memory(base64Decode(uniformDto.uniformTshirtImage!))
                      .image
                  : defaultImage),
          Text(
            (uniformDto.uniformType == "LOCAL") ? "Local" : "Visitante",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class SelectedImage extends StatefulWidget {
  const SelectedImage({
    Key? key,
    required this.file,
    required this.typeOption,
    required this.uniformDto,
  }) : super(key: key);

  final XFile file;
  final int typeOption;
  final UniformDto uniformDto;

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
      title: Text(
        'Uniforme ${(widget.uniformDto.uniformType == "LOCAL") ? "Local" : "Visitante"}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
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
                    padding: const EdgeInsets.all(15.0),
                    child: image(),
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              BlocBuilder<ManageTeamCubit, ManageTeamState>(
                builder: (context, state) {
                  context.read<ManageTeamCubit>().convertImgToBs(
                        xFile: _pickedFile,
                        file: _croppedFile,
                      );
                  return (state.imageIsLarge!)
                      ? const _ImageSizeAlert()
                      : const SizedBox(height: 0);
                },
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      if (widget.typeOption == 1) {
                        context.read<ManageTeamCubit>().uploadImgLocal(
                              uniformDto: widget.uniformDto,
                              xFile: _pickedFile,
                              file: _croppedFile,
                            );
                      }
                      if (widget.typeOption == 2) {
                        context.read<ManageTeamCubit>().uploadImgVisitant(
                              uniformDto: widget.uniformDto,
                              xFile: _pickedFile,
                              file: _croppedFile,
                            );
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

class _ImageSizeAlert extends StatelessWidget {
  const _ImageSizeAlert();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 24.0, right: 24.0),
      child: Card(
        elevation: 2.5,
        color: Colors.orange,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 15,
            right: 15,
          ),
          child: Text(
            'El tamaño de la imagen es mas grande que el recomendado(1MB), esto puede tardar, por favor espere un poco.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            ),
          ),
        ),
      ),
    );
  }
}
