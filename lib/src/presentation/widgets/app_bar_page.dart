import 'package:flutter/material.dart';

class AppBarPage extends StatelessWidget {
  const AppBarPage({Key? key, required this.title, required this.size})
      : super(key: key);
  final String title;
  final double size;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
            color: Colors.grey[200], fontSize: 20, fontWeight: FontWeight.w900),
      ),
      elevation: 0.0,
      flexibleSpace: const Image(
        image: AssetImage('assets/images/imageAppBar25.png'),
        fit: BoxFit.fitWidth,
      ), /*Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Color(0xff06748b), Color(0xff078995), Color(0xff058299)],
      ))),*/
    );
  }
}
