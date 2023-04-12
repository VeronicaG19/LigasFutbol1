import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team_league_manager_dto.g.dart';

@JsonSerializable()
class TeamLeagueManagerDTO extends Equatable {
  final int? teamId;
  final int? categoryId;
  final String? teamName;
  final int? leagueId;
  final int? logoId;
  final String? logo;
  final String? fieldFlag;
  final int? fieldId;
  final String? joinRequestAllowed;
  final int? leagueIdAux;
  final int? approved;
  final String? commentsRequest;
  final String? requestPlayers;

  final int? firstManager;
  final int? secondManager;
  final String? payThePlayers;

  final int? teamPhotoId;

  const TeamLeagueManagerDTO({
    this.teamId,
    this.categoryId,
    this.teamName,
    this.leagueId,
    this.logoId,
    this.logo,
    this.fieldFlag,
    this.fieldId,
    this.joinRequestAllowed,
    this.leagueIdAux,
    this.approved,
    this.commentsRequest,
    this.requestPlayers,
    this.firstManager,
    this.secondManager,
    this.payThePlayers,
    this.teamPhotoId,
  });

  /// Connect the generated [_$TeamLeagueManagerDTOFromJson] function to the `fromJson`
  /// factory.
  factory TeamLeagueManagerDTO.fromJson(Map<String, dynamic> json) =>
      _$TeamLeagueManagerDTOFromJson(json);

  static const empty = TeamLeagueManagerDTO();

  bool get isEmpty => this == TeamLeagueManagerDTO.empty;

  bool get isNotEmpty => this != TeamLeagueManagerDTO.empty;
  String get teamNameValidated => teamName ?? '';
  Map<String, dynamic> toJson() => <String, dynamic>{
        "teamId": teamId,
        "categoryId": categoryId,
        "teamName": teamName,
        "leagueId": leagueId,
        "logoId": logoId,
        "logo": logo,
        "fieldFlag": fieldFlag,
        "fieldId": fieldId,
        "joinRequestAllowed": joinRequestAllowed,
        "leagueIdAux": leagueIdAux,
        "approved": approved,
        "commentsRequest": commentsRequest,
        "requestPlayers": requestPlayers,
        "firstManager": firstManager,
        "secondManager": secondManager,
        "payThePlayers": payThePlayers,
        "teamPhotoId": teamPhotoId,
      };

  TeamLeagueManagerDTO copyWith({
    int? teamId,
    int? categoryId,
    String? teamName,
    int? leagueId,
    int? logoId,
    String? logo,
    String? fieldFlag,
    int? fieldId,
    String? joinRequestAllowed,
    int? leagueIdAux,
    int? approved,
    String? commentsRequest,
    String? requestPlayers,
    int? firstManager,
    int? secondManager,
    String? payThePlayers,
    int? teamPhotoId,
  }) {
    return TeamLeagueManagerDTO(
      teamId: teamId ?? this.teamId,
      categoryId: categoryId ?? this.categoryId,
      teamName: teamName ?? this.teamName,
      leagueId: leagueId ?? this.leagueId,
      logoId: logoId ?? this.logoId,
      logo: logo ?? this.logo,
      fieldFlag: fieldFlag ?? this.fieldFlag,
      fieldId: fieldId ?? this.fieldId,
      joinRequestAllowed: joinRequestAllowed ?? this.joinRequestAllowed,
      leagueIdAux: leagueIdAux ?? this.leagueIdAux,
      approved: approved ?? this.approved,
      commentsRequest: commentsRequest ?? this.commentsRequest,
      requestPlayers: requestPlayers ?? this.requestPlayers,
      firstManager: firstManager ?? this.firstManager,
      secondManager: secondManager ?? this.secondManager,
      payThePlayers: payThePlayers ?? this.payThePlayers,
      teamPhotoId: teamPhotoId ?? this.teamPhotoId,
    );
  }

  @override
  List<Object?> get props => [
        teamId,
        categoryId,
        teamName,
        leagueId,
        logoId,
        logo,
        fieldFlag,
        fieldId,
        joinRequestAllowed,
        leagueIdAux,
        approved,
        commentsRequest,
        requestPlayers,
        firstManager,
        secondManager,
        payThePlayers,
        teamPhotoId,
      ];
}
