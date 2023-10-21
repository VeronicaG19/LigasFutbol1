import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ligas_futbol_flutter/src/domain/qualification/entity/qualification.dart';
import '../qualification_topics_list_dto/qualification_topic.dart';

part 'save_qualification_dto.g.dart';

@JsonSerializable()
class SaveQualificationDTO extends Equatable{
  final Qualification? qualification;
  final List<QualificationTopic>? qualificationToTopicList;

  const SaveQualificationDTO({
    this.qualification,
    this.qualificationToTopicList,
  });

  factory SaveQualificationDTO.fromJson(Map<String, dynamic> json) =>
      _$SaveQualificationDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SaveQualificationDTOToJson(this);

  SaveQualificationDTO copyWith({
    Qualification? qualification,
    List<QualificationTopic>? qualificationToTopicList,
  }) {
    return SaveQualificationDTO(
      qualification: qualification ?? this.qualification,
      qualificationToTopicList: qualificationToTopicList ?? this.qualificationToTopicList,
    );
  }

  @override
  List<Object?> get props => [
    qualification,
    qualificationToTopicList,
  ];

}