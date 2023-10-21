import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/constans.dart';
import '../../../app/bloc/authentication_bloc.dart';
import 'mobile_crop_image.dart';
import 'web_crop_image.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({Key? key, this.radius}) : super(key: key);

  final double? radius;

  @override
  Widget build(BuildContext context) {
    return _EditImageContent(
      radius: radius,
    );
  }
}

class _EditImageContent extends StatelessWidget {
  const _EditImageContent({Key? key, this.radius}) : super(key: key);

  final double? radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (kIsWeb) {
          //_onWebSelectionImage();
          final pickedFile =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            showDialog(
              context: context,
              builder: (_) {
                return WebCropImage(
                  file: pickedFile,
                );
              },
            );
          }
        } else {
          showDialog(
            context: context,
            builder: (_) {
              return const MobileCropImage();
            },
          );
        }
      },
      child: Stack(
        children: <Widget>[
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state.isUpdating) {
                return LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.blueAccent,
                  size: 50,
                );
              }

              return CircleAvatar(
                backgroundColor: Colors.black38,
                radius: radius ?? 29,
                backgroundImage: state.user.person.photo == null
                    ? const AssetImage(kDefaultAvatarImagePath)
                    : Image.memory(
                        base64Decode(state.user.person.photo ?? ''),
                      ).image,
              );
            },
          ),
          Positioned(
            bottom: 12,
            right: 8,
            child: Container(
              height: 20,
              width: 20,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: const Icon(
                Icons.add_a_photo,
                color: Colors.white,
                size: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
