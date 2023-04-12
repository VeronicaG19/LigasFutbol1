import 'package:authentication_repository/authentication_repository.dart';
import 'package:datasource_client/datasource_client.dart';
import 'package:here_repository/here_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:user_repository/user_repository.dart';

import '../../../environment_config.dart';
import '../../service_locator/injection.dart';

@module
abstract class AppModule {
  @preResolve
  Future<ApiClient> get apiClient async => ApiClient.initialize(
      baseUrl: EnvironmentConfig.baseURL,
      orgId: EnvironmentConfig.orgId,
      refreshTokenURL: EnvironmentConfig.refreshTokenURL);

  AuthenticationRepository get authRepository =>
      AuthenticationRepository(locator<ApiClient>(),
          baseUrl: EnvironmentConfig.baseURL,
          authBaseURL: EnvironmentConfig.oauthBaseURL,
          personBaseURL: EnvironmentConfig.personManagementBaseURL,
          notificationBaseURL: EnvironmentConfig.notificationServiceBaseURL,
          appName: EnvironmentConfig.appName);
  
  ApiHereReposiTory get apiHereRepository => ApiHereReposiTory(
    locator<ApiClient>(),
     baseUrl: EnvironmentConfig.hereBase,
     appName: EnvironmentConfig.appName
  );

  UserRepository get userRepository => UserRepository(locator<ApiClient>(),
      personBase: EnvironmentConfig.personManagementBaseURL,
      appName: EnvironmentConfig.appName);
}
