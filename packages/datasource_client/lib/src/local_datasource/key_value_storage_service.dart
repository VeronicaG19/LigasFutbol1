import 'package:flutter/foundation.dart';

import '../constants.dart';
import 'key_value_storage_base.dart';

class KeyValueStorageService {
  static const _authTokenKey = kAuthTokenKey;

  static const _authPasswordKey = kAuthPasswordKey;

  static const _authUserNameKey = kAuthUserNameKey;

  final _keyValueStorage = KeyValueStorageBase();

  Future<String> getAuthPassword() async {
    late String password;
    if (kIsWeb) {
      password =
          _keyValueStorage.getCommon<String>('$_authPasswordKey-C') ?? '';
    } else {
      password = await _keyValueStorage.getEncrypted(_authPasswordKey) ?? '';
    }
    return password;
  }

  Future<String> getAuthUserName() async {
    late String userName;
    if (kIsWeb) {
      userName =
          _keyValueStorage.getCommon<String>('$_authUserNameKey-C') ?? '';
    } else {
      userName = await _keyValueStorage.getEncrypted(_authUserNameKey) ?? '';
    }
    return userName;
  }

  Future<String> getAuthToken() async {
    late String token;
    if (kIsWeb) {
      token = _keyValueStorage.getCommon<String>('$_authTokenKey-C') ?? '';
    } else {
      token = await _keyValueStorage.getEncrypted(_authTokenKey) ?? '';
    }
    return token;
  }

  void setAuthPassword(String password) {
    _keyValueStorage.setEncrypted(_authPasswordKey, password);
    _keyValueStorage.setCommon('$_authPasswordKey-C', password);
  }

  void setAuthUserName(String userName) {
    _keyValueStorage.setEncrypted(_authUserNameKey, userName);
    _keyValueStorage.setCommon('$_authUserNameKey-C', userName);
  }

  void setAuthToken(String token) {
    _keyValueStorage.setEncrypted(_authTokenKey, token);
    _keyValueStorage.setCommon('$_authTokenKey-C', token);
  }

  void setGenericObjet<T>(String key, T value) {
    _keyValueStorage.setCommon(key, value);
  }

  T? getGenericObject<T>(String key) {
    return _keyValueStorage.getCommon(key);
  }

  Future<void> clearCommonKey(String key) async {
    _keyValueStorage.clearCommonKey(key);
  }

  void resetKey() {
    _keyValueStorage
      ..clearCommon()
      ..clearEncrypted();
  }
}
