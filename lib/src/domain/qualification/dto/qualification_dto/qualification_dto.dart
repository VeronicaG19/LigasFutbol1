import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'qualification_dto.g.dart';

@JsonSerializable()
class QualificationDTO extends Equatable {
  final String? comments;
  final int? evaluatedId;
  final int? evaluatorId;
  final int? matchId;
  final String? nameEvaluator;
  final String? nameEvaluated;
  @JsonKey(name: "qualification")
  final int? rating;
  final int? qualificationId;
  final String? typeEvaluation;

  const QualificationDTO({
    this.comments,
    this.evaluatedId,
    this.evaluatorId,
    this.matchId,
    this.nameEvaluator,
    this.nameEvaluated,
    this.rating,
    this.qualificationId,
    this.typeEvaluation,
  });
  static const empty = QualificationDTO();
  String get getEvaluation => _getEvaluationType();
  String _getEvaluationType() {
    switch (typeEvaluation) {
      case 'PLAYER_TO_REFERE':
        return 'árbitro';
      case 'PLAYER_TO_FIELD':
        return 'dueño de campo';
      case 'REFEREE_TO_PLAYER':
        return 'jugador';
      case 'REFEREE_TO_TEAM':
        return 'equipo';
      case 'REFEREE_TO_FIELD':
        return 'dueño de campo';
      case 'FIELD_TO_MATCH':
        return 'partido';
      default:
        return '';
    }
  }

  factory QualificationDTO.fromJson(Map<String, dynamic> json) =>
      _$QualificationDTOFromJson(json);

  Map<String, dynamic> toJson() => _$QualificationDTOToJson(this);

  QualificationDTO copyWith({
    String? comments,
    int? evaluatedId,
    int? evaluatorId,
    int? matchId,
    String? nameEvaluator,
    String? nameEvaluated,
    int? rating,
    int? qualificationId,
    String? typeEvaluation,
  }) {
    return QualificationDTO(
      comments: comments ?? this.comments,
      evaluatedId: evaluatedId ?? this.evaluatedId,
      evaluatorId: evaluatorId ?? this.evaluatorId,
      matchId: matchId ?? this.matchId,
      nameEvaluator: nameEvaluator ?? this.nameEvaluator,
      nameEvaluated: nameEvaluated ?? this.nameEvaluated,
      rating: rating ?? this.rating,
      qualificationId: qualificationId ?? this.qualificationId,
      typeEvaluation: typeEvaluation ?? this.typeEvaluation,
    );
  }

  @override
  List<Object?> get props => [
        comments,
        evaluatedId,
        evaluatorId,
        matchId,
        nameEvaluator,
        nameEvaluated,
        rating,
        qualificationId,
        typeEvaluation,
      ];
}
