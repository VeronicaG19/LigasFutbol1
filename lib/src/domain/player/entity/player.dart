import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ligas_futbol_flutter/src/domain/player/entity/player_image_profile.dart';
import 'package:ligas_futbol_flutter/src/domain/player/entity/position.dart';

part 'player.g.dart';

@JsonSerializable()
class Player extends Equatable {
  final DateTime? birthday;
  final int? partyId;
  final String? document;
  final String? emailAddress;
  final int? expensiveCost;
  final String? firstName;
  final String? lastName;
  final String? nickName;
  final String? nickNameFlag;
  final int? payToPlay;
  final int? paymentType;
  final String? phoneNumber;
  final String? playerAddress;
  final String? playerLatitude;
  final String? playerLenght;
  final int? playerid;
  @JsonKey(name: 'playerId')
  final int? idPlayer;
  final String? preferencePosition;
  final int? preferencePositionId;
  final String? situation;
  final int? situationId;
  final int? transferKm;
  final int? fileId;
  final PlayerPhotoId? playerPhotoId;

  const Player(
      {this.birthday,
      this.document,
      this.emailAddress,
      this.expensiveCost,
      this.firstName,
      this.lastName,
      this.nickName,
      this.nickNameFlag,
      this.payToPlay,
      this.paymentType,
      this.phoneNumber,
      this.playerAddress,
      this.playerLatitude,
      this.playerLenght,
      this.playerid,
      this.idPlayer,
      this.preferencePosition,
      this.preferencePositionId,
      this.situation,
      this.situationId,
      this.transferKm,
      this.fileId,
      this.playerPhotoId,
      this.partyId});
  bool get isEmpty => this == Player.empty;
  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  Player copyWith(
      {DateTime? birthday,
      String? document,
      String? emailAddress,
      int? expensiveCost,
      String? firstName,
      String? lastName,
      String? nickName,
      String? nickNameFlag,
      int? payToPlay,
      int? paymentType,
      String? phoneNumber,
      String? playerAddress,
      String? playerLatitude,
      String? playerLenght,
      int? playerid,
      int? idPlayer,
      String? preferencePosition,
      int? preferencePositionId,
      String? situation,
      int? situationId,
      int? transferKm,
      int? fileId,
      PlayerPhotoId? playerPhotoId,
      int? partyId}) {
    return Player(
        birthday: birthday ?? this.birthday,
        document: document ?? this.document,
        emailAddress: emailAddress ?? this.emailAddress,
        expensiveCost: expensiveCost ?? this.expensiveCost,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        nickName: nickName ?? this.nickName,
        nickNameFlag: nickNameFlag ?? this.nickNameFlag,
        payToPlay: payToPlay ?? this.payToPlay,
        paymentType: paymentType ?? this.paymentType,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        playerAddress: playerAddress ?? this.playerAddress,
        playerLatitude: playerLatitude ?? this.playerLatitude,
        playerLenght: playerLenght ?? this.playerLenght,
        playerid: playerid ?? this.playerid,
        idPlayer: idPlayer ?? this.idPlayer,
        preferencePosition: preferencePosition ?? this.preferencePosition,
        preferencePositionId: preferencePositionId ?? this.preferencePositionId,
        situation: situation ?? this.situation,
        situationId: situationId ?? this.situationId,
        transferKm: transferKm ?? this.transferKm,
        fileId: fileId ?? this.fileId,
        playerPhotoId: playerPhotoId ?? this.playerPhotoId,
        partyId: partyId ?? this.partyId);
  }

  static const empty = Player();

  String get getPreferencePosition => preferencePosition ?? '';

  String get getAgePlayer => _agePlayer();

  String get getPLayerName => firstName ?? '';

  Positions get getPos =>
      Positions(preferencePositionId: 1, preferencePosition: 'Portero');

  String _agePlayer() {
    final currentDate = DateTime.now();
    final currentYear = currentDate.year;
    final yearBirth = birthday?.year ?? currentYear;
    String playerAge;

    playerAge = (currentYear - yearBirth).toString();

    if (playerAge == '0') {
      return playerAge = '';
    }

    return '$playerAge' ' Años';
  }

  @override
  List<Object?> get props => [
        birthday,
        document,
        emailAddress,
        expensiveCost,
        firstName,
        lastName,
        nickName,
        nickNameFlag,
        payToPlay,
        paymentType,
        phoneNumber,
        playerAddress,
        playerLatitude,
        playerLenght,
        playerid,
        idPlayer,
        preferencePosition,
        preferencePositionId,
        situation,
        situationId,
        transferKm,
        fileId,
        playerPhotoId,
        partyId
      ];
  /**
   * To json para actualizar la entidad de player
   */
  Map<String, dynamic> toJsonUpdate() {
    final Map<String, dynamic> plyr = <String, dynamic>{};
    //plyr['camera'] = camera.toJson(),
    plyr['birthday'] = birthday?.toIso8601String();
    plyr['partyId'] = partyId;
    //plyr['emailAddress'] = emailAddress;
    plyr['expensiveCost'] = expensiveCost;
    //plyr['firstName'] = firstName;
    //plyr['lastName'] = lastName;
    plyr['nickname'] = nickName;
    plyr['nickNameFlag'] = nickNameFlag;
    plyr['payToPlay'] = payToPlay;
    plyr['paymentType'] = paymentType;
    //plyr['phoneNumber'] = phoneNumber;
    plyr['playersAddress'] = playerAddress;
    plyr['playersLatitude'] = playerLatitude;
    plyr['playersLength'] = playerLenght;
    plyr['playerId'] = idPlayer ?? playerid;
    plyr['preferencePosition'] = preferencePositionId;
    plyr['punished'] = null;
    plyr['zonePlayer'] = null;
    plyr['representantId'] = null;
    plyr['playerPhotoId'] = playerPhotoId?.toJson();
    plyr['situation'] = situationId;
    plyr['transferKm'] = transferKm;
    return plyr;
  }
/**
 *
    "playerPhotoId": {
    "approveResource": "string",
    "auxId": 0,
    "document": "string",
    "fileId": 0,
    "fileName": "string",
    "fileType": "IMAGE",
    "mimetype": "string"
    }
 */
}
