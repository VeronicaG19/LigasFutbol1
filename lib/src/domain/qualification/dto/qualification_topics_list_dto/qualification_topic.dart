import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ligas_futbol_flutter/src/domain/qualification/entity/qualification.dart';
import '../../../topic_evaluation/entity/topic_evaluation.dart';

part 'qualification_topic.g.dart';

@JsonSerializable()
class QualificationTopic extends Equatable{
  final String? enabledFlag;
  final int? qualification;
  final Qualification? qualificationId;
  final int? qualificationTopicId;
  final TopicEvaluation? topicEvaluationId;
  final String? topicName;

  const QualificationTopic({
    this.enabledFlag,
    this.qualification,
    this.qualificationId,
    this.qualificationTopicId,
    this.topicEvaluationId,
    this.topicName,
  });

  factory QualificationTopic.fromJson(Map<String, dynamic> json) =>
      _$QualificationTopicFromJson(json);

  Map<String, dynamic> toJson() => _$QualificationTopicToJson(this);

  QualificationTopic copyWith({
    String? enabledFlag,
    int? qualification,
    Qualification? qualificationId,
    int? qualificationTopicId,
    TopicEvaluation? topicEvaluationId,
    String? topicName,
  }) {
    return QualificationTopic(
      enabledFlag: enabledFlag ?? this.enabledFlag,
      qualification: qualification ?? this.qualification,
      qualificationId: qualificationId ?? this.qualificationId,
      qualificationTopicId: qualificationTopicId ?? this.qualificationTopicId,
      topicEvaluationId: topicEvaluationId ?? this.topicEvaluationId,
      topicName: topicName ?? this.topicName,
    );
  }


  @override
  List<Object?> get props => [
    enabledFlag,
    qualification,
    qualificationId,
    qualificationTopicId,
    topicEvaluationId,
    topicName,
  ];
}