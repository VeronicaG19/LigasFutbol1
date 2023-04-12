import 'package:flutter/material.dart';

import 'docs_content.dart';

class DocsPage extends StatelessWidget {
  const DocsPage({Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute(builder: (_) => const DocsPage());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Documentos y formularios",
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[200],
          flexibleSpace: const Image(
            image: AssetImage('assets/images/imageAppBar25.png'),
            fit: BoxFit.fill,
          ),
          elevation: 0.0,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Reglamentos',
              ),
              Tab(
                text: 'Formularios',
              ),
            ],
          ),
        ),
        body: const DocsContent(),
      ),
    );
  }
}
