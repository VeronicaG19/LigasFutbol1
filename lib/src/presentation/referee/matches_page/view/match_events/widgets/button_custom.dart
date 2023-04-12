import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({
    super.key,
    required this.textBtn,
    required this.iconBtn,
    required this.fontColor,
    required this.backgroundColor,
    required this.isOutline,
  });

  final String textBtn;
  final IconData iconBtn;
  final Color fontColor;
  final Color backgroundColor;
  final bool isOutline;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 5.0,
            offset: Offset(0.0, 5),
          )
        ],
        borderRadius: BorderRadius.circular(20.0),
        color: isOutline ? fontColor : backgroundColor,
        border: isOutline
            ? Border.all(
                width: 3,
                color: backgroundColor,
              )
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 10.0,
          bottom: 10.0,
        ),
        child: Row(
          children: [
            Icon(
              iconBtn,
              color: isOutline ? backgroundColor : fontColor,
              size: 28.0,
            ),
            Text(
              textBtn,
              style: TextStyle(
                color: isOutline ? backgroundColor : fontColor,
                fontSize: 25.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
