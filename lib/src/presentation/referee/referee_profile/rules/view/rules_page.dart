import 'package:flutter/material.dart';

class RegulationPage extends StatelessWidget {
  const RegulationPage({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (_) => const RegulationPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reglamento'),
        flexibleSpace: const Image(
          image: AssetImage('assets/images/imageAppBar25.png'),
          fit: BoxFit.fill,
        ),
      ),
      body: const SizedBox(),
    );
  }
}
