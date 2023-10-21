import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ligas_futbol_flutter/src/domain/category/entity/category.dart';
import 'package:ligas_futbol_flutter/src/presentation/league_manager/teams/cubit/team_league_manager_cubit.dart';

class DataTeamContent extends StatefulWidget {
  const DataTeamContent({Key? key}) : super(key: key);

  @override
  _DataTeamContentState createState() => _DataTeamContentState();
}

class _DataTeamContentState extends State<DataTeamContent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamLeagueManagerCubit, TeamLeagueManagerState>(
      builder: (context, state) {
        return ListView(
          shrinkWrap: true,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text("Datos del equipo",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: 15, right: 15, top: 15, left: 15),
                        child: _TeamNameInput(),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(
                          bottom: 15, right: 15, top: 15, left: 15),
                      child: _CategoryInput(),
                    )),
                  ],
                ),
              ],
            )
          ],
        );
      },
    );
  }
}

class _TeamNameInput extends StatelessWidget {
  const _TeamNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamLeagueManagerCubit, TeamLeagueManagerState>(
      buildWhen: (previous, current) => previous.teamName != current.teamName,
      builder: (context, state) {
        return TextFormField(
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
              const SizedBox(height: 12.0),
              BlocBuilder<TeamLeagueManagerCubit, TeamLeagueManagerState>(
                builder: (context, state) {
                  context.read<TeamLeagueManagerCubit>().convertImgToBs(
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
