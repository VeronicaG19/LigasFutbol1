import 'dart:convert';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:hex/hex.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/digests/sha512.dart';

import 'person.dart';

enum ApplicationRol {
  unknown,
  player,
  leagueManager,
  superAdmin,
  referee,
  refereeManager,
  teamManager,
  fieldOwner
}

class User extends Equatable {
  final int? id;
  final String userName;
  final String password;
  final Person person;
  final ApplicationRol applicationRol;

  const User({
    this.id,
    required this.userName,
    required this.password,
    required this.person,
    required this.applicationRol,
  });

  User copyWith({
    int? id,
    String? userName,
    String? password,
    Person? person,
    ApplicationRol? applicationRol,
  }) {
    return User(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      person: person ?? this.person,
      applicationRol: applicationRol ?? this.applicationRol,
    );
  }

  static const empty = User(
      userName: '',
      password: '',
      person: Person.empty,
      applicationRol: ApplicationRol.player);

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [id, userName, password, person, applicationRol];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['userId'],
        password: json['password'],
        userName: json['userName'],
        person: Person.fromJson(json),
        applicationRol: ApplicationRol.player);
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': id,
      'personId': person.personId,
      'password': _cryptPassword(password),
      'userName': userName,
      'person': person.toJson(),
    };
  }

  Map<String, dynamic> toJsonForRegistration() {
    return {
      'party': person.toJson(),
      'password': _cryptPassword(password),
      'user': userName,
      'lastName': person.lastName,
      'firstName': person.firstName,
    };
  }

  String _cryptPassword(String password) {
    final Digest sha512 = SHA512Digest();
    final passwordUtf8 = utf8.encode(password);
    final passwordBase64 = base64.encode(passwordUtf8);
    final Uint8List passwordBase64ToUtf8 =
        utf8.encode(passwordBase64) as Uint8List;
    final sha512result = sha512.process(passwordBase64ToUtf8);
    final result = HEX.encode(sha512result);
    return result;
  }

  ApplicationRol defineApplicationRolFromToken(String token) {
    final decodedToken = JwtDecoder.decode(token);
    final authorities = decodedToken['authorities'] == null
        ? []
        : decodedToken['authorities'] as List;
    if (authorities.isNotEmpty) {
      final applicationRol = authorities.first;
      return applicationRol == 'REFEREE'
          ? ApplicationRol.referee
          : ApplicationRol.player;
    } else {
      return ApplicationRol.player;
    }
  }

  String get getCurrentRol => _getRol();

  String _getRol() {
    switch (applicationRol) {
      case ApplicationRol.player:
        return 'Jugador';
      case ApplicationRol.leagueManager:
        return 'Presidente de liga';
      case ApplicationRol.referee:
        return 'Árbitro';
      case ApplicationRol.superAdmin:
        return 'Administrador';
      case ApplicationRol.teamManager:
        return 'Representante de equipo';
      case ApplicationRol.refereeManager:
        return 'Gerente de árbitros';
      case ApplicationRol.fieldOwner:
        return 'Dueño de campo';
      default:
        return '';
    }
  }

  @override
  String toString() {
    return 'User{id: $id, userName: $userName, password: $password, applicationRol: $applicationRol, personId: ${person.personId}';
  }
}
