import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ligas_futbol_flutter/src/domain/leagues/entity/league.dart';
import 'package:ligas_futbol_flutter/src/domain/resource_file/entity/resource_file.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/entity/tournament.dart';

part 'document.g.dart';

@JsonSerializable()
class Document extends Equatable {
  final int documentId;
  final int? documentType;
  final ResourceFile? documentFileId;
  final League? leagueId;
  final Tournament? tournamentId;

  const Document({
    required this.documentId,
    this.documentType,
    this.documentFileId,
    this.leagueId,
    this.tournamentId,
  });

  /// Connect the generated [_$DocumentFromJson] function to the `fromJson`
  /// factory.
  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);

  /// Connect the generated [_$DocumentToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DocumentToJson(this);

  Document copyWith({
    int? documentId,
    int? documentType,
    ResourceFile? documentFileId,
    League? leagueId,
    Tournament? tournamentId,
  }) {
    return Document(
      documentId: documentId ?? this.documentId,
      documentType: documentType ?? this.documentType,
      documentFileId: documentFileId ?? this.documentFileId,
      leagueId: leagueId ?? this.leagueId,
      tournamentId: tournamentId ?? this.tournamentId,
    );
  }

  @override
  List<Object?> get props => [
        documentId,
        documentType,
        documentFileId,
        leagueId,
        tournamentId,
      ];
}
