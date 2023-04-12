import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ligas_futbol_flutter/src/domain/category/entity/category.dart';
import 'package:ligas_futbol_flutter/src/domain/leagues/entity/league.dart';
import 'package:ligas_futbol_flutter/src/domain/resource_file/entity/resource_file.dart';

part 'team.g.dart';

@JsonSerializable()
class Team extends Equatable {
  final int? teamId;
  final String? teamName;
  final String? fieldFlag;
  final int? fieldId;
  final String? joinRequestAllowed;
  final int? approved;
  final String? commentsRequest;

  final String? requestPlayers;
  final int? firstManager;
  final int? secondManager;
  final String? payThePlayers;
  final Category? categoryId;
  final League? leagueIdAux;
  final League? leagueId;

  final ResourceFile? logoId;
  final ResourceFile? teamPhotoId;

  const Team({
    this.teamId,
    this.teamName,
    this.fieldFlag,
    this.fieldId,
    this.joinRequestAllowed,
    this.approved,
    this.commentsRequest,
    this.requestPlayers,
    this.firstManager,
    this.secondManager,
    this.payThePlayers,
    this.categoryId,
    this.leagueIdAux,
    this.leagueId,
    this.logoId,
    this.teamPhotoId,
  });

  /// Connect the generated [_$TeamFromJson] function to the `fromJson`
  /// factory.
  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  /// Connect the generated [_$TeamToJson] function to the `toJson` method.
  //Map<String, dynamic> toJson() => _$TeamToJson(this);

  static const empty = Team();

  bool get isEmpty => this == Team.empty;

  bool get isNotEmpty => this != Team.empty;

  Team copyWith({
    int? teamId,
    String? teamName,
    String? fieldFlag,
    int? fieldId,
    String? joinRequestAllowed,
    int? approved,
    String? commentsRequest,
    String? requestPlayers,
    int? firstManager,
    int? secondManager,
    String? payThePlayers,
    Category? categoryId,
    League? leagueIdAux,
    ResourceFile? logoId,
    ResourceFile? teamPhotoId,
  }) {
    return Team(
      teamId: teamId ?? this.teamId,
      teamName: teamName ?? this.teamName,
      fieldFlag: fieldFlag ?? this.fieldFlag,
      fieldId: fieldId ?? this.fieldId,
      joinRequestAllowed: joinRequestAllowed ?? this.joinRequestAllowed,
      approved: approved ?? this.approved,
      commentsRequest: commentsRequest ?? this.commentsRequest,
      requestPlayers: requestPlayers ?? this.requestPlayers,
      firstManager: firstManager ?? this.firstManager,
      secondManager: secondManager ?? this.secondManager,
      payThePlayers: payThePlayers ?? this.payThePlayers,
      categoryId: categoryId ?? this.categoryId,
      leagueIdAux: leagueIdAux ?? this.leagueIdAux,
      logoId: logoId ?? this.logoId,
      teamPhotoId: teamPhotoId ?? this.teamPhotoId,
    );
  }

  String get teamNameValidated => teamName ?? '';

  @override
  List<Object?> get props => [
        teamId,
        teamName,
        fieldFlag,
        fieldId,
        joinRequestAllowed,
        approved,
        commentsRequest,
        requestPlayers,
        firstManager,
        secondManager,
        payThePlayers,
        categoryId,
        leagueIdAux,
        logoId,
        teamPhotoId,
      ];

  Map<String, dynamic> toJson() => <String, dynamic>{
        "teamId": teamId,
        "teamName": teamName,
        "fieldFlag": fieldFlag,
        "fieldId": fieldId,
        "joinRequestAllowed": joinRequestAllowed,
        "approved": approved,
        "commentsRequest": commentsRequest,
        "requestPlayers": requestPlayers,
        "firstManager": firstManager,
        "secondManager": secondManager,
        "payThePlayers": payThePlayers,
        "categoryId": categoryId?.toJson(),
        "leagueIdAux": leagueIdAux?.toJson(),
        "logoId": logoId?.toJson(),
        "teamPhotoId": teamPhotoId?.toJson(),
      };
}
