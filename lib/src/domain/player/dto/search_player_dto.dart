import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_player_dto.g.dart';

@JsonSerializable()
class SearchPlayerDTO extends Equatable {
  final String? addres;
  final int? age;
  final DateTime? birthday;
  final String? namePlayer;
  final int? partyId;
  final int? payToPlay;
  final int? playerId;
  final String? playerPhoto;
  final String? preferencePosition;

  const  SearchPlayerDTO({
    this.addres,
    this.age,
    this.birthday,
    this.namePlayer,
    this.partyId,
    this.payToPlay,
    this.playerId,
    this.playerPhoto,
    this.preferencePosition
});

  factory SearchPlayerDTO.fromJson(Map<String, dynamic> json) =>
      _$SearchPlayerDTOFromJson(json);

  static const empty = SearchPlayerDTO();

  bool get isEmpty => this == SearchPlayerDTO.empty;

  bool get isNotEmpty => this != SearchPlayerDTO.empty;

  Map<String, dynamic> toJson() =>
      <String, dynamic>{
    "addres":addres,
        "age":age,
        "birthday":birthday,
        "namePlayer":namePlayer,
        "partyId":partyId,
        "payToPlay":payToPlay,
        "playerId":playerId,
        "playerPhoto":playerPhoto,
        "preferencePosition":preferencePosition
      };

  SearchPlayerDTO copyWith({
    String? addres,
    int? age,
    DateTime? birthday,
    int? partyId,
    int? payToPlay,
    int? playerId,
    String? playerPhoto,
    String? preferencePosition
  }) {
    return SearchPlayerDTO(
      addres: addres?? this.addres,
      age: age?? this.age,
      birthday: birthday?? this.birthday,
      partyId: partyId ?? this.partyId,
      payToPlay: payToPlay?? this.payToPlay,
      playerId: playerId ?? this.playerId,
      playerPhoto: playerPhoto?? this.playerPhoto,
      preferencePosition: preferencePosition?? this.preferencePosition
    );
  }

  @override
  List<Object?> get props =>
      [addres, age, birthday, partyId, payToPlay, playerId, playerPhoto, preferencePosition];

}