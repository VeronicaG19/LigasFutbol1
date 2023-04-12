import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'result_dto.g.dart';

@JsonSerializable()
class ResultDTO extends Equatable {
  final String? result;

  const ResultDTO({
    this.result,
  });

  ResultDTO copyWith({
    String? result,
  }) {
    return ResultDTO(
      result: result ?? this.result,
    );
  }

  static const empty = ResultDTO();

  /// Connect the generated [_$TournamentFromJson] function to the `fromJson`
  /// factory.
  factory ResultDTO.fromJson(Map<String, dynamic> json) =>
      _$ResultDTOFromJson(json);

  /// Connect the generated [_$TournamentToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ResultDTOToJson(this);

  @override
  List<Object?> get props => [
        result,
      ];
}
