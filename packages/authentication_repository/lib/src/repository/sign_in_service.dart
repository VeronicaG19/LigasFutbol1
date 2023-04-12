import 'dart:convert';

import 'package:datasource_client/datasource_client.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../endpoints.dart';
import '../exceptions/authentication_exception.dart';

class SignInService {
  final ApiClient _apiClient;

  SignInService(this._apiClient);

  Future<String> login(String name, String password) async {
    final headers = <String, String>{
      'Content-type': 'application/x-www-form-urlencoded',
      'ACCEPT-ORG-ID': '4',
      'authorization': 'Basic ${base64Encode(utf8.encode(kSecret))}',
      'grant_type': 'password',
    };

    final data = {
      'grant_type': 'password',
      'username': name,
      'password': password,
    };

    final request = await http
        .post(Uri.parse(Endpoints.authenticationURL),
            headers: headers, body: data)
        .timeout(
          const Duration(seconds: 60),
          onTimeout: () =>
              throw AuthenticationException.fromCode(AuthExceptionType.timeout),
        );

    if (request.statusCode == 200) {
      final token = jsonDecode(request.body)['access_token'];
      _apiClient.localStorage.setAuthToken(token);
      _apiClient.localStorage.setAuthPassword(password);
      _apiClient.localStorage.setAuthUserName(name);
      /*_apiClient.localStorage.setGenericObjet<String>(
          kSessionCacheKey,
          jsonEncode(oauth
              .copyWith(
                  password: password,
                  username: name,
                  authenticationDate: DateTime.now())
              .toJson()));*/
      return token;
    } else if (request.statusCode == 401 || request.statusCode == 400) {
      throw AuthenticationException.fromCode(AuthExceptionType.unauthorized);
    } else if (request.statusCode == 500) {
      throw AuthenticationException.fromCode(AuthExceptionType.serverException);
    } else {
      throw AuthenticationException.fromCode(
          AuthExceptionType.unknownException);
    }
  }

  void logout() {
    _apiClient.localStorage.resetKey();
  }
}
