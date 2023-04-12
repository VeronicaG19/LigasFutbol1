import 'environment_config.dart';
import 'main.dart';

void main() {
  EnvironmentConfig.setEnvironment(Environment.test);
  initializeApp();
}
