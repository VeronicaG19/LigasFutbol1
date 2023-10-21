class Endpoints {
  static late String _personManagementURLBase;

  static late String _notificationURLBase;

  static late String _appNameGlobal;

  static late int _appId;

  static void init(String baseURL, String personBase, String notificationBase,
      String appName, int appId) {
    _appId = appId;
    _personManagementURLBase = personBase;
    _notificationURLBase = notificationBase;
    _appNameGlobal = appName;
  }

  static String get appName => _appNameGlobal;

  static int get appId => _appId;

  static String get notificationBase =>
      '$_personManagementURLBase/iaas/api/v1/party/devices/data';

  static String getDeviceDataById(int deviceId) =>
      '$notificationBase/$deviceId';

  static String deleteDeviceData(int personId) => '$notificationBase/$personId';

  static String getDeviceDataByPersonId(int personId) =>
      '$notificationBase/by_user/$personId';

  static String getFCMTokensByPersonId(int personId) =>
      '$notificationBase/fcmTocken/$personId';
}
