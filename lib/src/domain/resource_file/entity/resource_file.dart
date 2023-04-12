import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'resource_file.g.dart';

@JsonSerializable()
class ResourceFile extends Equatable {
  final int? fileId;
  final String? fileName;
  final String? fileType;
  final String? mimetype;
  final String? document;
  final int? auxId;
  final String? approveResource;

  const ResourceFile({
    this.fileId,
    this.fileName,
    this.fileType,
    this.mimetype,
    this.document,
    this.auxId,
    this.approveResource,
  });
  static const empty = ResourceFile();

  /// Connect the generated [_$ResourceFileFromJson] function to the `fromJson`
  /// factory.
  factory ResourceFile.fromJson(Map<String, dynamic> json) =>
      _$ResourceFileFromJson(json);

  /// Connect the generated [_$ResourceFileToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ResourceFileToJson(this);

  factory ResourceFile.buildResourceFile({required String document}) {
    return ResourceFile(document: document);
  }
  ResourceFile copyWith({
    int? fileId,
    String? fileName,
    String? fileType,
    String? mimetype,
    String? document,
    int? auxId,
    String? approveResource,
  }) {
    return ResourceFile(
      fileId: fileId ?? this.fileId,
      fileName: fileName ?? this.fileName,
      fileType: fileType ?? this.fileType,
      mimetype: mimetype ?? this.mimetype,
      document: document ?? this.document,
      auxId: auxId ?? this.auxId,
      approveResource: approveResource ?? this.approveResource,
    );
  }

  @override
  List<Object?> get props => [
        fileId,
        fileName,
        fileType,
        mimetype,
        document,
        auxId,
        approveResource,
      ];
}
