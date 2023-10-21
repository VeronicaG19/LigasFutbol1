import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'topic_evaluation.g.dart';

@JsonSerializable()
class TopicEvaluation extends Equatable{

  final String? description;
  final String? enabledFlag;
  final String? global;
  final int? secuence;
  final String? topic;
  final int? topicEvaluationId;
  final String? type;

  const TopicEvaluation({
    this.description,
    this.enabledFlag,
    this.global,
    this.secuence,
    this.topic,
    this.topicEvaluationId,
    this.type,
  });
  factory TopicEvaluation.fromJson(Map<String, dynamic> json) => _$TopicEvaluationFromJson(json);

  Map<String, dynamic> toJson() => _$TopicEvaluationToJson(this);

  TopicEvaluation copyWith({
    String? description,
    String? enabledFlag,
    String? global,
    int? secuence,
    String? topic,
    int? topicEvaluationId,
    String? type,
  }) {
  return TopicEvaluation(
    description: description ?? this.description,
    enabledFlag: enabledFlag ?? this.enabledFlag,
    global: global ?? this.global,
    secuence: secuence ?? this.secuence,
    topic: topic ?? this.topic,
    topicEvaluationId: topicEvaluationId ?? this.topicEvaluationId,
    type: type ?? this.type,
  );
}
  @override
  List<Object?> get props => [
    description,
    enabledFlag,
    global,
    secuence,
    topic,
    topicEvaluationId,
    type,
  ];

}