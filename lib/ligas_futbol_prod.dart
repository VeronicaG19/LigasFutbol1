import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:ligas_futbol_flutter/firebase_options_prod.dart';
import 'package:ligas_futbol_flutter/main.dart';

import 'environment_config.dart';

void main() async {
  EnvironmentConfig.setEnvironment(Environment.prod);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initializeApp();
}
