import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:datasource_client/datasource_client.dart';
import 'package:user_repository/user_repository.dart';

import '../constants.dart';
import '../endpoints.dart';
import '../exceptions/auth_failure.dart';
import '../exceptions/authentication_exception.dart';
import '../exceptions/verification_code_exception.dart';
import '../models/verification_code.dart';
import '../repository/authentication_interface.dart';
import '../repository/sign_in_service.dart';
import '../repository/sign_up_service.dart';
import '../typedefs.dart';

class AuthenticationRepository implements AuthenticationInterface {
  final ApiClient _apiClient;
  late final SignInService _signInService = SignInService(_apiClient);
  late final SignupService _signupService = SignupService(_apiClient);
  final _controller = StreamController<String>();

  AuthenticationRepository(
    this._apiClient, {
    required String baseUrl,
    required String authBaseURL,
    required String personBaseURL,
    required String notificationBaseURL,
    required String appName,
  }) : super() {
    Endpoints.init(
        baseUrl, authBaseURL, personBaseURL, notificationBaseURL, appName);
  }

  @override
  void dispose() => _controller.close();

  @override
  String get getPreferredLanguage =>
      _apiClient.localStorage.getGenericObject<String>(kPreferredLanguage) ??
      'es';

  @override
  Stream<String> get sessionStream async* {
    final currentSession = await _getCachedSession();
    /*if (currentSession.isEmpty) {
      yield '';
    } else {
      yield currentSession;
    }*/
    yield currentSession;
    yield* _controller.stream;
  }

  @override
  void logOut() {
    _controller.add('');
    _signInService.logout();
  }

  @override
  RepoResponse<String> loginWithNameAndPassword(
      {required String name, required String password}) async {
    final request = await Task(() => _signInService.login(name, password))
        ._validateResponse();
    //_controller.add(request.getOrElse(() => ''));
    return request;
  }

  @override
  RepoResponse<void> autoLogin() async {
    final userName = await _apiClient.localStorage.getAuthUserName();
    final password = await _apiClient.localStorage.getAuthPassword();
    return loginWithNameAndPassword(name: userName, password: password);
  }

  @override
  RepoResponse<String> recoverPassword(String input) =>
      Task(() => _signupService.recoverPassword(input))._validateResponse();

  @override
  RepoResponse<VerificationCode> resentVerificationCode(
          String receiver, bool isForUpdate) =>
      Task(() => _signupService.resentVerificationCode(receiver, isForUpdate))
          ._validateResponse();

  @override
  Future<void> savePreferredLanguage(String language) async {
    _apiClient.localStorage
        .setGenericObjet<String>(kPreferredLanguage, language);
  }

  @override
  RepoResponse<User> signUp(User user) =>
      Task(() => _signupService.signUpUser(user))._validateResponse();

  @override
  RepoResponse<VerificationCode> submitCodeConfirmation(String input) =>
      Task(() => _signupService.submitCodeConfirmation(input))
          ._validateResponse();

  @override
  RepoResponse<VerificationCode> submitVerificationCode(String receiver) =>
      Task(() => _signupService.submitVerificationCode(receiver))
          ._validateResponse();

  Future<String> _getCachedSession() async {
    final token = await _apiClient.localStorage.getAuthToken();
    return token.trim().isEmpty ? '' : token;
  }

  @override
  RepoResponse<VerificationCode> sendVerificationCodeForDataUpdate(
          String receiver, bool isChangingUser) =>
      Task(() => _signupService.sendVerificationCodeForDataUpdate(
          receiver, isChangingUser))._validateResponse();

  @override
  RepoResponse<VerificationCode> submitVerificationCodeForDataUpdate(
          String code, String type) =>
      Task(() => _signupService.submitCodeForUpdate(code, type))
          ._validateResponse();

  @override
  VerificationCode getCacheCodeForUpdate(String type) =>
      _signupService.getCacheCodeForUpdate(type);

  @override
  void clearUpdateRequest(String type) =>
      _signupService.clearUpdateRequest(type);

  @override
  RepoResponse<User> createLFUserAndAssignRoles(User user) =>
      Task(() => _signupService.createLFUserAndAssignRoles(user))
          ._validateResponse();
}

extension _AuthResponse<T> on Task<T> {
  RepoResponse<T> _validateResponse() {
    return attempt()
        .map(
          (either) => either.leftMap(
            (l) {
              if (l is AuthenticationException) {
                return AuthFailure(code: l.name, message: l.message);
              } else if (l is VerificationCodeException) {
                return AuthFailure(code: l.code, message: l.code);
              } else if (l is NetworkException) {
                return AuthFailure(code: l.name, message: l.message);
              } else {
                return AuthFailure(code: 'UnknownError', message: l.toString());
              }
            },
          ),
        )
        .run();
  }
}
