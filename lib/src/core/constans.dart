import 'package:flutter/material.dart';

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

// const List<Permission> permissionList = [
//   Permission.locationAlways,
//   Permission.camera,
//   Permission.microphone,
//   Permission.storage,
//   Permission.contacts
// ];
const double padding = 60;
const double avatarRadius = 45;

// const String kStripePKey =
//     'pk_test_51L38ifAiOERK5NAG8qrcPQCEfLgYuf7meR0lgmoT1l0ISigchP0ArtAmalCI9lC9TgsuY0ZqMCYZBtzf3LCN96PB00JxVA9f2A';

final Map<String, String> mexicoStates = {
  '': 'Cualquier lugar',
  'Ags': 'Aguascalientes',
  'BC': 'Baja California',
  'BCS': 'Baja California Sur',
  'Camp': 'Campeche',
  'CMX': 'Ciudad de México',
  'Chis': 'Chiapas',
  'Chih': 'Chihuahua',
  'Coah': 'Coahuila',
  'Col': 'Colima',
  'Dgo': 'Durango',
  'Edomex': 'Estado de México',
  'Gto': 'Guanajuato',
  'Gro': 'Guerrero',
  'Hgo': 'Hidalgo',
  'Jal': 'Jalisco',
  'Mich': 'Michoacán',
  'Mor': 'Morelos',
  'Nay': 'Nayarit',
  'NL': 'Nuevo León',
  'Oax': 'Oaxaca',
  'Pue': 'Puebla',
  'Qro': 'Querétaro',
  'QRoo': 'Quintana Roo',
  'SLP': 'San Luis Potosí',
  'Sin': 'Sinaloa',
  'Son': 'Sonora',
  'Tab': 'Tabasco',
  'Tamps': 'Tamaulipas',
  'Tlax': 'Tlaxcala',
  'Ver': 'Veracruz',
  'Yuc': 'Yucatán',
  'Zac': 'Zacatecas',
};

class CoachKey {
  //Tutorial referee
  static final usermenuKey = GlobalKey();
  static final notificationKey = GlobalKey();
  static final changeLigesKey = GlobalKey();
  static final matchesKey = GlobalKey();
  static final liguesKey = GlobalKey();
  static final refereeStaticsKey = GlobalKey();
  static final refereeProfile = GlobalKey();
  static final showCalendar = GlobalKey();
  static final reportHistory = GlobalKey();
  static final myProfile = GlobalKey();
  static final myMatchesReferee = GlobalKey();
  static final allMyMatchesReferee = GlobalKey();
  static final liguesReferee = GlobalKey();
  static final statiscReferee = GlobalKey();

  //Admin ligue
  static final leaguesMenuLeagueAdmin = GlobalKey();
  static final mainMenuLeagueAdmin = GlobalKey();
  static final refereeMainLeagueAdmin = GlobalKey();
  static final fieldMainLeagueAdmin = GlobalKey();
  static final catMainPageLeageAdm = GlobalKey();
  static final teamMainPageLeageAdm = GlobalKey();
  static final tournamentMainPageLeageAdm = GlobalKey();
  static final notificationAdKey = GlobalKey();

  //category admin main page
  static final mainSelectCategoryAdminLeg = GlobalKey();
  static final onselectedCatAdminLeag = GlobalKey();
  static final categoryThisTournament = GlobalKey();
  static final pastTournaments = GlobalKey();
  static final addCategoryCategory = GlobalKey();

  //tournament admin main page
  static final catListTournament = GlobalKey();
  static final selectTournamentLi = GlobalKey();
  static final filterTournament1 = GlobalKey();
  static final addTournamentButtn = GlobalKey();

  //tournament configuration details
  static final configTournament = GlobalKey();
  static final teamsTournament = GlobalKey();
  static final roleGamesTournament = GlobalKey();
  static final clasificationTournament = GlobalKey();
  static final scoreTable = GlobalKey();
  static final miniLigue = GlobalKey();

  //edit role games
  static final placeRolGame = GlobalKey();
  static final dateRoleGame = GlobalKey();
  static final hourRoleGame = GlobalKey();
  static final cleanRoleGame = GlobalKey();
  static final fieldRoleGame = GlobalKey();
  static final refereeRoleGame = GlobalKey();
  static final searchButtonRoleGame = GlobalKey();
  static final sendRequesRoleGame = GlobalKey();

  //player role
  static final myProfilePlayer = GlobalKey();
  static final playerData = GlobalKey();
  static final myTeamsPlayer = GlobalKey();
  static final myMatchPlayer = GlobalKey();
  static final searchTeamsPlayer = GlobalKey();

  //team manager
  static final miteamsTemM = GlobalKey();
  static final adminTeamTemM = GlobalKey();
  static final newPlayerTemM = GlobalKey();
  static final myMatchesTemM = GlobalKey();
  static final tournamentTemM = GlobalKey();

  //field manager
  static final addField = GlobalKey();
  static final listFields = GlobalKey();
  static final agendField = GlobalKey();
  static final priecesField = GlobalKey();
  static final detailField = GlobalKey();
  static final detailQualifications = GlobalKey();

  // qualify player
  static final visitTeamInformation = GlobalKey();
  static final localTeamInformation = GlobalKey();
  static final statusMatch = GlobalKey();
  static final qualifyReferee = GlobalKey();
  static final qualifyFieldOwner = GlobalKey();

  // qualify referee
  static final visitTeamQualify = GlobalKey();
  static final localTeamQualify = GlobalKey();
  static final fieldOwnerTeamQualify = GlobalKey();
  static final reviewPlayers = GlobalKey();

  // qualify team manager
  static final qualifyPlayers = GlobalKey();

  // qualify league manager
  static final qualifyGeneralRating = GlobalKey();
}

final textInputDecoration = InputDecoration(
  border: const OutlineInputBorder(
    borderSide: BorderSide(
      width: 1.5,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(width: 1.5),
    borderRadius: BorderRadius.circular(15),
  ),
  labelStyle: const TextStyle(fontSize: 15),
  helperText: '',
);
