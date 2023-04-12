import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'player_image_profile.g.dart';

@JsonSerializable()
class PlayerPhotoId extends Equatable {
  final String? approveResource;
  final int? auxId;
  final String? document;
  final int? fileId;
  final String? fileName;
  final String? fileType;
  final String? mimetype;


  const PlayerPhotoId({
    this.approveResource,
    this.auxId,
    this.document,
    this.fileId,
    this.fileName,
    this.fileType,
    this.mimetype,
  });


  PlayerPhotoId copyWith({
    String? approveResource,
    int? auxId,
    String? document,
    int? fileId,
    String? fileName,
    String? fileType,
    String? mimetype,
  }) {
    return PlayerPhotoId(
      approveResource: approveResource ?? this.approveResource,
      auxId: auxId ?? this.auxId,
      document: document ?? this.document,
      fileId: fileId ?? this.fileId,
      fileName: fileName ?? this.fileName,
      fileType: fileType ?? this.fileType,
      mimetype: mimetype ?? this.mimetype,
    );
  }

   /// Connect the generated [_$PlayerPhotoIdFromJson] function to the `fromJson`
  /// factory.
  factory PlayerPhotoId.fromJson(Map<String, dynamic> json) => _$PlayerPhotoIdFromJson(json);

  /// Connect the generated [_$LeagueToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PlayerPhotoIdToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      approveResource,
      auxId,
      document,
      fileId,
      fileName,
      fileType,
      mimetype,
    ];
  }
}
