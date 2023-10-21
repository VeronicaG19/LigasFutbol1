import 'package:dartz/dartz.dart';
import 'package:datasource_client/datasource_client.dart';

import '../endpoints.dart';
import '../exceptions/user_exception.dart';
import '../exceptions/user_failure.dart';
import '../models/person.dart';
import '../models/user.dart';
import '../typedef.dart';
import 'user_interface.dart';

class UserRepository implements UserInterface {
  final ApiClient _client;
  late User _userData;
  UserRepository(this._client,
      {required String personBase, required String appName})
      : super() {
    Endpoints.init(personBase, appName);
  }

  @override
  RepoResponse<Person> getPersonDataByPersonId(int personId,
      {bool requiresAuthToken = true}) {
    return Task(() => _client.network.getData(
        requiresAuthToken: requiresAuthToken,
        endpoint: Endpoints.getPersonDataByIdURL(personId),
        converter: Person.fromJson))._validateResponse();
  }

  @override
  RepoResponse<Person> getPersonDataByUserName(String userName) async {
    return Task(() => _client.network.getData(
        endpoint: Endpoints.getPersonDataByUserNameURL,
        queryParams: {'userName': userName},
        converter: Person.fromJson))._validateResponse();
  }

  @override
  RepoResponse<User> getUserDataByUserName({String? userName}) async {
    final name = userName ?? await _client.localStorage.getAuthUserName();
    final response = await Task(() => _getUserData(name))._validateResponse();
    _userData = response.fold((l) => User.empty, (r) => r);
    return response;
  }

  Future<User> _getUserData(String userName) async {
    final userRequest = await _client.network.getData(
        endpoint: Endpoints.getUserDataByUserNameURL(userName),
        converter: User.fromJson);
    final personRequest = await _client.network.getData(
        endpoint: Endpoints.getPersonDataByIdURL(userRequest.person.personId!),
        converter: Person.fromJson);
    return userRequest.copyWith(person: personRequest);
  }

  @override
  RepoResponse<User> changeEmail(
      String email, User user, bool isChangingUser) async {
    return Task(() => _updateEmailAddress(email, user, isChangingUser))
        ._validateResponse();
  }

  @override
  RepoResponse<User> changePersonName(
      String firstName, String lastName, User user) {
    return Task(() => _updatePersonName(firstName, lastName, user))
        ._validateResponse();
  }

  @override
  RepoResponse<User> changePhone(String phone, User user, bool isChangingUser) {
    return Task(() => _updatePhoneNumber(phone, user, isChangingUser))
        ._validateResponse();
  }

  @override
  RepoResponse<User> changeUserName(String userName, User user) {
    return Task(() => _updateUserName(userName, user))._validateResponse();
  }

  Future<User> _updateEmailAddress(
      String email, User user, bool isChangingUser) async {
    final validateEmail = await _client.network.getData(
        endpoint: '${Endpoints.validateEmailURL}/$email',
        converter: (response) => response['result'] as String == 'true');
    if (validateEmail) {
      throw UserException.fromCode(UserExceptionType.emailExists);
    }
    Email emailEntity;
    EntityEmailAddress entityEmailAddress;
    if (user.person.entityEmailAddress.isNotEmpty) {
      emailEntity = user.person.entityEmailAddress.first.email.copyWith(
        emailAddress: email,
      );
      entityEmailAddress =
          user.person.entityEmailAddress.first.copyWith(email: emailEntity);
    } else {
      emailEntity = Email(emailAddress: email, emailType: 'PERSON');
      entityEmailAddress = EntityEmailAddress(
          email: emailEntity, entityType: 'PERSON', primaryFlag: 'Y');
    }
    final person =
        user.person.copyWith(entityEmailAddress: [entityEmailAddress]);
    if (isChangingUser) {
      user = await _client.network.updateData(
          endpoint: Endpoints.updateUserNameURL,
          data: user.copyWith(userName: email).toJson(),
          converter: User.fromJson);
    }

    final request = user.copyWith(
      person: await _client.network.updateData(
          endpoint: Endpoints.updatePartyURL,
          data: person.toJson(),
          converter: Person.fromJson),
    );
    return request;
  }

  Future<User> _updatePhoneNumber(
      String phone, User user, bool isChangingUser) async {
    final phoneList = await _client.network.getCollectionData(
        endpoint: '${Endpoints.validatePhoneURL}/$phone',
        converter: PhoneNumber.fromJson);
    if (phoneList.isNotEmpty) {
      throw UserException.fromCode(UserExceptionType.phoneExists);
    }
    PhoneNumber phoneNumber;
    EntityPhoneNumber entityPhoneNumber;
    if (user.person.entityPhoneNumbers.isNotEmpty) {
      phoneNumber = user.person.entityPhoneNumbers.first.phoneNumber.copyWith(
          phoneNumber: phone.substring(2, 10), areaCode: phone.substring(0, 2));

      entityPhoneNumber = user.person.entityPhoneNumbers.first
          .copyWith(phoneNumber: phoneNumber);
    } else {
      phoneNumber = PhoneNumber(
          areaCode: phone.substring(0, 2),
          phoneNumber: phone.substring(2, 10),
          countryCode: 'MX');
      entityPhoneNumber = EntityPhoneNumber(
          phoneNumber: phoneNumber, entityType: 'PERSON', primaryFlag: 'Y');
    }
    final person =
        user.person.copyWith(entityPhoneNumbers: [entityPhoneNumber]);
    if (isChangingUser) {
      user = await _client.network.updateData(
          endpoint: Endpoints.updateUserNameURL,
          data: user.copyWith(userName: phone).toJson(),
          converter: User.fromJson);
    }
    final request = user.copyWith(
      person: await _client.network.updateData(
          endpoint: Endpoints.updatePartyURL,
          data: person.toJson(),
          converter: Person.fromJson),
    );
    return request;
  }

  Future<User> _updateUserName(String userName, User user) async {
    final validateName = await _client.network.getData(
        endpoint: '${Endpoints.validateUserNameURL}/$userName',
        converter: (response) => response['result'] as String == 'true');
    if (validateName) {
      throw UserException.fromCode(UserExceptionType.userNameExists);
    }
    final request = await _client.network.updateData(
        endpoint: Endpoints.updateUserURL,
        data: user.copyWith(userName: userName).toJson(),
        converter: User.fromJson);
    return request;
  }

  Future<User> _updatePassword(String password, User user) async {
    final request = await _client.network.updateData(
        endpoint: Endpoints.updateUserURL,
        data: user.copyWith(password: password).toJson(),
        converter: User.fromJson);
    _client.localStorage.setAuthPassword(password);
    return request;
  }

  Future<User> _updatePersonName(
      String firstName, String lastName, User user) async {
    final eea =
        user.person.entityEmailAddress.first.email.copyWith(globalFlag: null);
    final pn = user.person.entityPhoneNumbers.first.phoneNumber
        .copyWith(countryCode: '', globalFlag: null);
    final epn = user.person.entityPhoneNumbers.first
        .copyWith(phoneNumber: pn, primaryFlag: 'Y');
    final person = user.person.copyWith(
        firstName: firstName,
        lastName: lastName,
        entityEmailAddress: [
          user.person.entityEmailAddress.first
              .copyWith(primaryFlag: 'Y', email: eea)
        ],
        entityPhoneNumbers: [
          epn
        ]);
    final request = user.copyWith(
      person: await _client.network.updateData(
          endpoint: Endpoints.updatePartyURL,
          data: person.toJson(),
          converter: Person.fromJson),
    );
    return request;
  }

  @override
  RepoResponse<User> changePassword(String password, User user) {
    return Task(() => _updatePassword(password, user))._validateResponse();
  }

  @override
  Future<String> getPassword() async {
    final password = await _client.localStorage.getAuthPassword();
    return password;
  }

  @override
  RepoResponse<User> updatePersonData(User user) {
    return Task(() => _updatePersonData(user))._validateResponse();
  }

  Future<User> _updatePersonData(User user) async {
    final eea =
        user.person.entityEmailAddress.first.email.copyWith(globalFlag: null);
    final pn = user.person.entityPhoneNumbers.first.phoneNumber
        .copyWith(countryCode: '', globalFlag: null);
    final epn = user.person.entityPhoneNumbers.first
        .copyWith(phoneNumber: pn, primaryFlag: 'Y');
    final person = user.person.copyWith(entityEmailAddress: [
      user.person.entityEmailAddress.first
          .copyWith(primaryFlag: 'Y', email: eea)
    ], entityPhoneNumbers: [
      epn
    ]);
    final request = user.copyWith(
      person: await _client.network.updateData(
          endpoint: Endpoints.updatePartyURL,
          data: person.toJson(),
          converter: Person.fromJson),
    );
    return request;
  }

  @override
  User get getUser => _userData;
}

extension _UserResponse<T> on Task<T> {
  RepoResponse<T> _validateResponse() {
    return attempt()
        .map(
          (either) => either.leftMap(
            (l) {
              if (l is UserException) {
                return UserFailure(code: l.name, message: l.message);
              } else if (l is NetworkException) {
                return UserFailure(code: l.name, message: l.message);
              } else {
                return UserFailure(code: 'UnknownError', message: l.toString());
              }
            },
          ),
        )
        .run();
  }
}
