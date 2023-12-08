import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';

const String _defaultTitle = 'Sin contenido';
const String _defaultSubTitle = 'No hay datos que mostrar';

class DefaultEmptyWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  DefaultEmptyWidget({required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 500,
        width: 350,
        child: EmptyWidget(
            image: null,
            packageImage: PackageImage.Image_1,
            title: title ?? _defaultTitle,
            subTitle: subtitle ?? _defaultSubTitle,
            titleTextStyle: Theme.of(context)
                .typography
                .dense
                .headline4!
                .copyWith(
                    color: Color(0xff9da9c7),
                    fontSize: 28,
                    fontWeight: FontWeight.w500),
            subtitleTextStyle: Theme.of(context)
                .typography
                .dense
                .bodyText1!
                .copyWith(color: Color(0xffabb8d6), fontSize: 12)),
      ),
    );
  }
}
