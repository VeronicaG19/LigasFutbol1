import 'package:user_repository/user_repository.dart';

import '../models/verification_code.dart';
import '../typedefs.dart';

abstract class AuthenticationInterface {
  Stream<String> get sessionStream;
  //OauthJWT get getCurrentSession;
  String get getPreferredLanguage;
  //bool get getInitialAdviceStatus;
  Future<void> savePreferredLanguage(String language);
  //Future<void> saveInitialAdviceStatus();
  RepoResponse<String> loginWithNameAndPassword(
      {required String name, required String password});
  RepoResponse<void> autoLogin();
  RepoResponse<User> signUp(User user);
  RepoResponse<User> createLFUserAndAssignRoles(User user);
  RepoResponse<VerificationCode> submitVerificationCode(String receiver);
  RepoResponse<VerificationCode> resentVerificationCode(
      String receiver, bool isForUpdate);
  RepoResponse<VerificationCode> submitCodeConfirmation(String input);
  RepoResponse<VerificationCode> sendVerificationCodeForDataUpdate(
      String receiver, bool isChangingUser);
  RepoResponse<VerificationCode> submitVerificationCodeForDataUpdate(
      String code, String type);

  void clearUpdateRequest(String type);

  /// email or phone
  VerificationCode getCacheCodeForUpdate(String type);
  RepoResponse<String> recoverPassword(String input);
  void logOut();
  //Future<void> updateSessionData({required String userName, required String password});
  void dispose();
}
