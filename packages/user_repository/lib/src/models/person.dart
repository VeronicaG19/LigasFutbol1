import 'package:equatable/equatable.dart';

class Person extends Equatable {
  /// {@macro Person}
  const Person({
    this.personId,
    required this.firstName,
    required this.lastName,
    this.personType,
    this.acronym,
    this.gender,
    this.positionCode,
    this.areaCode,
    this.executiveTitle,
    this.photo,
    required this.entityEmailAddress,
    required this.entityPhoneNumbers,
  });

  factory Person.buildPerson({
    required String firstName,
    required String lastName,
    String? email,
    String? phone,
    String? areaCode,
  }) {
    final emailModel = email == null ? Email.empty : Email(emailAddress: email);
    final phoneNumber = phone?.substring(2, 10) ?? '';
    final phoneAreaCode = phone?.substring(0, 2) ?? '';
    final phoneModel = phone == null
        ? PhoneNumber.empty
        : PhoneNumber(
            areaCode: phoneAreaCode,
            phoneNumber: phoneNumber,
            countryCode: '52');
    final entityEmail = EntityEmailAddress(email: emailModel);
    final entityPhoneNumber = EntityPhoneNumber(phoneNumber: phoneModel);
    final List<EntityEmailAddress> entityEmailList =
        emailModel.isNotEmpty ? [entityEmail] : [];
    final List<EntityPhoneNumber> entityPhoneNumberList =
        phoneModel.isNotEmpty ? [entityPhoneNumber] : [];
    return Person(
      firstName: firstName,
      lastName: lastName,
      personType: 'PERSON',
      acronym: _getAcronym(firstName, lastName),
      areaCode: areaCode,
      entityEmailAddress: entityEmailList,
      entityPhoneNumbers: entityPhoneNumberList,
    );
  }

  Person copyWith({
    int? personId,
    String? firstName,
    String? lastName,
    String? personType,
    String? acronym,
    String? gender,
    String? positionCode,
    String? areaCode,
    String? executiveTitle,
    String? photo,
    List<EntityEmailAddress>? entityEmailAddress,
    List<EntityPhoneNumber>? entityPhoneNumbers,
  }) {
    return Person(
      personId: personId ?? this.personId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      personType: personType ?? this.personType,
      acronym: acronym ?? this.acronym,
      gender: gender ?? this.gender,
      positionCode: positionCode ?? this.positionCode,
      areaCode: areaCode ?? this.areaCode,
      executiveTitle: executiveTitle ?? this.executiveTitle,
      photo: photo ?? this.photo,
      entityEmailAddress: entityEmailAddress ?? this.entityEmailAddress,
      entityPhoneNumbers: entityPhoneNumbers ?? this.entityPhoneNumbers,
    );
  }

  /// Convert a JSON object into a [Person] Entity
  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      personId: json['partyId'] ?? json['personId'] as int,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      personType: json['personType']?.toString(),
      acronym: json['acronym']?.toString(),
      gender: json['gender']?.toString(),
      positionCode: json['positionCode']?.toString(),
      areaCode: json['areaCode']?.toString(),
      executiveTitle: json['executiveTitle']?.toString(),
      photo: json['photo']?.toString(),
      entityEmailAddress: _validateEmailList(json),
      entityPhoneNumbers: _validatePhoneList(json),
    );
  }

  /// The person identifier.
  final int? personId;

  /// The person first name.
  final String firstName;

  /// The person last name.
  final String lastName;

  /// The person type.
  final String? personType;

  /// An acronym to identify the person composed with the first chars of the full name.
  final String? acronym;

  /// The person gender.
  final String? gender;

  /// The position code int the organization.
  final String? positionCode;

  /// The area code in which the person is associated.
  final String? areaCode;

  /// Executive title inside the organization.
  final String? executiveTitle;

  /// Photo of the person.
  final String? photo;

  /// List of emails
  final List<EntityEmailAddress> entityEmailAddress;

  /// List of phones
  final List<EntityPhoneNumber> entityPhoneNumbers;

  /// Empty Person which represents the user hasn't registered personal
  /// information or didn't find information.
  static const empty = Person(
    firstName: '',
    lastName: '',
    entityEmailAddress: [EntityEmailAddress.empty],
    entityPhoneNumbers: [EntityPhoneNumber.empty],
  );

  /// Convenience getter to determine whether the current Person is empty.
  bool get isEmpty => this == Person.empty;

  /// Convenience getter to determine whether the current Person is not empty.
  bool get isNotEmpty => this != Person.empty;

  @override
  List<Object?> get props => [
        personId,
        firstName,
        lastName,
        personType,
        photo,
        entityEmailAddress,
        entityPhoneNumbers,
      ];

  /// Validates the [EntityEmailAddress] in the JSON object. If it's null
  /// returns an [EntityEmailAddress.empty], if not returns the [EntityEmailAddress]
  /// list.
  static List<EntityEmailAddress> _validateEmailList(
      Map<String, dynamic> json) {
    final emailList = json['entityEmailAddress'] == null
        ? <EntityEmailAddress>[]
        : json['entityEmailAddress'] as List;
    return emailList.isEmpty
        ? [EntityEmailAddress.empty]
        : [
            ...emailList.map(
              (e) => EntityEmailAddress.fromJson(e),
            ),
          ];
  }

  /// Validates the [EntityPhoneNumber] in the JSON object. If it's null
  /// returns an [EntityPhoneNumber.empty], if not returns the [EntityPhoneNumber]
  /// list.
  static List<EntityPhoneNumber> _validatePhoneList(Map<String, dynamic> json) {
    final phoneList = json['entityPhoneNumber'] == null
        ? <EntityPhoneNumber>[]
        : json['entityPhoneNumber'] as List;
    return phoneList.isEmpty
        ? [EntityPhoneNumber.empty]
        : [
            ...phoneList.map<EntityPhoneNumber>(
              (e) => EntityPhoneNumber.fromJson(e as Map<String, dynamic>),
            )
          ];
  }

  /// Convert a [Person] entity to JSON object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'partyId': personId,
      'firstName': firstName,
      'lastName': lastName,
      'personType': personType,
      'acronym': acronym,
      'gender': gender,
      'positionCode': positionCode,
      'areaCode': areaCode,
      'executiveTitle': executiveTitle,
      'photo': photo,
      'entityEmailAddress': entityEmailAddress.map((e) => e.toJson()).toList(),
      'entityPhoneNumber': entityPhoneNumbers.map((e) => e.toJson()).toList(),
    };
  }

  String get getMainEmail => _validateMainMail();

  String get getFormattedMainPhone => _validateMainPhone();

  String get getUnformattedMainPhone => _validateUnformattedMainPhone();

  String get getMainPhoneWhitCountryCode => _validateMainPhoneWithCountryCode();

  /// returns the main person email
  String _validateMainMail() {
    if (entityEmailAddress.isEmpty) {
      return EntityEmailAddress.empty.email.emailAddress;
    }

    return entityEmailAddress.first.getEmail().trim();
  }

  /// returns the main person formatted phone number
  String _validateMainPhone() {
    if (entityPhoneNumbers.isEmpty) {
      return EntityPhoneNumber.empty.phoneNumber.phoneNumber;
    }

    return entityPhoneNumbers.first.getPhoneNumber;
  }

  /// Validates the main person unformatted phone number
  String _validateUnformattedMainPhone() {
    if (entityPhoneNumbers.isEmpty) {
      return EntityPhoneNumber.empty.phoneNumber.phoneNumber;
    }

    return entityPhoneNumbers.first.getUnformattedPhoneNumber;
  }

  /// returns the main person phone number with country code
  String _validateMainPhoneWithCountryCode() {
    if (entityPhoneNumbers.isEmpty) {
      return EntityPhoneNumber.empty.phoneNumber.phoneNumber;
    }

    return entityPhoneNumbers.first.getPhoneNumberWithCountryCode;
  }

  /// Returns the person full name [firstName] [lastName]
  String get getFullName =>
      isEmpty ? '' : '${firstName.trim()} ${lastName.trim()}';

  static String _getAcronym(String firstName, String lastName) {
    final String acronym =
        firstName.trim().substring(0, 1) + lastName.trim().substring(0, 1);
    return acronym.toUpperCase();
  }
}

/// {@template authentication_repository}
/// EntityEmailAddress.
/// {@endtemplate}
class EntityEmailAddress extends Equatable {
  /// {@macro EntityEmailAddress}
  const EntityEmailAddress({
    this.partyEmailAddressId,
    this.entityType,
    required this.email,
    this.primaryFlag,
  });

  /// Convert a JSON object into a [EntityEmailAddress] Entity.
  factory EntityEmailAddress.fromJson(Map<String, dynamic> json) {
    return EntityEmailAddress(
      partyEmailAddressId: json['partyEmailAddressId'] as int,
      entityType: json['entityType'].toString(),
      email: json['email'] != null
          ? Email.fromJson(json['email'] as Map<String, dynamic>)
          : Email.empty,
      primaryFlag: json['primaryFlag'].toString(),
    );
  }

  /// Identifier to represent one of the user's email entity.
  final int? partyEmailAddressId;

  /// /// The entity type could be PERSON or any other type.
  final String? entityType;

  /// The email entity whit email data
  final Email email;

  /// Represents the main email that the user has registered if many.
  final String? primaryFlag;

  /// Empty EntityEmailAddress which represents the user hasn't any email associated.
  static const empty = EntityEmailAddress(
    email: Email.empty,
  );

  @override
  List<Object?> get props =>
      [partyEmailAddressId, entityType, email, primaryFlag];

  /// Convert a [EntityEmailAddress] entity to JSON object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'partyEmailAddressId': partyEmailAddressId,
      'entityType': entityType ?? 'PERSON',
      'email': email.toJson(),
      'primaryFlag': primaryFlag,
    };
  }

  /// Returns the email address if found. If there is no email returns a hyphen.
  String getEmail() {
    return email.isNotEmpty ? email.emailAddress : '';
  }

  EntityEmailAddress copyWith({
    int? partyEmailAddressId,
    String? entityType,
    Email? email,
    String? primaryFlag,
  }) {
    return EntityEmailAddress(
      partyEmailAddressId: partyEmailAddressId ?? this.partyEmailAddressId,
      entityType: entityType ?? this.entityType,
      email: email ?? this.email,
      primaryFlag: primaryFlag ?? this.primaryFlag,
    );
  }
}

/// {@template authentication_repository}
/// Email related information.
/// {@endtemplate}
class Email extends Equatable {
  /// {@macro Email}
  const Email({
    this.emailId,
    required this.emailAddress,
    this.emailType,
    this.globalFlag,
  });

  /// Convert a JSON object into a [Email] Entity.
  factory Email.fromJson(Map<String, dynamic> json) {
    return Email(
      emailId: json['emailId'] as int,
      emailAddress: json['emailAddress'] ?? '',
      emailType: json['emailType'].toString(),
      globalFlag: json['globalFlag'],
    );
  }

  /// Email identifier.
  final int? emailId;

  /// The email address.
  final String emailAddress;

  /// Represents which type is the email.
  final String? emailType;

  /// Represents the status of the email for the user.
  final String? globalFlag;

  /// Empty Email which represents the user hasn't any email registered.
  static const empty = Email(emailAddress: '');

  /// Convenience getter to determine whether the current PhoneNumber is empty.
  bool get isEmpty => this == Email.empty;

  /// Convenience getter to determine whether the current PhoneNumber is not empty.
  bool get isNotEmpty => this != Email.empty;

  @override
  List<Object?> get props => [emailId, emailAddress, emailType, globalFlag];

  /// Convert a [Email] entity to JSON object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'emailId': emailId,
      'emailAddress': emailAddress,
      'emailType': emailType ?? 'PERSON',
      'globalFlag': globalFlag,
    };
  }

  Email copyWith({
    int? emailId,
    String? emailAddress,
    String? emailType,
    String? globalFlag,
  }) {
    return Email(
      emailId: emailId ?? this.emailId,
      emailAddress: emailAddress ?? this.emailAddress,
      emailType: emailType ?? this.emailType,
      globalFlag: globalFlag ?? this.globalFlag,
    );
  }
}

/// {@template authentication_repository}
/// EntityPhoneNumber object.
/// {@endtemplate}
class EntityPhoneNumber extends Equatable {
  /// {@macro EntityPhoneNumber}
  const EntityPhoneNumber({
    this.partyPhoneNumberId,
    required this.phoneNumber,
    this.entityType,
    this.primaryFlag,
  });

  /// Convert a JSON object into an [EntityPhoneNumber] Entity.
  factory EntityPhoneNumber.fromJson(Map<String, dynamic> json) {
    return EntityPhoneNumber(
      partyPhoneNumberId: json['partyPhoneNumberId'] as int,
      entityType: json['entityType'].toString(),
      phoneNumber: json['phoneNumber'] == null
          ? PhoneNumber.empty
          : PhoneNumber.fromJson(json['phoneNumber'] as Map<String, dynamic>),
      primaryFlag: json['primaryFlag'].toString(),
    );
  }

  /// Identifier to represent one of the user's phone entity.
  final int? partyPhoneNumberId;

  /// The phone number entity that belongs to this entity.
  final PhoneNumber phoneNumber;

  /// The entity type could be PERSON or any other type.
  final String? entityType;

  /// Represents the main phone that the user has registered if many.
  final String? primaryFlag;

  /// Empty EntityPhoneNumber which represents user hasn't any phone associated.
  static const empty = EntityPhoneNumber(
    phoneNumber: PhoneNumber.empty,
  );

  /// Convenience getter to determine whether the current EntityPhoneNumber is empty.
  bool get isEmpty => this == EntityPhoneNumber.empty;

  /// Convenience getter to determine whether the current EntityPhoneNumber is not empty.
  bool get isNotEmpty => this != EntityPhoneNumber.empty;

  @override
  List<Object?> get props =>
      [partyPhoneNumberId, phoneNumber, entityType, primaryFlag];

  /// Convert a [EntityPhoneNumber] entity to JSON object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'partyPhoneNumberId': partyPhoneNumberId,
      'entityType': entityType ?? 'PERSON',
      'phoneNumber': phoneNumber.toJson(),
      'primaryFlag': primaryFlag,
    };
  }

  String get getPhoneNumber => _validatePhoneNumber();

  String get getUnformattedPhoneNumber => _validateUnformattedPhoneNumber();

  /// Returns the formatted 10 digits phone number as a String.
  /// If there is no phone number returns a hyphen.
  String _validatePhoneNumber() {
    return phoneNumber.isNotEmpty
        ? '${phoneNumber.areaCode} ${phoneNumber.phoneNumber.replaceAllMapped(RegExp(r'(.{4})'), (match) => '${match.group(0)} ')}'
            .trim()
        : '';
  }

  String _validateUnformattedPhoneNumber() {
    return phoneNumber.isNotEmpty
        ? '${phoneNumber.areaCode}${phoneNumber.phoneNumber}'.trim()
        : '';
  }

  String get getPhoneNumberWithCountryCode =>
      _validatePhoneNumberWithCountryCode();

  /// Returns the full formatted phone number as a String.
  /// If there is no phone number returns a hyphen.
  String _validatePhoneNumberWithCountryCode() {
    return phoneNumber.isNotEmpty
        ? '+${phoneNumber.countryCode} $getPhoneNumber'
        : '';
  }

  EntityPhoneNumber copyWith({
    int? partyPhoneNumberId,
    PhoneNumber? phoneNumber,
    String? entityType,
    String? primaryFlag,
  }) {
    return EntityPhoneNumber(
      partyPhoneNumberId: partyPhoneNumberId ?? this.partyPhoneNumberId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      entityType: entityType ?? this.entityType,
      primaryFlag: primaryFlag ?? this.primaryFlag,
    );
  }
}

/// {@template authentication_repository}
/// Entity for PhoneNumber.
/// {@endtemplate}
class PhoneNumber extends Equatable {
  /// {@macro PhoneNumber}
  const PhoneNumber({
    this.phoneNumberId,
    required this.areaCode,
    required this.phoneNumber,
    this.phoneType,
    this.countryCode,
    this.globalFlag,
  });

  /// Convert a JSON object into a [PhoneNumber] Entity.
  factory PhoneNumber.fromJson(Map<String, dynamic> json) {
    return PhoneNumber(
      phoneNumberId: json['phoneNumberId'] as int,
      phoneNumber: json['phoneNumber'] ?? '',
      phoneType: json['phoneType'].toString(),
      countryCode: json['countryCode'].toString(),
      areaCode: json['areaCode'] ?? '',
      globalFlag: json['globalFlag'],
    );
  }

  /// Phone number identifier.
  final int? phoneNumberId;

  /// local phone area code.
  final String areaCode;

  /// The phone number.
  final String phoneNumber;

  /// Represents the phone number type.
  final String? phoneType;

  /// The phone country code.
  final String? countryCode;

  /// Represents the status of the phone number for the user.
  final String? globalFlag;

  /// Empty PhoneNumber which represents user hasn't any phone registered.
  static const empty = PhoneNumber(areaCode: '', phoneNumber: '');

  /// Convenience getter to determine whether the current PhoneNumber is empty.
  bool get isEmpty => this == PhoneNumber.empty;

  /// Convenience getter to determine whether the current PhoneNumber is not empty.
  bool get isNotEmpty => this != PhoneNumber.empty;

  @override
  List<Object?> get props => [
        phoneNumberId,
        countryCode,
        areaCode,
        phoneNumber,
        phoneType,
        globalFlag
      ];

  /// Convert a [PhoneNumber] entity to JSON object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'phoneNumberId': phoneNumberId,
      'phoneNumber': phoneNumber,
      'phoneType': 'PERSON',
      'countryCode': countryCode,
      'areaCode': areaCode,
      'globalFlag': globalFlag,
    };
  }

  PhoneNumber copyWith({
    int? phoneNumberId,
    String? areaCode,
    String? phoneNumber,
    String? phoneType,
    String? countryCode,
    String? globalFlag,
  }) {
    return PhoneNumber(
      phoneNumberId: phoneNumberId ?? this.phoneNumberId,
      areaCode: areaCode ?? this.areaCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneType: phoneType ?? this.phoneType,
      countryCode: countryCode ?? this.countryCode,
      globalFlag: globalFlag ?? this.globalFlag,
    );
  }
}
