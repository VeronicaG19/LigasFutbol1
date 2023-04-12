import 'environment_config.dart';
import 'main.dart';

void main() {
  EnvironmentConfig.setEnvironment(Environment.local);
  initializeApp();
}
