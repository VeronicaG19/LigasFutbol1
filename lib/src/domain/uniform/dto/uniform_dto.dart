import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'uniform_dto.g.dart';

@JsonSerializable()
class UniformDto extends Equatable {
  final int? fileShortId;
  final int? fileTshirtId;
  final int? teamId;
  final String? teamName;
  final int? uniformId;
  final int? uniformShortId;
  final String? uniformShortImage;
  final int? uniformTshirtId;
  final String? uniformTshirtImage;
  final String? uniformType;

  const UniformDto({
    this.fileShortId,
    this.fileTshirtId,
    this.teamId,
    this.teamName,
    this.uniformId,
    this.uniformShortId,
    this.uniformShortImage,
    this.uniformTshirtId,
    this.uniformTshirtImage,
    this.uniformType,
  });

  UniformDto copyWith({
    int? fileShortId,
    int? fileTshirtId,
    int? teamId,
    String? teamName,
    int? uniformId,
    int? uniformShortId,
    String? uniformShortImage,
    int? uniformTshirtId,
    String? uniformTshirtImage,
    String? uniformType,
  }) {
    return UniformDto(
      fileShortId: fileShortId ?? this.fileShortId,
      fileTshirtId: fileTshirtId ?? this.fileTshirtId,
      teamId: teamId ?? this.teamId,
      teamName: teamName ?? this.teamName,
      uniformId: uniformId ?? this.uniformId,
      uniformShortId: uniformShortId ?? this.uniformShortId,
      uniformShortImage: uniformShortImage ?? this.uniformShortImage,
      uniformTshirtId: uniformTshirtId ?? this.uniformTshirtId,
      uniformTshirtImage: uniformTshirtImage ?? this.uniformTshirtImage,
      uniformType: uniformType ?? this.uniformType,
    );
  }

  static const empty = UniformDto();

  /// Connect the generated [_$TournamentFromJson] function to the `fromJson`
  /// factory.
  factory UniformDto.fromJson(Map<String, dynamic> json) =>
      _$UniformDtoFromJson(json);

  /// Connect the generated [_$TournamentToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UniformDtoToJson(this);

  @override
  List<Object?> get props {
    return [
      fileShortId,
      fileTshirtId,
      teamId,
      teamName,
      uniformId,
      uniformShortId,
      uniformShortImage,
      uniformTshirtId,
      uniformTshirtImage,
      uniformType,
    ];
  }
}
