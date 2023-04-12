import 'package:flutter/material.dart';
import 'package:new_im_animations/im_animations.dart';

class HelpMeButton extends StatelessWidget {
  const HelpMeButton({Key? key, required this.iconData}) : super(key: key);

  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    final Color? color = Colors.red[800];
    return HeartBeat(
      child: CircleAvatar(
        child: Icon(
          iconData,
          color: Colors.white,
        ),
        backgroundColor: color,
      ),
    );
  }
}
//Sonar(
//       waveThickness: 1.0,
//       waveColor: Colors.red,
//       child: const CircleAvatar(
//         backgroundColor: Colors.red,
//         child: Icon(
//           Icons.help,
//           color: Colors.white,
//         ),
//       ),
//     );
