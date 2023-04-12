import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ligas_futbol_flutter/src/domain/resource_file/entity/resource_file.dart';

part 'experiences.g.dart';

@JsonSerializable()
class Experiences extends Equatable {
  final int experienceId;
  final int? partyId;
  final String? experiencesTitle;
  final String? experiencesDescription;
  final int? experiencesPosition;
  final String? dateStart;
  final String? dateEnd;
  final String? leagueName;
  final String? tournament;
  final String? teamCategory;
  final String? team;
  final int? typeExperience;
  final String? privacity;
  final ResourceFile? fileId;

  const Experiences({
    required this.experienceId,
    this.partyId,
    this.experiencesTitle,
    this.experiencesDescription,
    this.experiencesPosition,
    this.dateStart,
    this.dateEnd,
    this.leagueName,
    this.tournament,
    this.teamCategory,
    this.team,
    this.typeExperience,
    this.privacity,
    this.fileId,
  });

  /// Connect the generated [_$ExperiencesFromJson] function to the `fromJson`
  /// factory.
  factory Experiences.fromJson(Map<String, dynamic> json) =>
      _$ExperiencesFromJson(json);

  /// Connect the generated [_$ExperiencesToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ExperiencesToJson(this);

  Experiences copyWith({
    int? experienceId,
    int? partyId,
    String? experiencesTitle,
    String? experiencesDescription,
    int? experiencesPosition,
    String? dateStart,
    String? dateEnd,
    String? leagueName,
    String? tournament,
    String? teamCategory,
    String? team,
    int? typeExperience,
    String? privacity,
    ResourceFile? fileId,
  }) {
    return Experiences(
      experienceId: experienceId ?? this.experienceId,
      partyId: partyId ?? this.partyId,
      experiencesTitle: experiencesTitle ?? this.experiencesTitle,
      experiencesDescription:
          experiencesDescription ?? this.experiencesDescription,
      experiencesPosition: experiencesPosition ?? this.experiencesPosition,
      dateStart: dateStart ?? this.dateStart,
      dateEnd: dateEnd ?? this.dateEnd,
      leagueName: leagueName ?? this.leagueName,
      tournament: tournament ?? this.tournament,
      teamCategory: teamCategory ?? this.teamCategory,
      team: team ?? this.team,
      typeExperience: typeExperience ?? this.typeExperience,
      privacity: privacity ?? this.privacity,
      fileId: fileId ?? this.fileId,
    );
  }

  @override
  List<Object?> get props => [
        experienceId,
        partyId,
        experiencesTitle,
        experiencesDescription,
        experiencesPosition,
        dateStart,
        dateEnd,
        leagueName,
        tournament,
        teamCategory,
        team,
        typeExperience,
        privacity,
        fileId,
      ];
}
