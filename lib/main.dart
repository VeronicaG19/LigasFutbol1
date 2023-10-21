import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

import 'src/presentation/app/view/app.dart';
import 'src/service_locator/injection.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  setPathUrlStrategy();
  runApp(const App());
}
