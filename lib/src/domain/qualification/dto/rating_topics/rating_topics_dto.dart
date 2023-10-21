import 'package:freezed_annotation/freezed_annotation.dart';

part 'rating_topics_dto.freezed.dart';
part 'rating_topics_dto.g.dart';

@freezed
class RatingTopicsDTO with _$RatingTopicsDTO {
  const factory RatingTopicsDTO({
    final int? matchId,
    @Default('') final String topic,
    @Default('') final String typeEvaluation,
    @Default('') final String description,
    @JsonKey(name: "qualification") @Default(0.0) final double rating,
  }) = _RatingTopicsDTO;

  const RatingTopicsDTO._();

  factory RatingTopicsDTO.fromJson(Map<String, dynamic> json) =>
      _$RatingTopicsDTOFromJson(json);

  static const empty = RatingTopicsDTO();

  bool get isEmpty => this == empty;

  bool get isNotEmpty => this != empty;
}
