import 'package:flutter/material.dart';

class DocsContent extends StatelessWidget {
  const DocsContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TabBarView(children: [
      Center(
        child: Text('Reglamentos'),
      ),
      Center(
        child: Text('Formularios'),
      )
    ]);
  }
}
