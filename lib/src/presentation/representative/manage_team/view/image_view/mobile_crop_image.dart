import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/bloc/authentication_bloc.dart';

class MobileCropImage extends StatefulWidget {
  const MobileCropImage({Key? key}) : super(key: key);

  @override
  State<MobileCropImage> createState() => _MobileCropImageState();
}

class _MobileCropImageState extends State<MobileCropImage> {
  Future<void> _selectOrTakePhoto(ImageSource imageSource) async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile);
  }

  Future<void> _cropImage(XFile? file) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: file!.path,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: '',
            toolbarColor: Colors.blue,
            hideBottomControls: true,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: '',
        ),
      ],
    );

    if (croppedFile != null) {
      if (mounted) {
        context
            .read<AuthenticationBloc>()
            .add(UpdateUserProfileImage(file: croppedFile));
      }
    }
    if (mounted) {
      Navigator.pop(context, croppedFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text("Selecciona una foto"),
      children: [
        SimpleDialogOption(
          child: const Text("Mi galeria"),
          onPressed: () async {
            _selectOrTakePhoto(ImageSource.gallery);
            //Navigator.pop(context);
          },
        ),
        SimpleDialogOption(
          child: const Text("Tomar una foto"),
          onPressed: () {
            _selectOrTakePhoto(ImageSource.camera);
            //Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
