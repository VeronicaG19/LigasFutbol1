import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_team_dto.g.dart';

@JsonSerializable()
class CreateTeamDTO extends Equatable {
  final int? appoved;
  final int? categoryId;
  final int? fiedlId;
  final int? firstManagerId;
  final int? leageAuxId;
  final String? logoImage;
  final int? teamId;
  final String? teamName;
  final String? teamPhothoImage;
  final String? uniformLocalImage;
  final String? uniformVisitImage;

  const CreateTeamDTO({
    this.appoved,
    this.categoryId,
    this.fiedlId,
    this.firstManagerId,
    this.leageAuxId,
    this.logoImage,
    this.teamId,
    this.teamName,
    this.teamPhothoImage,
    this.uniformLocalImage,
    this.uniformVisitImage,
  });

  /// Connect the generated [_$CreateTeamDTOFromJson] function to the `fromJson`
  /// factory.
  factory CreateTeamDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateTeamDTOFromJson(json);

  static const empty = CreateTeamDTO();

  bool get isEmpty => this == CreateTeamDTO.empty;

  bool get isNotEmpty => this != CreateTeamDTO.empty;
  Map<String, dynamic> toJson() => <String, dynamic>{
        "appoved": appoved,
        "categoryId": categoryId,
        "fiedlId": fiedlId,
        "firstManagerId": firstManagerId,
        "leageAuxId": leageAuxId,
        "logoImage": logoImage,
        "teamId": teamId,
        "teamName": teamName,
        "teamPhothoImage": teamPhothoImage,
        "uniformLocalImage": uniformLocalImage,
        "uniformVisitImage": uniformVisitImage,
      };

  CreateTeamDTO copyWith({
    int? appoved,
    int? categoryId,
    int? fiedlId,
    int? firstManagerId,
    int? leageAuxId,
    String? logoImage,
    int? teamId,
    String? teamName,
    String? teamPhothoImage,
    String? uniformLocalImage,
    String? uniformVisitImage,
  }) {
    return CreateTeamDTO(
      appoved: appoved ?? this.appoved,
      categoryId: categoryId ?? this.categoryId,
      fiedlId: fiedlId ?? this.fiedlId,
      firstManagerId: firstManagerId ?? this.firstManagerId,
      leageAuxId: leageAuxId ?? this.leageAuxId,
      logoImage: logoImage ?? this.logoImage,
      teamId: teamId ?? this.teamId,
      teamName: teamName ?? this.teamName,
      teamPhothoImage: teamPhothoImage ?? this.teamPhothoImage,
      uniformLocalImage: uniformLocalImage ?? this.uniformLocalImage,
      uniformVisitImage: uniformVisitImage ?? this.uniformVisitImage,
    );
  }

  @override
  List<Object?> get props => [
        appoved,
        categoryId,
        fiedlId,
        firstManagerId,
        leageAuxId,
        logoImage,
        teamId,
        teamName,
        teamPhothoImage,
        uniformLocalImage,
        uniformVisitImage,
      ];
}
