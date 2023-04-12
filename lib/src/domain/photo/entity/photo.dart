import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'photo.g.dart';

/*
 * Entity from Match
 */
@JsonSerializable()
class Photo extends Equatable{

  final String? approveResource;
  final int? auxId;
  final String? document;
  final String? enabledFlag;
  final int? fileId;
  final String? fileName;
  final String? fileType;
  final String? mimetype;
  const Photo({
    this.approveResource,
    this.auxId,
    this.document,
    this.enabledFlag,
    this.fileId,
    this.fileName,
    this.fileType,
    this.mimetype,
  });

  Photo copyWith({
    String? approveResource,
    int? auxId,
    String? document,
    String? enabledFlag,
    int? fileId,
    String? fileName,
    String? fileType,
    String? mimetype,
  }) {
    return Photo(
      approveResource: approveResource ?? this.approveResource,
      auxId: auxId ?? this.auxId,
      document: document ?? this.document,
      enabledFlag: enabledFlag ?? this.enabledFlag,
      fileId: fileId ?? this.fileId,
      fileName: fileName ?? this.fileName,
      fileType: fileType ?? this.fileType,
      mimetype: mimetype ?? this.mimetype,
    );
  }

  /// Connect the generated [_$PhotoFromJson] function to the `fromJson`
  /// factory.
  factory Photo.fromJson(Map<String, dynamic> json) =>
      _$PhotoFromJson(json);

  /// Connect the generated [_$PhotoToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PhotoToJson(this);

  @override
  List<Object?> get props => [
      approveResource,
      auxId,
      document,
      enabledFlag,
      fileId,
      fileName,
      fileType,
      mimetype,
    ];
}