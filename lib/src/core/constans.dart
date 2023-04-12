import 'package:permission_handler/permission_handler.dart';

const String kDefaultAvatarImagePath = 'assets/images/default_user.png';

const String kDefaultLogoImagePath = 'assets/images/equipo2.png';

//const String kGenericUr = 'https://microservicescontabo.com';
//const String kGenericUr = 'https://microservices$_kHost.i-condor.com';
/// alarm-administration base URL
//const String kAdministrationUrl = '$kGenericUr:32772/administration-ws';
//    'http://192.168.0.103:8442/alarm-administration';

/// alarm-operation base URL
//const String kOperationUrl = '$kGenericUr:32779/operation-ws';

/// promotion base URL
//const String kPromotionUrl = '$kGenericUr:32777/promotion-ws';

// Exception codes
const String kUnknownErrorCode = 'unknownError';
const String kSocketExceptionCode = 'socketException';
const String kNotModifiedCode = 'notModified';
const String kBadRequestCode = 'badRequest';
const String kUnauthorizedCode = 'unauthorized';
const String kUsedCode = 'imUsed';
const String kForbiddenCode = 'forbidden';
const String kNotFoundCode = 'notFound';
const String kServerErrorCode = 'serverError';
const String kTimeoutCode = 'timeout';
const String kNoCacheFound = 'noCacheFound';
const String kVoskActivationError = 'voskError';

const String kTestinNtAdd = 'DEVICE_NOT_CONECTED';
const String kTestNotR = 'DEVICE_NOT_REGISTERED';

// Keys
const String kStoredAuxilioSessionKey = '___stored__auxilio_key__';

const String kLocalNotificationRequestKey = '___stored__local_notf_requst_key_';

const String kInTransitVerificationCode = 'IN_TRANSIT_VERIFICATION_CODE';

const String kAuxilioNotificationCode = 'AUXILIO_NOTIFICATION';

const String kInvitactionRecivied = 'SEND_INVITATION';

const String kAuxilioNotificationTestCode = 'AUXILIO_NOTIFICATION_TEST';

const String kVoiceListeningStatus = '__V01c3_LisT3Ning_sTatUs_';

const String kIncorrectCode = 'CODE_INCORRECT';
const String kVerifiedCode = 'VERIFIED';

const String kVoskMethodChannel = 'flutter.auxilio/vosk';

const String kGeocodeBaseUrl = 'https://reverse.geocoder.api.here.com';
const String kGeocodeApiKey =
    'KGpp27zvJdCVyu0OmOwT&app_code=PhPBp3nr61JVXm1nzGwS1Q';
const String kAgoraAPPID = 'cb259d07931b48adaa605c8868962646';

const String kAgoraToken = '5386ce090c614a09b7aab96a1bfed792';

const String kApiHereKey = 'MxGbe2z1Q0yXjvflywaRJ1u9pd6alq3A2lfuK3aLO5A';

/// auxilio logo image path
//const String kAppLogoImagePath = 'assets/images/logo_aux.png';

const String appName = "Flutter Permissions";
const String buttonTextDefault = "Allow";
const String buttonTextSuccess = "Continue";
const String buttonTextPermanentlyDenied = "Settings";
const String titleDefault = "Permission Needed";
const String displayMessageDefault =
    "To serve you the best user experience we need few permission. Please allow it.";
const String displayMessageSuccess =
    "Success, all permissions are granted. Please click the below button to continue.";
const String displayMessageDenied =
    "To serve you the best user experience we need few permission but it seems like you denied.";
const String displayMessagePermanentlydenied =
    "To serve you the best user experience we need few permission but it seems like you permanently denied it. Please goto settings and enable it manually to proceed further.";

const List<Permission> permissionList = [
  Permission.locationAlways,
  Permission.camera,
  Permission.microphone,
  Permission.storage,
  Permission.contacts
];
const double padding = 60;
const double avatarRadius = 45;

// const String kStripePKey =
//     'pk_test_51L38ifAiOERK5NAG8qrcPQCEfLgYuf7meR0lgmoT1l0ISigchP0ArtAmalCI9lC9TgsuY0ZqMCYZBtzf3LCN96PB00JxVA9f2A';

final Map<String, String> mexicoStates = {
  'aguascalientes': 'Aguascalientes',
  'baja_california': 'Baja California',
  'baja_california_sur': 'Baja California Sur',
  'campeche': 'Campeche',
  'chiapas': 'Chiapas',
  'chihuahua': 'Chihuahua',
  'coahuila': 'Coahuila',
  'colima': 'Colima',
  'durango': 'Durango',
  'estado_de_méxico': 'Estado de México',
  'guanajuato': 'Guanajuato',
  'guerrero': 'Guerrero',
  'hidalgo': 'Hidalgo',
  'jalisco': 'Jalisco',
  'michoacan': 'Michoacán',
  'morelos': 'Morelos',
  'nayarit': 'Nayarit',
  'nuevo_león': 'Nuevo León',
  'oaxaca': 'Oaxaca',
  'puebla': 'Puebla',
  'queretaro': 'Querétaro',
  'quintana_roo': 'Quintana Roo',
  'san_luis_potosi': 'San Luis Potosí',
  'sinaloa': 'Sinaloa',
  'sonora': 'Sonora',
  'tabasco': 'Tabasco',
  'tamaulipas': 'Tamaulipas',
  'tlaxcala': 'Tlaxcala',
  'veracruz': 'Veracruz',
  'yucatan': 'Yucatán',
  'zacatecas': 'Zacatecas',
};
