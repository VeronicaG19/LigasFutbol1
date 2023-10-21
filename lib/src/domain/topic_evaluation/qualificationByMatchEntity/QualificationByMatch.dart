import 'package:equatable/equatable.dart';

class QualificationByMatch extends Equatable {
  const QualificationByMatch(
      {required this.matchId,
      required this.qualification,
      required this.topic,
      required this.typeEvaluation,
      this.eventId});

  final int? matchId;
  final double? qualification;
  final String? topic;
  final String? typeEvaluation;
  final int? eventId;

  QualificationByMatch copyWith(
      {int? matchId,
      double? qualification,
      String? topic,
      String? typeEvaluation,
      int? eventId}) {
    return QualificationByMatch(
        matchId: matchId ?? this.matchId,
        qualification: qualification ?? this.qualification,
        topic: topic ?? this.topic,
        typeEvaluation: typeEvaluation ?? this.typeEvaluation,
        eventId: eventId ?? this.eventId);
  }

  factory QualificationByMatch.fromJson(Map<String, dynamic> json) {
    return QualificationByMatch(
      matchId: json["matchId"],
      qualification: json["qualification"],
      topic: json["topic"],
      typeEvaluation: json["typeEvaluation"],
    );
  }

  Map<String, dynamic> toJson() => {
        "matchId": matchId,
        "qualification": qualification,
        "topic": topic,
        "typeEvaluation": typeEvaluation,
      };

  @override
  String toString() {
    return "$matchId, $qualification, $topic, $typeEvaluation, $eventId";
  }

  @override
  List<Object?> get props =>
      [matchId, qualification, topic, typeEvaluation, eventId];
}
