class Endpoints {
  static late String _personManagementURLBase;
  static late String _appNameGlobal;

  static void init(String personBase, String appName) {
    _personManagementURLBase = personBase;
    _appNameGlobal = appName;
  }

  static String get appName => _appNameGlobal;

  ///Endpoint to get PERSON data by userName
  ///
  ///METHOD GET
  static String get getPersonDataByUserNameURL =>
      '$_personManagementURLBase/iaas/api/v1/party/user';

  ///Endpoint to get PERSON data by personId
  ///
  /// METHOD GET
  static String getPersonDataByIdURL(int personId) =>
      '$_personManagementURLBase/iaas/api/v1/parties/$personId';

  ///Endpoint to get USER data by userName
  ///
  /// METHOD GET
  static String getUserDataByUserNameURL(String userName) =>
      '$_personManagementURLBase/iaas/api/v1/user/$userName';

  ///Endpoint to validate if an email is already registered.
  ///
  ///METHOD POST
  static String get validateEmailURL =>
      '$_personManagementURLBase/iaas/api/v1/validate/party';

  ///Endpoint to validate if a phone number is already registered.
  ///
  ///METHOD GET
  static String get validatePhoneURL =>
      '$_personManagementURLBase/iaas/api/v1/party/phone';

  ///Endpoint to validate if a user name is already registered.
  ///
  ///METHOD POST
  static String get validateUserNameURL =>
      '$_personManagementURLBase/iaas/api/v1/validate/user';

  static String get updatePartyURL =>
      '$_personManagementURLBase/iaas/api/v1/parties';

  static String get updateUserURL =>
      '$_personManagementURLBase/iaas/api/v1/users';

  static String get updateUserNameURL =>
      '$_personManagementURLBase/iaas/api/v1/userName';
}
