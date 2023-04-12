// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'uniform.g.dart';

@JsonSerializable()
class Uniform extends Equatable {
  final int? teamId;
  final String? uniformLocalImage;
  final String? uniformVisitImage;

  const Uniform({
    this.teamId,
    this.uniformLocalImage,
    this.uniformVisitImage,
  });

  Uniform copyWith({
    int? teamId,
    String? uniformLocalImage,
    String? uniformVisitImage,
  }) {
    return Uniform(
      teamId: teamId ?? this.teamId,
      uniformLocalImage: uniformLocalImage ?? this.uniformLocalImage,
      uniformVisitImage: uniformVisitImage ?? this.uniformVisitImage,
    );
  }

  static const empty = Uniform();

  /// Connect the generated [_$TournamentFromJson] function to the `fromJson`
  /// factory.
  factory Uniform.fromJson(Map<String, dynamic> json) =>
      _$UniformFromJson(json);

  /// Connect the generated [_$TournamentToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UniformToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      teamId,
      uniformLocalImage,
      uniformVisitImage,
    ];
  }
}
