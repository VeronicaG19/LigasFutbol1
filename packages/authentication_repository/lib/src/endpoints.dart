class Endpoints {
  static late String _authURLBase;

  static late String _personManagementURLBase;

  static late String _notificationURLBase;

  static late String _appNameGlobal;

  static late String _baseURL;

  static void init(String baseURL, String authBase, String personBase,
      String notificationBase, String appName) {
    _authURLBase = authBase;
    _personManagementURLBase = personBase;
    _notificationURLBase = notificationBase;
    _appNameGlobal = appName;
    _baseURL = baseURL;
  }

  static String get appName => _appNameGlobal;

  ///Endpoint to validate if an email is already registered.
  ///
  ///METHOD POST
  static String validateEmailURL(String email) =>
      '$_personManagementURLBase/iaas/api/v1/validate/party/$email';

  ///Endpoint to validate if a phone number is already registered.
  ///
  ///METHOD GET
  static String validatePhoneURL(String phone) =>
      '$_personManagementURLBase/iaas/api/v1/party/phone/$phone';

  ///Endpoint to validate if a user name is already registered.
  ///
  ///METHOD POST
  static String validateUserNameURL(String userName) =>
      '$_personManagementURLBase/iaas/api/v1/validate/user/$userName';

  ///Endpoint to confirm the verification code to validate a person through
  ///the registration process.
  ///
  ///METHOD PATCH
  static String confirmVerificationCodeURL(int? code, String userInput) =>
      '$_personManagementURLBase/iaas/api/v1/users/status/verify/code/$code/$userInput';

  ///Endpoint to send a verification code by email
  ///
  /// METHOD POST
  static String sendVerificationCodeByEmailURL(String receiver) =>
      '$_personManagementURLBase/iaas/api/v1/post/verificationcode/$receiver';

  ///Endpoint to send a verification code by phone
  static String sendVerificationCodeURL(String type, String receiver) =>
      '$_personManagementURLBase/iaas/api/v1/post/verificationcode/$type/$receiver';

  ///Endpoint to send a verification code by phone
  ///
  /// METHOD POST
  static String sendVerificationCodeByPhoneURL(String receiver) =>
      '$_personManagementURLBase/iaas/api/v1/verificationcode/$receiver';

  ///Endpoint to register a new user
  ///
  /// METHOD POST
  static String get signupUserURL =>
      '$_personManagementURLBase/iaas/api/v1/partyUser';

  ///Endpoint to register a new user
  ///
  /// METHOD POST
  static String get createLFURL =>
      '$_personManagementURLBase/iaas/api/v1/create-LF-user/with/roles';

  ///Endpoint to send an email notification
  ///
  /// METHOD POST
  static String get sendEmailNotificationUrl =>
      '$_baseURL$_notificationURLBase/notifications/jm/html';

  ///Endpoint to recover password
  ///
  /// METHOD PATCH
  static String recoverPasswordURL(String sender) =>
      '$_personManagementURLBase/iaas/api/v1/user/temporal/password/$sender';

  ///Endpoint for authentication
  ///
  /// METHOD POST
  static String get authenticationURL => '$_baseURL$_authURLBase/oauth/token';
}
