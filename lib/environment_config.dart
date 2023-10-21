enum Environment { prod, dev, local, test }

class EnvironmentConfig {
  static late Map<String, dynamic> _config;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.prod:
        _config = _Config.prodConfig;
        break;
      case Environment.dev:
        _config = _Config.devConfig;
        break;
      case Environment.local:
        _config = _Config.localConfig;
        break;
      case Environment.test:
        _config = _Config.testConfig;
        break;
    }
  }

  static String get currentEnvironment => _config[_Config.flavor];

  static String get appName => _config[_Config.appName];

  static String get baseURL => _config[_Config.baseURL];

  static String get promotionBaseURL => ':${_config[_Config.promotionURL]}';

  static String get oauthBaseURL => ':${_config[_Config.oauthURL]}';

  ///person-management-ws
  static String get personManagementBaseURL =>
      ':${_config[_Config.personManagementURL]}';

  ///spr-team-player/iaas/api/v1/leagues
  static String get sprTeamPlayerBaseURL =>
      ':${_config[_Config.sprTeamPlayerURL]}';

  static String get sprAdminBaseURL => ':${_config[_Config.sprAdminURL]}';

  static String get sprRefereeBaseURL => ':${_config[_Config.sprRefereeURL]}';

  static String get qraEventsBaseURL => ':${_config[_Config.qraEventsURL]}';

  static String get notificationServiceBaseURL =>
      ':${_config[_Config.notificationServiceURL]}';

  static String get logoImage => _config[_Config.logoImage];

  static String get appVersion => _config[_Config.appVersion];

  static String get buildNumber => _config[_Config.buildNumber];

  static String get androidDownloadLink => _config[_Config.androidDownloadLink];

  static String get iOSDownloadLink => _config[_Config.iOSDownloadLink];

  static int get orgId => _config[_Config.orgId];

  static bool get showLogs => _config[_Config.showLogs];

  static String get refreshTokenURL =>
      '${_config[_Config.baseURL]}:${_config[_Config.oauthURL]}/oauth/token';

  static String get hereBase => _config[_Config.apiHereBase];
}

class _Config {
  static const flavor = 'flavor';
  static const appName = 'appName';
  static const baseURL = 'baseURL';
  static const promotionURL = 'promotionURL';
  static const oauthURL = 'oauthURL';
  static const personManagementURL = 'personManagementURL';
  static const notificationServiceURL = 'notificationServiceURL';
  static const sprTeamPlayerURL = 'sprTeamPlayerURL';
  static const sprAdminURL = 'sprAdminURL';
  static const sprRefereeURL = 'sprRefereeURL';
  static const qraEventsURL = 'qraEventsURL';
  static const logoImage = 'logoImage';
  static const appVersion = 'appVersion';
  static const buildNumber = 'buildNumber';
  static const androidDownloadLink = 'androidDownloadLink';
  static const iOSDownloadLink = 'iOSDownloadLink';
  static const orgId = 'orgId';
  static const apiHereBase = 'apiHereBase';
  static const showLogs = 'showLogs';

  static Map<String, dynamic> prodConfig = {
    flavor: 'ligas_futbol_prod',
    appName: 'Ligas futbol',
    baseURL: 'https://ligasfutbol.i-condor.com',
    promotionURL: '32777/promotion-ws',
    oauthURL: '32783/auth',
    personManagementURL: '32781/person-management-ws',
    notificationServiceURL: '32778/notifications-delivery-ws',
    sprAdminURL: '32791/spr-admin-ws',
    sprTeamPlayerURL: '32795/team-service-ws',
    sprRefereeURL: '32799/spr-referee-ws',
    qraEventsURL: '32797/qra-events',
    logoImage: 'assets/images/soccer_logo_SaaS.png',
    appVersion: '1.8.56',
    buildNumber: '42',
    androidDownloadLink: '',
    iOSDownloadLink: '',
    orgId: 4,
    apiHereBase: 'https://geocoder.ls.hereapi.com',
    showLogs: true,
  };

  static Map<String, dynamic> devConfig = {
    flavor: 'ligas_futbol_dev',
    appName: 'Ligas futbol',
    baseURL: 'https://wiplif.i-condor.com',
    promotionURL: '32777/promotion-ws',
    oauthURL: '32783/auth',
    personManagementURL: '32781/person-management-ws',
    notificationServiceURL: '32788/notifications-delivery-ws',
    sprAdminURL: '32791/spr-admin-ws',
    sprTeamPlayerURL: '32795/team-service-ws',
    sprRefereeURL: '32799/spr-referee-ws',
    qraEventsURL: '32797/qra-events',
    logoImage: 'assets/images/wiplifIcon.png',
    appVersion: '1.1.22',
    buildNumber: '27',
    androidDownloadLink: '',
    iOSDownloadLink: '',
    orgId: 4,
    apiHereBase: 'https://geocoder.ls.hereapi.com',
    showLogs: true,
  };

  static Map<String, dynamic> localConfig = {
    flavor: 'ligas_futbol_local',
    appName: 'Ligas futbol',
    baseURL: 'http://10.10.10.239',
    promotionURL: '32777/promotion-ws',
    oauthURL: '3443/auth',
    personManagementURL: '32781/person-management-ws',
    notificationServiceURL: '32778/notifications-delivery-ws',
    sprAdminURL: '9099/spr-admin',
    sprTeamPlayerURL: '9098/spr-teamplayer',
    sprRefereeURL: '32799/spr-referee-ws',
    qraEventsURL: '32797/qra-events',
    logoImage: 'assets/images/soccer_logo_SaaS.png',
    appVersion: '1.0.0',
    buildNumber: '1',
    androidDownloadLink: '',
    iOSDownloadLink: '',
    orgId: 4,
    apiHereBase: 'https://geocoder.ls.hereapi.com',
    showLogs: false,
  };

  //ligasfutbol.test.i-condor.com
  static Map<String, dynamic> testConfig = {
    flavor: 'ligas_futbol_test',
    appName: 'Ligas futbol',
    baseURL: 'https://ligasfutbol.test.i-condor.com',
    promotionURL: '32777/promotion-ws',
    oauthURL: '32783/auth',
    personManagementURL: '32781/person-management-ws',
    notificationServiceURL: '32778/notifications-delivery-ws',
    sprAdminURL: '32791/spr-admin',
    sprTeamPlayerURL: '32795/spr-team-player',
    sprRefereeURL: '32799/spr-referee-ws',
    qraEventsURL: '32797/qra-events',
    logoImage: 'assets/images/soccer_logo_SaaS.png',
    appVersion: '1.0.0',
    buildNumber: '1',
    androidDownloadLink: '',
    iOSDownloadLink: '',
    orgId: 4,
    apiHereBase: 'https://geocoder.ls.hereapi.com',
    showLogs: true,
  };
}
