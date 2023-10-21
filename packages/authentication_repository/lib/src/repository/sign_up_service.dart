import 'dart:convert';

import 'package:datasource_client/datasource_client.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:user_repository/user_repository.dart';

import '../constants.dart';
import '../endpoints.dart';
import '../exceptions/verification_code_exception.dart';
import '../models/notification_email.dart';
import '../models/verification_code.dart';

class SignupService {
  final ApiClient _apiClient;

  SignupService(this._apiClient);

  Future<User> signUpUser(User user) async {
    final response = await _registerUser(user);
    await _apiClient.localStorage.clearCommonKey(kCachedVerificationCodeKey);
    return user.copyWith(person: response);
  }

  Future<User> createLFUserAndAssignRoles(User user) async {
    final response = await _createLFUser(user);
    return user.copyWith(person: response);
  }

  Future<Person> _createLFUser(User user) async {
    final response = await _apiClient.network.postData(
        endpoint: Endpoints.createLFURL,
        data: user.toJsonForRegistration(),
        requiresAuthToken: false,
        converter: (body) => Person.fromJson(body['party']));
    return response;
  }

  Future<Person> _registerUser(User user) async {
    final response = await _apiClient.network.postData(
        endpoint: Endpoints.signupUserURL,
        data: user.toJsonForRegistration(),
        requiresAuthToken: false,
        converter: (body) => Person.fromJson(body['party']));
    try {
      await _sendAccountDataByEmail(response.getMainEmail, user);
    } on NetworkException catch (e) {
      debugPrint('Email sender Network error ${e.message}');
    } catch (e) {
      debugPrint('Email sender error --> ${e.toString()}');
    }
    return response;
  }

  Future<VerificationCode> submitVerificationCode(String receiver) async {
    await _validateReceiver(receiver);
    return await _validateCacheCode(receiver);
  }

  Future<VerificationCode> resentVerificationCode(
      String receiver, bool isForUpdate) async {
    String? cacheJson;
    if (isForUpdate) {
      await _validateReceiverForUpdate(receiver);
      if (_getVerificationType(receiver) == kPhoneVerification) {
        cacheJson = _apiClient.localStorage
            .getGenericObject<String>(kPhoneUpdateCacheKey);
      } else {
        cacheJson = _apiClient.localStorage
            .getGenericObject<String>(kEmailUpdateCacheKey);
      }
      final cacheCode = VerificationCode.fromJson(jsonDecode(cacheJson!));
      return await _sendVerificationCode(receiver, cacheCode.intents ?? 0,
          cacheCode.resetTime ?? DateTime.now(), true);
    } else {
      await _validateReceiver(receiver);
      cacheJson = _apiClient.localStorage
          .getGenericObject<String>(kCachedVerificationCodeKey);
      final cacheCode = VerificationCode.fromJson(jsonDecode(cacheJson!));
      return await _sendVerificationCode(receiver, cacheCode.intents ?? 0,
          cacheCode.resetTime ?? DateTime.now(), false);
    }
  }

  Future<VerificationCode> submitCodeConfirmation(String userInput) async {
    final response = await _confirmVerificationCode(userInput, false);
    if (!response.isTheCodeValidated) {
      throw const VerificationCodeException.invalidCode();
    }
    return response;
  }

  Future<String> recoverPassword(String userSender) async {
    final emailRegex = RegExp(
        r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]');
    final response = await _apiClient.network.updateData(
        endpoint: Endpoints.recoverPasswordURL(userSender),
        data: {},
        requiresAuthToken: false,
        converter: User.fromJson);
    if (emailRegex.hasMatch(userSender)) {
      try {
        await _sendRecoveredPasswordByEmail(userSender, response);
      } on NetworkException catch (e) {
        debugPrint('Email sender Network error ${e.message}');
      } catch (e) {
        debugPrint('Email sender error --> ${e.toString()}');
      }
    }
    return response.userName;
  }

  Future<void> _validateReceiverForUpdate(String receiver) async {
    bool validateReceiver = false;
    if (_getVerificationType(receiver) == kPhoneVerification) {
      final phoneList = await _apiClient.network.getCollectionData(
          endpoint: Endpoints.validatePhoneURL(receiver),
          requiresAuthToken: false,
          converter: PhoneNumber.fromJson);
      validateReceiver = phoneList.isNotEmpty;
    } else {
      validateReceiver = await _apiClient.network.getData(
          endpoint: Endpoints.validateEmailURL(receiver),
          requiresAuthToken: false,
          converter: (response) => response['result'] as String == 'true');
    }
    if (validateReceiver) {
      throw const VerificationCodeException.exists();
    }
  }

  Future<VerificationCode> sendVerificationCodeForDataUpdate(
      String receiver, bool isChangingUser) async {
    isChangingUser
        ? await _validateReceiver(receiver)
        : await _validateReceiverForUpdate(receiver);
    final cacheJson = _getVerificationType(receiver) == kPhoneVerification
        ? _apiClient.localStorage.getGenericObject<String>(kPhoneUpdateCacheKey)
        : _apiClient.localStorage
            .getGenericObject<String>(kEmailUpdateCacheKey);
    if (cacheJson == null) {
      return await _sendVerificationCode(receiver, 0, DateTime.now(), true);
    }
    final cacheCode = VerificationCode.fromJson(jsonDecode(cacheJson));
    final verificationCode =
        cacheCode.getDateValidation && cacheCode.receiver == receiver
            ? cacheCode
            : await _sendVerificationCode(receiver, cacheCode.intents ?? 0,
                cacheCode.resetTime ?? DateTime.now(), true);
    return verificationCode;
  }

  Future<VerificationCode> submitCodeForUpdate(String code, String type) async {
    final response = await _confirmVerificationCode(code, true, type: type);
    if (!response.isTheCodeValidated) {
      throw const VerificationCodeException.invalidCode();
    }
    if (type == 'phone') {
      _apiClient.localStorage.clearCommonKey(kPhoneUpdateCacheKey);
    } else {
      _apiClient.localStorage.clearCommonKey(kEmailUpdateCacheKey);
    }
    return response;
  }

  VerificationCode getCacheCodeForUpdate(String type) {
    final cacheJson = type == 'phone'
        ? _apiClient.localStorage.getGenericObject<String>(kPhoneUpdateCacheKey)
        : type == 'email'
            ? _apiClient.localStorage
                .getGenericObject<String>(kEmailUpdateCacheKey)
            : null;
    if (cacheJson == null) {
      return VerificationCode.empty;
    }
    return VerificationCode.fromJson(jsonDecode(cacheJson));
  }

  void clearUpdateRequest(String type) {
    if (type == 'email') {
      _apiClient.localStorage.clearCommonKey(kEmailUpdateCacheKey);
    } else if (type == 'phone') {
      _apiClient.localStorage.clearCommonKey(kPhoneUpdateCacheKey);
    }
  }

  Future<VerificationCode> _confirmVerificationCode(
      String userInput, bool isForUpdate,
      {String? type}) async {
    String? cacheJson;
    if (isForUpdate) {
      cacheJson = type == 'phone'
          ? _apiClient.localStorage
              .getGenericObject<String>(kPhoneUpdateCacheKey)
          : _apiClient.localStorage
              .getGenericObject<String>(kEmailUpdateCacheKey);
    } else {
      cacheJson = _apiClient.localStorage
          .getGenericObject<String>(kCachedVerificationCodeKey);
    }
    final cacheCode = VerificationCode.fromJson(jsonDecode(cacheJson ?? ''));
    try {
      final response = await _apiClient.network.updateData(
          endpoint: Endpoints.confirmVerificationCodeURL(
              cacheCode.verificationCodeId, userInput),
          data: {},
          requiresAuthToken: false,
          converter: VerificationCode.fromJson);
      _apiClient.localStorage.setGenericObjet(
          kCachedVerificationCodeKey,
          jsonEncode(
              cacheCode.copyWith(statusCode: response.statusCode).toJson()));
      return cacheCode.copyWith(statusCode: response.statusCode);
    } catch (_) {
      throw const VerificationCodeException.invalidCode();
    }
  }

  Future<VerificationCode> _validateCacheCode(String receiver) async {
    final cacheJson = _apiClient.localStorage
        .getGenericObject<String>(kCachedVerificationCodeKey);
    if (cacheJson == null) {
      return await _sendVerificationCode(receiver, 0, DateTime.now(), false);
    }
    final cacheCode = VerificationCode.fromJson(jsonDecode(cacheJson));
    final verificationCode =
        cacheCode.getDateValidation && cacheCode.receiver == receiver
            ? cacheCode
            : await _sendVerificationCode(receiver, cacheCode.intents ?? 0,
                cacheCode.resetTime ?? DateTime.now(), false);
    return verificationCode;
  }

  Future<VerificationCode> _sendVerificationCode(
      String receiver, int intents, DateTime reset, bool isForUpdate) async {
    if (intents > 2 && reset.isAfter(DateTime.now())) {
      final resetTime = reset.difference(DateTime.now());
      final content = {'code': 'intentsExceeded', 'time': resetTime.inMinutes};
      final message = jsonEncode(content);
      throw VerificationCodeException.intentsExceeded(message);
    }

    VerificationCode? response;
    if (_getVerificationType(receiver) == kPhoneVerification) {
      response = await _apiClient.network.postData(
          endpoint: Endpoints.sendVerificationCodeURL("2", receiver),
          data: {},
          requiresAuthToken: false,
          converter: VerificationCode.fromJson);
    } else if (_getVerificationType(receiver) == kEmailVerification) {
      response = await _apiClient.network.postData(
          endpoint: Endpoints.sendVerificationCodeURL("1", receiver),
          data: {},
          requiresAuthToken: false,
          converter: VerificationCode.fromJson);
      /* if (response != null) {
        try {
          await _sendVerificationCodeByEmail(
              receiver, response.verificationCode);
        } on NetworkException catch (e) {
          debugPrint('Email sender Network error --> ${e.message}');
        } catch (e) {
          debugPrint('Email sender error --> ${e.toString()}');
        }
      }*/
    }
    if (response == null) {
      throw const VerificationCodeException.invalidCode();
    }
    final verificationCode = response.copyWith(
        resetTime: DateTime.now().add(const Duration(minutes: 30)),
        intents: intents + 1);
    if (isForUpdate) {
      if (_getVerificationType(receiver) == kPhoneVerification) {
        _apiClient.localStorage.setGenericObjet(
            kPhoneUpdateCacheKey, jsonEncode(verificationCode.toJson()));
      } else {
        _apiClient.localStorage.setGenericObjet(
            kEmailUpdateCacheKey, jsonEncode(verificationCode.toJson()));
      }
    } else {
      _apiClient.localStorage.setGenericObjet(
          kCachedVerificationCodeKey, jsonEncode(verificationCode.toJson()));
    }
    return verificationCode;
  }

  Future<void> _validateReceiver(String receiver) async {
    bool validateReceiver = false;
    if (_getVerificationType(receiver) == kPhoneVerification) {
      final phoneList = await _apiClient.network.getCollectionData(
          endpoint: Endpoints.validatePhoneURL(receiver),
          requiresAuthToken: false,
          converter: PhoneNumber.fromJson);
      validateReceiver = phoneList.isNotEmpty;
    } else {
      validateReceiver = await _apiClient.network.getData(
          endpoint: Endpoints.validateEmailURL(receiver),
          requiresAuthToken: false,
          converter: (response) => response['result'] as String == 'true');
    }
    if (!validateReceiver) {
      validateReceiver = await _apiClient.network.getData(
          endpoint: Endpoints.validateUserNameURL(receiver),
          requiresAuthToken: false,
          converter: (response) => response['result'] as String == 'true');
    }
    if (validateReceiver) {
      throw const VerificationCodeException.exists();
    }
  }

  String _getVerificationType(String receiver) {
    final phoneRegExp = RegExp(r'^[0-9]{10}');
    if (phoneRegExp.hasMatch(receiver) && receiver.length == 10) {
      return kPhoneVerification;
    } else {
      return kEmailVerification;
    }
  }

  Future<String> _sendVerificationCodeByEmail(String email, String code) async {
    final String subject = 'Código de verificación para ${Endpoints.appName}';
    const String kVerificationCodeMessage =
        'C&oacute;digo de verificaci&oacute;n';
    const String kVerificationCodeMessage2 =
        '&#161;Ya casi terminamos con tu registro!';

    final String bodyMessage =
        "Utiliza el siguiente c&oacute;digo de verificaci&oacute;n para poder acceder a tu cuenta de ${Endpoints.appName}:" +
            "<br><br>C&oacute;digo: <b style='font-family:georgia,serif;font-size:12pt;color:rgb(68,68,68)'>$code</b></p>\n\n";
    const title3 =
        "&#161;Gracias por hacer de México un lugar que promueve y fomenta el Deporte!";
    final String hTMLTemplate = _buildTemplateHTML(kVerificationCodeMessage,
        kVerificationCodeMessage2, bodyMessage, title3);
    final headers = <String, String>{
      'Content-type': 'application/json',
      'ACCEPT-ORG-ID': '4',
    };

    final data = jsonEncode(
        NotificationEmail.build([email], subject, hTMLTemplate).toJson());

    return await _sendEmailNotification(data);
    // return await _apiClient.network.postData(
    //     endpoint: Endpoints.sendEmailNotificationUrl,
    //     data: NotificationEmail.build([email], subject, hTMLTemplate).toJson(),
    //     requiresAuthToken: false,
    //     converter: (response) => response['response'] ?? '');
  }

  Future<String> _sendAccountDataByEmail(String email, User user) async {
    final String subject = 'Datos de acceso a ${Endpoints.appName}';
    final String kUserAndPassword =
        '&#161;Gracias por sumarte a la comunidad de ${Endpoints.appName}!';
    const text1 = "Te escribimos "
        "para confirmar tu registro formal realizado en nuestra aplicaci&oacute;n. ";
    final String bodyMessage =
        "A continuación te hacemos llegar tu usuario y contraseña para que ingreses a la aplicaci&oacute;n:<br><p> \n \n"
        "Usuario: <b style='font-family:georgia,serif;font-size:12pt;color:rgb(68,68,68)'>${user.userName}</b></p><p>"
        "Contraseña: <b style='font-family:georgia,serif;font-size:12pt;color:rgb(68,68,68)'>"
        "${user.password}</b></p>";
    const text2 = "&#161;Gracias por hacer de México un lugar que promueve y fomenta el Deporte!";
    final String hTMLTemplate =
        _buildTemplateHTML(kUserAndPassword, text1, bodyMessage, text2);
    final headers = <String, String>{
      'Content-type': 'application/json',
      'ACCEPT-ORG-ID': '4',
    };

    final data = jsonEncode(
        NotificationEmail.build([email], subject, hTMLTemplate).toJson());

    return await _sendEmailNotification(data);
    // return await _apiClient.network.postData(
    //     endpoint: Endpoints.sendEmailNotificationUrl,
    //     data: NotificationEmail.build([email], subject, hTMLTemplate).toJson(),
    //     requiresAuthToken: false,
    //     converter: (response) => response['response'] ?? '');
  }

  Future<String> _sendRecoveredPasswordByEmail(String email, User user) async {
    final String kPasswordRecoveryMsg = 'BIENVENID@ a ${Endpoints.appName}';
    final String subject =
        'Restablecimiento de contraseña de ${Endpoints.appName}';
    const title1 = "";
    final String bodyMessage =
        "A continuaci&oacute;n te compartimos tus datos de acceso: <br><br>Usuario: <b style='padding-bottom: 0; text-align: center; font-weight: bold; font-size: 14px; letter-spacing: normal !important; color: #43515c'>${user.userName}</b></p><p>\nContraseña: <b style='padding-bottom: 0; text-align: center; font-weight: bold; font-size: 14px; letter-spacing: normal !important; color: #43515c'>${user.password}</b></p>\n\nPor seguridad esta contraseña es temporal, te sugerimos cambiarla una vez que inicies sesi&oacute;n en el apartado de Mi cuenta desde la aplicaci&oacute;n.\n \n";
    const title2 = "&#161;Gracias por unirte a Ligas Fútbol";
    final String hTMLTemplate =
        _buildTemplateHTML(kPasswordRecoveryMsg, title1, bodyMessage, title2);

    final data = jsonEncode(
        NotificationEmail.build([email], subject, hTMLTemplate).toJson());
    return await _sendEmailNotification(data);
    // return await _apiClient.network.postData(
    //     endpoint: Endpoints.sendEmailNotificationUrl,
    //     data: NotificationEmail.build([email], subject, hTMLTemplate).toJson(),
    //     requiresAuthToken: false,
    //     converter: (response) => response['response'] ?? '');
  }

  Future<String> _sendEmailNotification(String data) async {
    final headers = <String, String>{
      'Content-type': 'application/json',
      'ACCEPT-ORG-ID': '4',
    };
    debugPrint('${Uri.parse(Endpoints.sendEmailNotificationUrl)}');
    final request = await http
        .post(Uri.parse(Endpoints.sendEmailNotificationUrl),
            headers: headers, body: data)
        .timeout(const Duration(seconds: 60));
    //return jsonDecode(request.body)['response'] ?? '';
    return '';
  }

  String _buildTemplateHTML(
      String title, String subtitle, String body, String title2) {
    return "<html xmlns='http://www.w3.org/1999/xhtml' style='color:rgb(68,68,68)'><head><meta name='viewport' content='width=device-width, user-scalable=no, initial-scale=1.0, telephone=no, text/html' http-equiv='Content-Type' charset='utf-8' />"
        "<title>LigasFútbol.com</title><style type='text/css'>.ReadMsgBody {width: 100%;background-color: #ffffff;}.ExternalClass {width: 100%;background-color: #ffffff;}.ExternalClass,.ExternalClass p,.ExternalClass span,.ExternalClass font,.ExternalClass td,.ExternalClass div {line-height: 90%;}body {-webkit-text-size-adjust: none;-ms-text-size-adjust: none;font-family: Helvetica, arial, sans-serif;}body {margin: 0;padding: 0;}table {border-spacing: 0;}table td {border-collapse: collapse;}.yshortcuts a {border-bottom: none !important;} a {text-decoration: none;}.center {text-align: center;}.corners-small {-webkit-border-radius: 30px;-moz-border-radius: 30px;border-radius: 30px;}div.desktop-header {color: #ffffff;}.header-wrapper {padding-bottom: 0 !important;}.btn {text-align: center;padding-top: 6px;padding-bottom: 6px;}.cta-btn {padding-top: 12px;padding-bottom: 12px;}table.container {width: 600px !important;} .small-text {font-size: 10px !important;}.mobile-br {display: none !important;}.appleLinksBlack a {color: #858f96 !important;text-decoration: none;}@media only screen and (max-width:1290px) {.container-padding {-webkit-border-radius: 0 !important;padding-left: 5% !important; padding-right: 5% !important;}.text-block-titel {font-size: 75% !important; line-height: 120% !important;}.text-block-bold {font-weight: bold !important;}.text-block-sub-titel {font-size: 100% !important;line-height: 150% !important;}.text-block-center {text-align: center !important;}.mobile-bullet-padding {vertical-align: top !important;}}@media only screen and (max-width:600px) {.appleLinksBlack a {color: #858f96 !important;text-decoration: none;}.mob-icon-width { width: 100% !important; max-width: 100% !important;}.text-block {font-size: 100% !important;line-height: 140% !important;}.text-block-bold {font-weight: bold !important;}.text-block-titel {font-size: 80% !important;line-height: 120% !important;}.text-block-sub-titel {font-size: 100% !important;line-height: 150% !important;}.text-block-center {text-align: center !important;}.text-block-left {text-align: left !important;}.text-block-right {text-align: right !important;}.padding-zero {padding: 0 0 0 0 !important;}.elem-width {width: 100% !important;max-width: 100% !important;}.mob-img-width {width: 100% !important;}.mob-text-block-padding-top {padding-top: 15px !important;}.mob-text-block-padding-bottom {padding-bottom: 25px !important;}.mob-img-block-padding-top {padding-top: 5px !important;}.mob-img-block-padding-bottom {padding-bottom: 10px !important;}.mobile-br {display: block !important;}.btn {display: inline-block;text-align: center;width: 100%;margin: auto;}.cta-btn {padding-top: 10px;padding-bottom: 10px;display: block;width: 45% !important;font-size: 22px;}.mob-img-ribbon-padd {padding: 15px 0px 20px 0px !important;}.no-border-mob {border: 0 !important;}div,span {text-size-adjust: none;}.invisible-text,.invisible-text a {color: #fff !important;}.container-padding { -webkit-border-radius: 0 !important;padding-left: 5% !important; padding-right: 5% !important;}.container-padding-2 {-webkit-border-radius: 0 !important;padding-left: 3% !important;padding-right: 3% !important;}.desktop-header {display: none;}.desktop-header {display: none;}div {-webkit-text-size-adjust: none;}table.container {width: 100% !important;padding-left: 0 !important;padding-right: 0 !important;}.center {text-align: center !important;}.desktop-block {display: none !important;}.mobile-block-holder {width: 100% !important;height: auto !important;max-width: none !important;max-height: none !important;display: block !important;}.mobile-block {display: block !important;}.mobile-disclaimer {background-color: #fff;}.mobile-bullets-left-padding {padding-left: 30px !important;}.mobile-bullets-right-padding {padding-right: 20px !important;}.mobile-bullet-padding {vertical-align: top !important;}}@media only screen and (min-width:560px) and (max-width:600px) {.cta-btn {padding-top: 10px;padding-bottom: 10px;display: block;width: 45% !important;font-size: 22px;}}@media only screen and (min-width:540px) and (max-width:600px) {.cta-btn {padding-top: 10px;padding-bottom: 10px;display: block;width: 45% !important;font-size: 22px;}.text-block {font-size: 100% !important;line-height: 140% !important;}}@media only screen and (min-device-width:322px) and (max-width:539px) {.cta-btn {padding-top: 10px;padding-bottom: 10px;display: block;width: 39% !important;font-size: 22px;}.text-block {font-size: 100% !important;line-height: 140% !important;}.text-block-2 {font-size: 100% !important;line-height: 140% !important;}.mob-icon-text-block-1 {text-align: center !important;}}@media only screen and (min-width:320px) and (max-width:320px) {.cta-btn {padding-top: 10px;padding-bottom: 10px;display: block;width: 47% !important;font-size: 22px;}.text-block {font-size: 100% !important;line-height: 140% !important;}.text-block-2 {font-size: 100% !important;line-height: 140% !important;}}@media only screen and (min-device-width: 375px) and (max-device-width: 667px) and (-webkit-min-device-pixel-ratio: 2) {.cta-btn {padding-top: 10px;padding-bottom: 10px;display: block;width: 45% !important;font-size: 22px;}.text-block {font-size: 100% !important;line-height: 140% !important;}.text-block-2 {font-size: 100% !important;line-height: 140% !important;}}.mobile-block-holder {width: 0;height: 0; max-width: 0;max-height: 0;overflow: hidden;}.mobile-block-holder,.mobile-block {display: none;}.desktop-block,.desktop-header,.desktop-image {display: block;} </style><meta http-equiv='Content-Type' content='text/html; charset=utf-8'></head><body yahoo='fix' style='background-color: rgb(247, 248, 250); min-width: 100%; height: 100%; margin: 0px; padding: 0px; width: 100%; text-size-adjust: 100%;'><div> <center><table border='0' cellpadding='0' cellspacing='0' height='100%' width='100%' style='background-color: #fff; border-collapse: collapse; mso-table-lspace: 0pt; margin: 0 auto; mso-table-rspace: 0pt; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; height: 100%; margin: 0; padding: 0; width: 100%; direction: ltr'><tbody><tr><td align='center' height='100%' valign='top' width='100%' style='mso-line-height-rule: exactly; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; background-color: #f7f8fa'><div><div class='center'><table align='center' border='0' cellpadding='0' cellspacing='0' width='100%' style='max-width: 600px; margin: 0 auto; background-color: #f7f8fa; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%'><tbody><tr><td class='desktop-block' align='left' valign='top' style='padding-top: 10px; padding-bottom: 0; mso-line-height-rule: exactly; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%'><table style='min-width: 100%; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%' border='0' cellpadding='0' cellspacing='0' width='100%'><tbody><tr></tr></tbody></table></td></tr><tr><td class='container-padding' align='center' valign='top' width='100%' style='padding: 0px; margin: 0px; background-color: #f7f8fa;'><table align='center' border='0' cellpadding='0' cellspacing='0' width='100%' style='max-width: 600px; background-color: #f7f8fa; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%'><tbody><tr><td align='left' valign='top' style='padding: 25px 0px; background-color: #f7f8fa;'><table style=min-width: 100%; border-collapse: collapse; mso-table-lspace: 0pt; max-width: 600px; mso-table-rspace: 0pt; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%' border='0' cellpadding='0' cellspacing='0' width='100%'><tbody><tr><td class='mob-padding-top-15' style='width: 40%; padding: 10px 0px 0px; background-color: #f7f8fa;' align='left'> </td><td style='line-height: 24px; padding-top: 27px; color: #000; vertical-align: bottom; padding-right: 0px; text-align: right; padding-bottom: 5px; font-size: 16px'align='right'></td></tr></tbody></table> </td></tr></tbody></table> </td></tr><tr><td align='center' valign='top'style='padding-top: 0; padding-bottom: 0; mso-line-height-rule: exactly; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; background-color: #fff'><table class='no-border-mob' align='center' border='0' cellpadding='0' cellspacing='0' width='100%' style='background-color: #fff; border-right: 1px solid #f7f8fa; border-left: 1px solid #f7f8fa; border-bottom: 1px solid #f7f8fa; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%'><tbody><tr><td align='center' valign='top' style='padding-top: 0; padding-bottom: 0; mso-line-height-rule: exactly; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; background-color: #fff'><table class='no-border-mob' align='center' border='0' cellpadding='0' cellspacing='0' width='100%' style='background-color: #fff; border-right: 1px solid #f7f8fa; border-left: 1px solid #f7f8fa; border-bottom: 1px solid #f7f8fa; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%'><tbody><tr><td class='desktop-block' align='left' valign='top' style='background-color: #fff; mso-line-height-rule: exactly; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%'><table style='border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%' border='0' cellpadding='0' cellspacing='0' width='100%'> <tbody><tr><td style='width: 100%; background-color: #fff; padding: 0' align='left'> <img src='http://static.cdn.responsys.net/i2/responsysimages/wix//contentlibrary/matrix-blocks/media/premium_notification_info-neutral_22062016_all_header_badge_desktop.png' width='670' style='display: block; width: 100%;'></td></tr></tbody></table> </td> </tr> <tr><td align='center' valign='top' width='100%' style='mso-line-height-rule: exactly; padding: 0; margin: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; background-color: #fff'><table align='center' border='0' cellpadding='0' cellspacing='0' width='100%' style='max-width: 600px; background-color: #fff; border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%'><tbody><tr> <td><table border='0' cellpadding='0' cellspacing='0' width='100%'><tbody><tr><td><table border='0' cellpadding='0' cellspacing='0' width='100%' class='mobile-block' style='mso-hide: all; display: table!important;'> <tbody><tr><td width='100%'><div class='mobile-block-holder' style='overflow: hidden; max-height: 0; max-width: 0; height: 0; width: 0'><div class='mobile-block' style='mso-line-height-rule: exactly; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; color: #fff; font-family: Arial, Helvetica, sans-serif; font-size: 16px; line-height: 24px; font-weight: bold; text-align: center' valign='top'><table class='no-border-mob' cellspacing='0' cellpadding='0' align='center' style='mso-hide: all; display: table; border-right: 1px solid #f7f8fa; border-left: 1px solid #f7f8fa; background-color: #fff; text-align: center; margin: 0 auto'><tbody><tr><td align='center' valign='top' style='padding-top: 0px; width: 100%; padding-bottom: 0px' width='100%'><img class='mobile-block' src='http://static.cdn.responsys.net/i2/responsysimages/wix//contentlibrary/matrix-blocks/media/premium_notification_info-neutral_22062016_all_header_badge_mobile_new.png' width='100%' alt='#' style='width: 100%; padding-bottom: 0px'></td></tr> </tbody></table></div></div></td></tr> </tbody></table></td></tr> </tbody></table> </td></tr></tbody></table></td></tr><tr><td align='center' valign='top' style='padding-right: 0px; padding-bottom: 0px; padding-left: 0px; mso-line-height-rule: exactly; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%'><table style='border-collapse: collapse; mso-table-lspace: 0pt; max-width: 570px; background-color: #fff; mso-table-rspace: 0pt; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%' border='0' cellpadding='0' cellspacing='0' width='100%'><tbody><tr><td class='container-padding' align='center' valign='top' style=''><div style='display: inline-block; max-width: 100%; vertical-align: top; width: 100%; max-width: 550px; padding-top: 0px;'><table align='center' border='0' cellpadding='0' cellspacing='0' width='100%' style='max-width: 550px;'><tbody><tr> <td class='mob-img-block-padding-top' style='background-color: #fff;padding: 0px 22px; mso-line-height-rule: exactly; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; color: #000; font-size: 24px; font-style: normal; font-weight: normal; line-height: 30px; letter-spacing: 0.7px; text-align: left;'><div style='padding-bottom: 0; text-align: center; font-weight: bold; font-size: 24px; letter-spacing: normal !important; color: #43515c' class='text-block-2'>"
        "$title</div> </td> </tr> <tr><td class='mob-img-ribbon-padd' align='center' valign='top' style='line-height: 1px; max-width: 600px; height: 1px; max-height: 1px; padding: 15px 10px 5px; width: 100%;' width='100%'> <img src='http://static.cdn.responsys.net/i2/responsysimages/wix//contentlibrary/matrix-blocks/marketing/dotted_line_22_09_2016_black_595x1_body_desktop.png' width='550' alt='#' style='width: 100%; line-height: 1px; height: 1px; max-height: 1px; display: block;' class='padding-zero'></td></tr><tr><td class='mob-img-block-padding-top mob-img-block-padding-bottom' style='font-weight: normal;padding: 0px 22px; font-size: 14px; line-height: 18px; color: #333; text-align: left; padding-top: 25px; padding-bottom:20px;' align='left'><span class='text-block' style='font-weight: normal; font-size: 14px; line-height: 18px;color:rgb(0,0,0)' >"
        "<div>$subtitle</div><br>$body<br><br>$title2</span></td> </tr><tr> <td class='mob-img-ribbon-padd' align='center' valign='top' style='line-height: 1px; max-width: 600px; height: 1px; max-height: 1px; padding: 15px 10px 15px; width: 100%;' width='100%'> <img src='http://static.cdn.responsys.net/i2/responsysimages/wix//contentlibrary/matrix-blocks/marketing/dotted_line_22_09_2016_black_595x1_body_desktop.png' width='550' alt='#' style='width: 100%; line-height: 1px; height: 1px; max-height: 1px; display: block;' class='padding-zero'>"
        "</td></tr><center>${Endpoints.appName}, ¡Gracias por hacer de México un lugar que promueve y fomenta el Deporte!</center><br>"
        "<center>"
        "<a href=\"https://sites.google.com/view/ligasfutbol/inicio\" "
        "target=\"_blank\" shape=\"rect\" style=\"color: #459fed; text-decoration: "
        "none\">visitanos en nuestra página oficial.</a>"
        "</center><tr><td class='container-padding' style='font-weight: normal; font-size: 11px; color: #858f96; padding-top: 5px;line-height: 20px; padding-bottom: 30px; padding-left:30px; text-align: center' align='center'><div><span class='text-block-footer' style='font-weight: normal'><span style='font-weight: bold'></span> <br class='mobile-block'><br><br></span></div></td></tr></tbody></table></div><!--[if gte mso 9></td> </tr> </table> <![endif]--></td></tr></tbody></table></td></tr></tbody></table> <!--[if gte mso 9> </td> </tr> </table> <![endif]--></td></tr></tbody></table></td> </tr></tbody></table> <!--[if gte mso 9></td></tr></table><![endif]--></div></div></td> </tr><tr><td align='center' valign='top' width='100%' style='mso-line-height-rule: exactly;padding: 0; margin: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; background-color: #f7f8fa;padding-top: 15px' class='disclaimer mobile-disclaimer'><span style='color: #18130F; display: none; font-size: 0; height: 0; line-height: 0;max-height: 0; max-width: 0; opacity: 0; overflow: hidden; visibility: hidden;width: 0'></span> <table align='center' border='0' cellpadding='0' cellspacing='0' width='100%' style='background-color: #f7f8fa;border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; -ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%'><tbody><tr><td align='left' valign='top' style='padding-top: 0; padding-right: 10px; padding-bottom: 0;padding-left: 10px; mso-line-height-rule: exactly; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%'><table style='min-width: 100%; border-collapse: collapse; mso-table-lspace: 0pt;mso-table-rspace: 0pt; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%' border='0' cellpadding='0' cellspacing='0' width='100%'><tbody><tr><td align='center' colspan='2' style='text-align: center'><div style='text-align: center; font-size: 10px; color: rgb(51, 51, 51); padding-bottom: 10px;border: 0; background-color: #f7f8fa' class='disclaimer'> <br><br><br></div></td></tr> </tbody> </table></td></tr></tbody></table> </td></tr></tbody></table></center> </div></body></html>";
  }
}
