import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'qualification.g.dart';

@JsonSerializable()
class Qualification extends Equatable {
  final String? comments;
  final String? enabledFlag;
  final int? entityIdEvaluated;
  final int? entityIdEvaluator;
  final int? leagueId;
  final int? matchId;
  final int? qualificationId;
  final int? teamPlayerId;
  final String? typeEvaluation;
  final String? nameEvaluator;
  final String? nameEvaluated;
  @JsonKey(name: "qualification")
  final double? rating;

  const Qualification({
    this.comments,
    this.enabledFlag,
    this.entityIdEvaluated,
    this.entityIdEvaluator,
    this.leagueId,
    this.matchId,
    this.qualificationId,
    this.teamPlayerId,
    this.typeEvaluation,
    this.nameEvaluator,
    this.nameEvaluated,
    this.rating,
  });

  factory Qualification.fromJson(Map<String, dynamic> json) =>
      _$QualificationFromJson(json);

  Map<String, dynamic> toJson() => _$QualificationToJson(this);

  Qualification copyWith({
    String? comments,
    String? enabledFlag,
    int? entityIdEvaluated,
    int? entityIdEvaluator,
    int? leagueId,
    int? matchId,
    int? qualificationId,
    int? teamPlayerId,
    String? typeEvaluation,
    String? nameEvaluator,
    String? nameEvaluated,
    double? rating,
  }) {
    return Qualification(
      comments: comments ?? this.comments,
      enabledFlag: enabledFlag ?? this.enabledFlag,
      entityIdEvaluated: entityIdEvaluated ?? this.entityIdEvaluated,
      entityIdEvaluator: entityIdEvaluator ?? this.entityIdEvaluator,
      leagueId: leagueId ?? this.leagueId,
      matchId: matchId ?? this.matchId,
      qualificationId: qualificationId ?? this.qualificationId,
      teamPlayerId: teamPlayerId ?? this.teamPlayerId,
      typeEvaluation: typeEvaluation ?? this.typeEvaluation,
      nameEvaluator: nameEvaluator ?? this.nameEvaluator,
      nameEvaluated: nameEvaluated ?? this.nameEvaluated,
      rating: rating ?? this.rating,
    );
  }

  static const empty = Qualification();

  String get getEvaluation => _getEvaluationType();

  String _getEvaluationType() {
    switch (typeEvaluation) {
      case 'PLAYER_TO_REFERE':
        return 'Jugador';
      case 'PLAYER_TO_FIELD':
        return 'Jugador';
      case 'REFEREE_TO_PLAYER':
        return 'Árbitro';
      case 'REFEREE_TO_TEAM':
        return 'Árbitro';
      case 'REFEREE_TO_FIELD':
        return 'Árbitro';
      case 'FIELD_TO_MATCH':
        return 'Dueño de campo';
      default:
        return '';
    }
  }

  @override
  List<Object?> get props => [
        comments,
        enabledFlag,
        entityIdEvaluated,
        entityIdEvaluator,
        leagueId,
        matchId,
        qualificationId,
        teamPlayerId,
        typeEvaluation,
        nameEvaluator,
        nameEvaluated,
        rating,
      ];
}
